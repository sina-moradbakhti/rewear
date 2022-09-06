import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rewear/blocs/profile.bloc.dart';
import 'package:rewear/generals/buttons.dart';
import 'package:rewear/generals/colors.dart';
import 'package:rewear/generals/constants.dart';
import 'package:rewear/generals/strings.dart';
import 'package:rewear/generals/textfields.dart';
import 'package:rewear/generals/widgets/customAppbar.widget.dart';
import 'package:rewear/generals/widgets/loading.widget.dart';
import 'package:rewear/generals/widgets/locationCoordinator.widget.dart';
import 'package:rewear/models/userType.enum.dart';

class Profile extends StatelessWidget {
  Profile({Key? key}) : super(key: key);

  final bloc = Get.put(ProfileBloc());

  @override
  Widget build(BuildContext context) {
    bool withoutAppbar = true;
    if (Get.arguments != null) {
      withoutAppbar = Get.arguments['withoutAppbar'];
    }

    return withoutAppbar
        ? Scaffold(body: _getContent)
        : Scaffold(
            appBar: CustomAppbar(
              centerTitle: true,
              title: Text(
                MyStrings.profile,
                style: Get.theme.textTheme.headline5,
              ),
            ),
            body: _getContent);
  } // build

  Widget get _getContent => SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              coverAndProfile,
              Padding(
                padding: EdgeInsets.symmetric(
                        horizontal: MyConstants.primaryPadding.left)
                    .copyWith(bottom: 150),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: ((bloc.app.user.role == UserType.seller)
                        ? sellerFields
                        : customerFields)
                      ..add(Padding(
                        padding: MyConstants.topDoublePadding,
                        child: Obx(() => bloc.loading.value
                            ? const Center(
                                child: MyLoading(),
                              )
                            : MyPrimaryButton(
                                onPressed: bloc.updateInfo,
                                title: 'Update info')),
                      ))),
              )
            ],
          ),
        ),
      );

  List<Widget> get sellerFields => [
        MyTextfield(
            title: 'Fullname',
            value: bloc.app.user.fullname ?? '',
            onChanges: (newFullname) => bloc.app.user.fullname = newFullname),
        MyTextfield(
            title: 'Email', value: bloc.app.user.email ?? '', disable: true),
        MyTextfield(
            title: 'Phone',
            value: bloc.app.user.phone ?? '',
            hint: 'e.g +11234567890',
            onChanges: (newPhone) => bloc.app.user.phone = newPhone),
        MyTextfield(
            title: 'Address',
            value: bloc.app.user.address ?? '',
            onChanges: (newAdr) => bloc.app.user.address = newAdr),
        MyTextfield(
            title: 'Slogan',
            value: bloc.app.user.slogan ?? '',
            onChanges: (newSlogan) => bloc.app.user.slogan = newSlogan),
        MyTextfield(
            title: 'Bio',
            value: bloc.app.user.description ?? '',
            isMultiline: true,
            minLines: 4,
            maxLines: 6,
            onChanges: (newBio) => bloc.app.user.description = newBio),
        Obx(() => LocationCoordinatorWidget(
              onTapped: bloc.coordinateLocation,
              loading: bloc.coordinatingLocation.value,
              active: bloc.locationIsSet.value,
            )),
      ];

  List<Widget> get customerFields => [
        MyTextfield(
            title: 'Fullname',
            value: bloc.app.user.fullname ?? '',
            onChanges: (newFullname) => bloc.app.user.fullname = newFullname),
        MyTextfield(
            title: 'Email', value: bloc.app.user.email ?? '', disable: true),
        MyTextfield(
            title: 'Bio',
            value: bloc.app.user.description ?? '',
            isMultiline: true,
            minLines: 4,
            maxLines: 6,
            onChanges: (newBio) => bloc.app.user.description = newBio),
      ];

  Widget get coverAndProfile => bloc.app.user.role == UserType.customer
      ? Align(
          alignment: Alignment.center,
          child: avatar(65),
        )
      : Container(
          height: 220,
          child: Stack(
            children: [
              Obx(() => MaterialButton(
                    padding: EdgeInsets.zero,
                    onPressed: bloc.uploadCover,
                    child: Container(
                      height: 180,
                      decoration: bloc.getProfileCover() != null
                          ? BoxDecoration(
                              color: MyColors.grey,
                              image: DecorationImage(
                                  image: bloc.getProfileCover()!,
                                  fit: BoxFit.cover))
                          : BoxDecoration(
                              color: MyColors.grey,
                            ),
                    ),
                  )),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Align(
                  child: Icon(
                    Icons.photo_camera_outlined,
                    color: MyColors.darkGrey,
                  ),
                  alignment: Alignment.topLeft,
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: avatar(65),
              )
            ],
          ),
        );

  Widget avatar(double radius) => MaterialButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(75)),
        padding: EdgeInsets.zero,
        onPressed: bloc.uploadProfile,
        child: CircleAvatar(
          radius: radius,
          backgroundColor: MyColors.orange,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Obx(() => CircleAvatar(
                    radius: radius - 5,
                    backgroundColor: MyColors.grey,
                    backgroundImage: bloc.getProfileAvatar(),
                  )),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: 85,
                  height: 30,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: MyColors.orange,
                      borderRadius: BorderRadius.circular(30)),
                  child: Text(
                    'Edit',
                    textAlign: TextAlign.center,
                    style: Get.theme.textTheme.caption!
                        .copyWith(color: MyColors.white),
                  ),
                ),
              )
            ],
          ),
        ),
      );
}
