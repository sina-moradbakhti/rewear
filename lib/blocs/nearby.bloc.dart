import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rewear/config/app_init.dart';
import 'package:rewear/generals/images.dart';
import 'package:rewear/models/order.dart';

class NearbyBloc extends GetxController {
  var markers = [].obs;
  bool appBar = false;
  Order? order;

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
        position: const LatLng(43.846778, -79.415929),
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

  @override
  void onInit() {
    order = Get.arguments;
    if (order != null) {
      appBar = true;
    }
    initMarkers();
    super.onInit();
  }
}
