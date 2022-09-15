import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rewear/blocs/requestDetails.bloc.dart';
import 'package:rewear/generals/buttons.dart';
import 'package:rewear/generals/colors.dart';
import 'package:rewear/generals/constants.dart';
import 'package:rewear/generals/widgets/avatar.widget.dart';
import 'package:rewear/generals/widgets/break.widget.dart';
import 'package:rewear/generals/widgets/customAppbar.widget.dart';
import 'package:rewear/generals/widgets/defaultClotheImage.widget.dart';
import 'package:rewear/generals/widgets/hr.widget.dart';
import 'package:rewear/generals/exts/extensions.dart';

class TailorRequestDetails extends StatelessWidget {
  TailorRequestDetails({Key? key}) : super(key: key);

  final bloc = Get.put(RequestDetailsBloc());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        centerTitle: false,
        main: false,
        title: Text(
          bloc.request?.serviceType ?? 'Service',
          style: Get.theme.textTheme.headline5,
        ),
      ),
      body: StreamBuilder(
          stream: bloc.app.tailorsStream,
          builder: (context, snapshot) {
            return SafeArea(
                bottom: false,
                child: Stack(
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _images,
                          const Hr(),
                          Stack(
                            children: [
                              _customer,
                              _tailorStatus,
                            ],
                          ),
                          const Hr(),
                          _price,
                          const Hr(),
                          _details,
                          BreakWidget(
                            size: 50,
                          )
                        ],
                      ),
                    ),
                    Obx(() => bloc.showBottomPriceButtons.value
                        ? _safeAreaButtons
                        : _waitingForCustomer)
                  ],
                ));
          }),
    );
  } // build

  Widget get _safeAreaButtons => SafeArea(
          child: Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: MyConstants.primaryPadding.copyWith(bottom: 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                  child: Obx(() => MyPrimaryButton(
                      color: MyColors.darkGrey,
                      loading: bloc.cancelLoading.value,
                      onPressed: () =>
                          bloc.acceptLoading.value ? null : bloc.cancel(),
                      title: 'Cancel'))),
              BreakWidget(size: 20, vertical: false),
              Expanded(
                  child: Obx(() => MyPrimaryButton(
                      loading: bloc.acceptLoading.value,
                      onPressed: () =>
                          bloc.cancelLoading.value ? null : bloc.accept(),
                      title: 'Accept')))
            ],
          ),
        ),
      ));

  Widget get _waitingForCustomer => Align(
        alignment: Alignment.bottomCenter,
        child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
                color: bloc.request!.acceptedByUser
                    ? Colors.green
                    : MyColors.orange),
            child: SafeArea(
              child: Padding(
                padding:
                    MyConstants.primaryPadding.copyWith(bottom: 10, top: 10),
                child: Text(
                    !bloc.request!.acceptedByUser
                        ? 'Waiting to customer...'
                        : 'You can deliver the order till now',
                    textAlign: TextAlign.center,
                    style: Get.theme.textTheme.headline6!
                        .copyWith(color: Colors.white)),
              ),
            )),
      );

  Widget get _price => Container(
        padding: EdgeInsets.only(
            top: 20,
            left: MyConstants.primaryPadding.left,
            right: MyConstants.primaryPadding.right),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Price',
                style: Get.theme.textTheme.headline4!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: 130,
                child: TextFormField(
                  onChanged: (newVal) => bloc.strPrice.value = newVal,
                  initialValue:
                      bloc.request!.price > 0 ? '${bloc.request!.price}' : '',
                  textAlign: TextAlign.center,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(
                      hintText: 'price...',
                      enabled: bloc.showBottomPriceButtons.value),
                  style: Get.theme.textTheme.headline5!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
        ),
      );

  Widget get _customer => Padding(
      padding: const EdgeInsets.only(bottom: 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(() => Padding(
                padding: const EdgeInsets.only(top: 10),
                child: bloc.customer.value?.id == null
                    ? Padding(
                        padding: EdgeInsets.only(
                            left: MyConstants.primaryPadding.left,
                            right: MyConstants.primaryPadding.right,
                            bottom: 15,
                            top: 0),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Customer',
                                style: Get.theme.textTheme.headline4!
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Text(
                                  'Customer not accepted yet',
                                  style: Get.textTheme.bodyText1,
                                ),
                              )
                            ]),
                      )
                    : Padding(
                        padding: EdgeInsets.only(
                            left: MyConstants.primaryPadding.left,
                            right: MyConstants.primaryPadding.right,
                            bottom: 15,
                            top: 0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Customer',
                              style: Get.theme.textTheme.headline4!
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 15),
                              child: Row(
                                children: [
                                  AvatarWidget(
                                      avatarId: (bloc.customer.value?.image ??
                                              '')
                                          .avatarURL(
                                              bloc.customer.value?.id ?? '')),
                                  Padding(
                                      padding: const EdgeInsets.only(left: 15),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${bloc.customer.value?.fullname}',
                                            style: Get
                                                .theme.textTheme.bodyText1!
                                                .copyWith(
                                                    fontWeight:
                                                        FontWeight.bold),
                                          ),
                                          if (bloc.customer.value
                                                  ?.description !=
                                              null)
                                            Padding(
                                              padding:
                                                  const EdgeInsets.only(top: 0),
                                              child: Text(
                                                '${bloc.customer.value?.description}',
                                                style: Get
                                                    .theme.textTheme.bodyText1!
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.normal),
                                              ),
                                            ),
                                        ],
                                      )),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
              ))
        ],
      ));

  Widget get _details => Container(
        padding: EdgeInsets.only(
            top: 20,
            left: MyConstants.primaryPadding.left,
            right: MyConstants.primaryPadding.right),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _keyValueWidget(
                'Order date', bloc.request!.orderDate.beautify(), true),
            _keyValueWidget('Material', bloc.request!.material ?? '', true),
            _keyValueWidget(
                'Color',
                Icon(Icons.circle,
                    size: 25, color: bloc.request!.color ?? Colors.white),
                false),
            Padding(
              padding: const EdgeInsets.only(bottom: 60, top: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Description',
                    style: Get.theme.textTheme.bodyText1!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Text(bloc.request!.description ?? '',
                        style: Get.theme.textTheme.bodyText1),
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  Widget get _images => SizedBox(
        height: 150,
        width: double.infinity,
        child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                for (final image in bloc.request!.images!)
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: SizedBox(
                      width: 100,
                      height: 100,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: CachedNetworkImage(
                          imageUrl: image.resURL(bloc.request!.id!),
                          errorWidget: (context, url, error) =>
                              const DefaultClothImageWidget(),
                        ),
                      ),
                    ),
                  )
              ],
            )),
      );

  Widget _keyValueWidget(String key, dynamic value, bool text) => Padding(
        padding: const EdgeInsets.only(bottom: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              key,
              style: Get.theme.textTheme.bodyText1!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            text ? Text(value, style: Get.theme.textTheme.bodyText1) : value,
          ],
        ),
      );

  Widget get _tailorStatus => Padding(
        padding: const EdgeInsets.all(16),
        child: Align(
          alignment: Alignment.topRight,
          child: Container(
            decoration: BoxDecoration(
                color: _getOrderStBd(),
                borderRadius: BorderRadius.circular(30)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 2),
              child: Text(_getOrderSt(),
                  style: Get.theme.textTheme.bodyText2!
                      .copyWith(color: _getOrderStClr())),
            ),
          ),
        ),
      );

  String _getOrderSt() {
    if (bloc.request!.canceledBySeller || bloc.request!.canceledByUser) {
      return bloc.request!.canceledBySeller ? 'Seller Rejected' : 'Rejected';
    }

    if (bloc.request!.acceptedBySeller && bloc.request!.acceptedByUser) {
      return 'Accepted';
    } else if (bloc.request!.acceptedBySeller &&
        !bloc.request!.acceptedByUser) {
      return 'Seller accepted';
    }

    return 'Pending';
  }

  Color _getOrderStBd() {
    if (bloc.request!.canceledBySeller || bloc.request!.canceledByUser) {
      return Colors.red;
    }

    if (bloc.request!.acceptedBySeller && bloc.request!.acceptedByUser) {
      return Colors.green;
    } else if (bloc.request!.acceptedBySeller &&
        !bloc.request!.acceptedByUser) {
      return Colors.green;
    }

    return MyColors.mediumGrey;
  }

  Color _getOrderStClr() {
    if (bloc.request!.canceledBySeller || bloc.request!.canceledByUser) {
      return Colors.white;
    }

    if (bloc.request!.acceptedBySeller && bloc.request!.acceptedByUser) {
      return Colors.white;
    } else if (bloc.request!.acceptedBySeller &&
        !bloc.request!.acceptedByUser) {
      return Colors.white;
    }

    return MyColors.black;
  }
}
