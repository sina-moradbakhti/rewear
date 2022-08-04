import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rewear/blocs/nearby.bloc.dart';
import 'package:rewear/config/app_init.dart';
import 'package:rewear/generals/colors.dart';
import 'package:rewear/generals/widgets/customAppbar.widget.dart';
import 'package:rewear/generals/widgets/loading.widget.dart';
import 'package:rewear/views/tailorsNearby/tailorySlideshow.widget.dart';

class TailorsNearby extends StatefulWidget {
  const TailorsNearby({Key? key}) : super(key: key);

  @override
  State<TailorsNearby> createState() => _TailorsNearbyState();
}

class _TailorsNearbyState extends State<TailorsNearby>
    with AutomaticKeepAliveClientMixin {
  final bloc = Get.put(NearbyBloc());

  bool _showAppbar = true;

  @override
  void initState() {
    if (Get.arguments != null) {
      _showAppbar = false;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return !_showAppbar
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
                  bloc.mapController = controller;
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
                padding: EdgeInsets.only(bottom: _showAppbar ? 105 : 20),
                child: Container(
                  clipBehavior: Clip.none,
                  width: double.infinity,
                  height: 180,
                  child: Center(
                      child: SizedBox(
                          height: 155,
                          child: TailorySlideshowWidget(
                            onTappedItem: (location) => bloc.moveTo(
                                location.latitude, location.longitude,
                                makeOrder: !_showAppbar),
                          ))),
                ),
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.only(bottom: _showAppbar ? 115 : 30, right: 16),
              child: Align(
                alignment: Alignment.bottomRight,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: bloc.showMe,
                    icon: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(width: 1, color: MyColors.grey)),
                      width: 50,
                      height: 50,
                      child: Center(
                        child: Obx(() => bloc.myLocationLoading.value
                            ? MyLoading(
                                size: 20,
                                color: MyColors.blue,
                              )
                            : Icon(
                                Icons.location_searching_rounded,
                                color: MyColors.blue,
                                size: 26,
                              )),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        );
      });

  @override
  bool get wantKeepAlive => true;
}
