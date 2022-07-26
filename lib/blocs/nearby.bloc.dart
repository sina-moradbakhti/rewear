import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rewear/generals/images.dart';

class NearbyBloc extends GetxController {
  var markers = [].obs;

  void initMArkers() async {
    final me = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(), MyImages.youPin);
    final retail = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(), MyImages.retailPin);
    Marker _marker = Marker(
        // onTap: () {},
        infoWindow: const InfoWindow(title: 'You', snippet: "you're here..."),
        markerId: const MarkerId('myMarkerId'),
        position: const LatLng(43.846278, -79.415929),
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

    markers.add(_marker);
    markers.add(_marker1);
    markers.add(_marker2);
    markers.add(_marker3);
  }
}
