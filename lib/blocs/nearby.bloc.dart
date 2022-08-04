import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rewear/blocs/home.bloc.dart';
import 'package:rewear/config/app_init.dart';
import 'package:rewear/generals/images.dart';
import 'package:rewear/generals/modals/confirmTailory.modal.dart';
import 'package:rewear/models/order.dart';
import 'package:rewear/services/general.services.dart';

class NearbyBloc extends GetxController {
  var markers = [].obs;
  Order? order;
  GoogleMapController? mapController;
  RxBool myLocationLoading = false.obs;

  LatLng get myPosition => LatLng(AppInit().user.position?.latitude ?? 0,
      AppInit().user.position?.longitude ?? 0);

  void initMarkers() async {
    final me = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(), MyImages.youPin);
    final retail = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(), MyImages.retailPin);
    Marker _mySelf = Marker(
        // onTap: () {},
        infoWindow: const InfoWindow(title: 'You', snippet: "you're here..."),
        markerId: const MarkerId('myMarkerId'),
        position: myPosition,
        icon: me);

    Marker _marker1 = Marker(
        infoWindow:
            const InfoWindow(title: 'Tailory 1', snippet: "+1 443 232 5566"),
        markerId: const MarkerId('myMarkerId1'),
        position: const LatLng(45.5616284, -73.6056387),
        icon: retail);

    Marker _marker2 = Marker(
        infoWindow:
            const InfoWindow(title: 'Tailory 2', snippet: "+1 443 232 5566"),
        alpha: 0.4,
        markerId: const MarkerId('myMarkerId2'),
        position: const LatLng(43.846378, -79.415729),
        icon: retail);

    Marker _marker3 = Marker(
        infoWindow:
            const InfoWindow(title: 'Tailory 3', snippet: "+1 443 232 5566"),
        alpha: 0.4,
        markerId: const MarkerId('myMarkerId3'),
        position: const LatLng(43.845278, -79.415829),
        icon: retail);

    if (AppInit().user.position != null) {
      markers.add(_mySelf);
    }

    markers.add(_marker1);
    markers.add(_marker2);
    markers.add(_marker3);
  }

  void moveTo(double lat, double lng, {makeOrder = false}) async {
    mapController?.moveCamera(CameraUpdate.newLatLng(LatLng(lat, lng)));
    if (makeOrder) {
      await Future.delayed(const Duration(milliseconds: 300));
      Get.dialog(const ConfirmTailoryDialog(),
          useSafeArea: true,
          barrierColor: Colors.black87,
          transitionCurve: Curves.easeInOut);
    }
  }

  void showMe() async {
    myLocationLoading.value = true;
    await GeneralServices().geoCoding(const LatLng(45.5616284, -73.6056387));
    if (AppInit().user.position == null) {
      await AppInit().updateLastLocation(isBackground: false);
    }

    if (AppInit().user.position != null) {
      mapController
          ?.moveCamera(CameraUpdate.newLatLng(AppInit().user.position!));
    }

    final homeBloc = Get.put(HomeBloc());
    homeBloc.currentCity.value = 'Updated';

    myLocationLoading.value = false;
  }

  @override
  void onInit() {
    initMarkers();
    super.onInit();
  }
}
