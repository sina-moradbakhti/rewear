import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rewear/blocs/requestDetails.bloc.dart';
import 'package:rewear/generals/buttons.dart';
import 'package:rewear/generals/colors.dart';
import 'package:rewear/generals/constants.dart';
import 'package:rewear/generals/widgets/break.widget.dart';
import 'package:rewear/generals/widgets/customAppbar.widget.dart';
import 'package:rewear/generals/widgets/hr.widget.dart';
import 'package:rewear/generals/exts/extensions.dart';

class RequestDetails extends StatelessWidget {
  RequestDetails({Key? key}) : super(key: key);

  final bloc = Get.put(RequestDetailsBloc());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        centerTitle: false,
        main: false,
        title: Text(
          bloc.request?.order.serviceType ?? 'Service',
          style: Get.theme.textTheme.headline5,
        ),
      ),
      body: SafeArea(
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
                        (!bloc.request!.acceptedBySeller)
                            ? ColorFiltered(
                                colorFilter: const ColorFilter.mode(
                                    Colors.grey, BlendMode.color),
                                child: _seller)
                            : _seller,
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
                  : Container())
            ],
          )),
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
              Text('\$${bloc.request!.price}',
                  style: Get.theme.textTheme.headline4),
            ],
          ),
        ),
      );

  Widget get _seller => Container(
        child: Padding(
            padding: const EdgeInsets.only(bottom: 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(() => Container(
                      decoration: bloc.tailor.value?.cover != null
                          ? BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                      bloc.tailor.value?.cover ?? '')),
                            )
                          : const BoxDecoration(),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: bloc.tailor.value?.uid == null
                            ? Padding(
                                padding: EdgeInsets.only(
                                    left: MyConstants.primaryPadding.left,
                                    right: MyConstants.primaryPadding.right,
                                    bottom: 15,
                                    top: 0),
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Tailor',
                                        style: Get.theme.textTheme.headline4!
                                            .copyWith(
                                                fontWeight: FontWeight.bold),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 10),
                                        child: Text(
                                          'Seller not accepted yet',
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
                                      'Tailor',
                                      style: Get.theme.textTheme.headline4!
                                          .copyWith(
                                              fontWeight: FontWeight.bold),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 15),
                                      child: Row(
                                        children: [
                                          bloc.tailor.value?.cover != null
                                              ? CircleAvatar(
                                                  radius: 30,
                                                  backgroundColor:
                                                      MyColors.grey,
                                                  backgroundImage: NetworkImage(
                                                      bloc.tailor.value
                                                              ?.image ??
                                                          ''))
                                              : CircleAvatar(
                                                  radius: 30,
                                                  backgroundColor:
                                                      MyColors.grey,
                                                ),
                                          Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 15),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    '${bloc.tailor.value?.fullname}',
                                                    style: Get.theme.textTheme
                                                        .bodyText1!
                                                        .copyWith(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 5),
                                                    child: Text(
                                                      '${bloc.tailor.value?.phone}',
                                                      style: Get.theme.textTheme
                                                          .bodyText1!
                                                          .copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal),
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
                      ),
                    ))
              ],
            )),
      );

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
            _keyValueWidget(
                'Material', bloc.request!.order.material ?? '', true),
            _keyValueWidget(
                'Color',
                Icon(Icons.circle,
                    size: 25, color: bloc.request!.order.color ?? Colors.white),
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
                    child: Text(bloc.request!.order.description ?? '',
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
                for (final image in bloc.request!.order.images!)
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: SizedBox(
                      width: 100,
                      height: 100,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(image),
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
                color: bloc.request!.acceptedBySeller
                    ? Colors.green
                    : MyColors.mediumGrey,
                borderRadius: BorderRadius.circular(30)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 2),
              child: Text(
                  bloc.request!.acceptedBySeller
                      ? 'Seller accepted'
                      : 'Pending',
                  style: Get.theme.textTheme.bodyText2!.copyWith(
                      color: bloc.request!.acceptedBySeller
                          ? Colors.white
                          : Colors.black)),
            ),
          ),
        ),
      );
}