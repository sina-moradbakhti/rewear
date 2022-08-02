import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rewear/blocs/nearby.bloc.dart';
import 'package:rewear/config/app_init.dart';
import 'package:rewear/generals/widgets/customAppbar.widget.dart';
import 'package:rewear/views/tailorsNearby/tailorySlideshow.widget.dart';

class TailorsNearby extends StatefulWidget {
  const TailorsNearby({Key? key}) : super(key: key);

  @override
  State<TailorsNearby> createState() => _TailorsNearbyState();
}

class _TailorsNearbyState extends State<TailorsNearby>
    with AutomaticKeepAliveClientMixin {
  final bloc = Get.put(NearbyBloc());

  @override
  Widget build(BuildContext context) {
    return bloc.appBar
        ? Scaffold(
            appBar: const CustomAppbar(
              title: Text('Choose Tailory'),
              main: false,
            ),
            body: _body,
          )
        : Scaffold(
            body: _body,
          );
  }

  Widget get _body => Obx(() {
        return Stack(
          children: [
            GoogleMap(
                initialCameraPosition:
                    CameraPosition(target: bloc.myPosition, zoom: 17),
                onMapCreated: (controller) {
                  controller.setMapStyle(AppInit.googleMapStyle01);
                },
                compassEnabled: false,
                myLocationButtonEnabled: false,
                trafficEnabled: false,
                buildingsEnabled: false,
                indoorViewEnabled: false,
                markers: {for (var item in bloc.markers.value) item},
                mapType: MapType.normal),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 105),
                child: Container(
                  width: double.infinity,
                  height: 200,
                  child: const TailorySlideshowWidget(),
                ),
              ),
            ),
          ],
        );
      });

  @override
  bool get wantKeepAlive => true;
}
