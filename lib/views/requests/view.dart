import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rewear/blocs/requests.bloc.dart';
import 'package:rewear/generals/colors.dart';
import 'package:rewear/generals/strings.dart';
import 'package:rewear/generals/widgets/customAppbar.widget.dart';
import 'package:rewear/generals/widgets/request.widget.dart';

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
                MyStrings.requests_title,
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
  Widget get _content => Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _title,
            Expanded(
                child: StreamBuilder(
              builder: (context, snapshot) => ListView.builder(
                  itemBuilder: ((context, index) =>
                      RequestWidget(request: bloc.app.requests[index])),
                  itemCount: bloc.app.requests.length),
              stream: bloc.app.requestsStream,
            ))
          ],
        ),
      );
}
