import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rewear/config/app_init.dart';

class TailorsNearby extends StatelessWidget {
  const TailorsNearby({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
          initialCameraPosition: const CameraPosition(
              target: LatLng(43.846278, -79.415929), zoom: 14),
          onMapCreated: (controller) {
            print('Hereeee');

            controller.setMapStyle(AppInit.googleMapStyle01);
          },
          compassEnabled: false,
          myLocationButtonEnabled: false,
          trafficEnabled: false,
          buildingsEnabled: false,
          indoorViewEnabled: false,
          mapType: MapType.normal),
    );
  }
}
