import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rewear/config/app_init.dart';
import 'package:rewear/generals/images.dart';

class PinLocationBloc extends GetxController {
  final app = AppInit();
  var markers = [].obs;
  GoogleMapController? mapController;
  LatLng? currentPosition;

  void initMarkers() async {
    final me = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(), MyImages.youPin);
    final Marker _mySelf = Marker(
        // onTap: () {},
        infoWindow: const InfoWindow(title: 'You', snippet: "you're here..."),
        markerId: const MarkerId('me'),
        position: LatLng(
            app.currentPosition!.latitude, app.currentPosition!.longitude),
        icon: me);

    markers.value.clear();
    markers.value.add(_mySelf);
  }

  showMe() {
    mapController!.moveCamera(CameraUpdate.newLatLng(currentPosition!));
  }

  @override
  void onInit() {
    currentPosition = app.user.position ??
        LatLng(app.currentPosition!.latitude, app.currentPosition!.longitude);
    super.onInit();
  }
}
