import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:rewear/blocs/home.bloc.dart';
import 'package:rewear/config/app_init.dart';
import 'package:rewear/generals/images.dart';
import 'package:rewear/generals/modals/confirmTailory.modal.dart';
import 'package:rewear/generals/modals/congrats.modal.dart';
import 'package:rewear/models/tailor.dart';
import 'package:rewear/services/init.dart';
import 'package:rewear/services/requests.dart';

class NearbyBloc extends GetxController {
  var markers = [].obs;
  String? requestId;
  GoogleMapController? mapController;
  RxBool myLocationLoading = false.obs;
  final app = AppInit();
  final services = RequestsServices();
  final initService = InitService();

  LatLng get myPosition => LatLng(
      app.user.position?.latitude ?? 0, app.user.position?.longitude ?? 0);

  LatLng _getRandom() {
    final rng = Random();
    double lat = rng.nextDouble() * 100;
    double lng = rng.nextDouble() * 100;

    return LatLng(lat, lng);
  }

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
    for (final item in app.tailors) {
      _markers.add(Marker(
          infoWindow:
              InfoWindow(title: item.fullname ?? '', snippet: item.phone ?? ''),
          markerId: MarkerId('${item.uid}'),
          position: item.position ?? _getRandom(),
          alpha: 1,
          icon: retail));
    }
    if (app.user.position != null) {
      _markers.add(_mySelf);
    }
    markers.addAll(_markers);
  }

  void moveTo(Tailor where, {makeOrder = false, bool scrolled = false}) async {
    // final homeBloc = Get.find<HomeBloc>();
    mapController?.moveCamera(CameraUpdate.newLatLng(
        LatLng(where.position!.latitude, where.position!.longitude)));
    // homeBloc.currentCity.value = '${where.city} ${where.country}';

    if (makeOrder && !scrolled) {
      await Future.delayed(const Duration(milliseconds: 300));
      Get.dialog(ConfirmTailoryDialog(onYepClicked: () => makeRequest(where)),
          useSafeArea: true,
          barrierColor: Colors.black87,
          transitionCurve: Curves.easeInOut,
          barrierDismissible: true);
    }
  }

  void makeRequest(Tailor tailor) async {
    try {
      await services.updateRequestChooseSeller(
          reqId: requestId!,
          sellerId: tailor.uid!,
          fcmToken: tailor.fcmToken ?? '');
      await initService.call();
      app.notifyUserBySocket(
          app.requests.firstWhere((element) => element.id == requestId));
      Get.back();
      Get.dialog(const CongratsDialog(),
          useSafeArea: true,
          barrierColor: Colors.black87,
          transitionCurve: Curves.easeInOut);
    } catch (er) {
      Get.back();
      app.handleError(er);
    }
  }

  void showMe() async {
    // final homeBloc = Get.find<HomeBloc>();
    myLocationLoading.value = true;
    if (app.user.position == null) {
      await app.updateLastLocation(isBackground: false);
    }

    if (app.user.position != null) {
      mapController?.moveCamera(CameraUpdate.newLatLng(app.user.position!));
      //homeBloc.currentCity.value = '${app.user.city} ${app.user.country}';
    }

    myLocationLoading.value = false;
  }

  @override
  void onInit() {
    requestId = Get.arguments;
    initMarkers();
    super.onInit();
  }
}
