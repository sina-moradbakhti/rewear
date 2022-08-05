import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rewear/blocs/home.bloc.dart';
import 'package:rewear/config/app_init.dart';
import 'package:rewear/config/mock_data.dart';
import 'package:rewear/generals/images.dart';
import 'package:rewear/generals/modals/confirmTailory.modal.dart';
import 'package:rewear/models/order.dart';
import 'package:rewear/models/tailor.dart';

class NearbyBloc extends GetxController {
  var markers = [].obs;
  Order? order;
  GoogleMapController? mapController;
  RxBool myLocationLoading = false.obs;
  final homeBloc = Get.put(HomeBloc());

  LatLng get myPosition => LatLng(AppInit().user.position?.latitude ?? 0,
      AppInit().user.position?.longitude ?? 0);

  void initMarkers() async {
    final me = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(), MyImages.youPin);
    final retail = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(), MyImages.retailPin);
    final Marker _mySelf = Marker(
        // onTap: () {},
        infoWindow: const InfoWindow(title: 'You', snippet: "you're here..."),
        markerId: const MarkerId('me'),
        position: myPosition,
        icon: me);

    var _markers = [];
    for (final item in MockData().tailories) {
      _markers.add(Marker(
          infoWindow:
              InfoWindow(title: item.fullname ?? '', snippet: item.phone ?? ''),
          markerId: MarkerId('${item.uid}'),
          position: item.position!,
          alpha: 1,
          icon: retail));
    }
    if (AppInit().user.position != null) {
      _markers.add(_mySelf);
    }
    markers.addAll(_markers);
  }

  void moveTo(Tailor where, {makeOrder = false, bool scrolled = false}) async {
    mapController?.moveCamera(CameraUpdate.newLatLng(
        LatLng(where.position!.latitude, where.position!.longitude)));
    homeBloc.currentCity.value = '${where.city} ${where.country}';

    if (makeOrder && !scrolled) {
      await Future.delayed(const Duration(milliseconds: 300));
      Get.dialog(const ConfirmTailoryDialog(),
          useSafeArea: true,
          barrierColor: Colors.black87,
          transitionCurve: Curves.easeInOut);
    }
  }

  void showMe() async {
    myLocationLoading.value = true;
    if (AppInit().user.position == null) {
      await AppInit().updateLastLocation(isBackground: false);
    }

    if (AppInit().user.position != null) {
      mapController
          ?.moveCamera(CameraUpdate.newLatLng(AppInit().user.position!));
      homeBloc.currentCity.value =
          '${AppInit().user.city} ${AppInit().user.country}';
    }

    myLocationLoading.value = false;
  }

  @override
  void onInit() {
    initMarkers();
    super.onInit();
  }
}
