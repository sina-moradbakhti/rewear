import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rewear/blocs/requests.bloc.dart';
import 'package:rewear/generals/colors.dart';
import 'package:rewear/generals/images.dart';
import 'package:rewear/generals/strings.dart';
import 'package:rewear/generals/widgets/customAppbar.widget.dart';
import 'package:rewear/generals/widgets/request.widget.dart';
import 'package:rewear/models/userType.enum.dart';

class Requests extends StatelessWidget {
  bool showAppBar = true;
  Requests({Key? key, this.showAppBar = true}) : super(key: key);

  final bloc = Get.put(RequestsBloc());

  @override
  Widget build(BuildContext context) {
    return showAppBar
        ? Scaffold(
            appBar: CustomAppbar(
              centerTitle: true,
              title: Text(
                MyStrings.requests_title,
                style: Get.theme.textTheme.headline5,
              ),
            ),
            body: SafeArea(bottom: false, child: _content),
          )
        : Scaffold(
            body: SafeArea(bottom: false, child: _content),
          );
  }

  Widget get _title => !showAppBar
      ? Padding(
          padding: const EdgeInsets.only(bottom: 15, top: 24, left: 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                MyStrings.orders_title,
                style: Get.theme.textTheme.headline5!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              IconButton(
                  padding: EdgeInsets.zero,
                  splashRadius: 15,
                  splashColor: MyColors.lightOrange,
                  onPressed: bloc.showHelp,
                  icon: Icon(
                    CupertinoIcons.question_circle_fill,
                    color: MyColors.orange.withOpacity(.8),
                  ))
            ],
          ),
        )
      : Container();
  Widget get _content => StreamBuilder(
      stream: bloc.app.requestsStream,
      builder: (context, snapshot) => bloc.app.requests.isNotEmpty
          ? Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _title,
                Expanded(
                    child: ListView.builder(
                        padding: const EdgeInsets.only(bottom: 100),
                        itemBuilder: ((context, index) => RequestWidget(
                              request: bloc.app.requests[index],
                              userType: UserType.customer,
                            )),
                        itemCount: bloc.app.requests.length))
              ],
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _title,
                Text('No Orders found!',
                    style: Get.theme.textTheme.bodyText1!
                        .copyWith(color: MyColors.darkGrey)),
                Padding(
                  padding: const EdgeInsets.only(bottom: 80),
                  child: Image.asset(MyJpegs.noRequestsFound),
                )
              ],
            ));
}
