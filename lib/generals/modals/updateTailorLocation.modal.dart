import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rewear/blocs/pinLocation.bloc.dart';
import 'package:rewear/config/app_init.dart';
import 'package:rewear/generals/buttons.dart';
import 'package:rewear/generals/colors.dart';
import 'package:rewear/generals/constants.dart';

class UpdateTailorLocationDialog extends StatelessWidget {
  final Function(LatLng?) onReturnLocation;
  UpdateTailorLocationDialog({Key? key, required this.onReturnLocation})
      : super(key: key);

  final bloc = Get.put(PinLocationBloc());

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: const EdgeInsets.all(24),
      content: Container(
        color: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Pin Location",
              style: Get.theme.textTheme.headline5!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: MyConstants.topPadding,
              child: Text(
                "Pin your tailory's location on the map in order showing you to customers.",
                style: Get.theme.textTheme.bodyText1,
              ),
            ),
            Padding(
              padding: MyConstants.topPadding,
              child: SizedBox(
                height: (Get.size.height - 150) / 2.5,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    GoogleMap(
                      myLocationButtonEnabled: false,
                      trafficEnabled: false,
                      buildingsEnabled: true,
                      indoorViewEnabled: false,
                      mapType: MapType.normal,
                      onCameraMove: (position) =>
                          bloc.currentPosition = position.target,
                      onMapCreated: (controller) {
                        controller.setMapStyle(AppInit.googleMapStyle01);
                        bloc.mapController = controller;
                        bloc.showMe();
                      },
                      initialCameraPosition: CameraPosition(
                          zoom: 16, target: bloc.currentPosition!),
                    ),
                    Transform.translate(
                        offset: const Offset(0, -10),
                        child: Icon(
                          Icons.location_on,
                          color: MyColors.orange,
                          size: 35,
                        ))
                  ],
                ),
              ),
            ),
            Padding(
                padding: MyConstants.topDoublePadding,
                child: MyPrimaryButton(
                  onPressed: () {
                    onReturnLocation(bloc.currentPosition);
                    Get.back();
                  },
                  title: 'Pick Location',
                ))
          ],
        ),
      ),
    );
  }
}
