import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rewear/blocs/requests.bloc.dart';
import 'package:rewear/generals/strings.dart';
import 'package:rewear/generals/widgets/customAppbar.widget.dart';
import 'package:rewear/generals/widgets/request.widget.dart';

class TailorRequests extends StatelessWidget {
  bool showAppBar = true;
  TailorRequests({Key? key, this.showAppBar = true}) : super(key: key);

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
          child: Text(
            MyStrings.requests_title,
            style: Get.theme.textTheme.headline6!
                .copyWith(fontWeight: FontWeight.bold),
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
                  itemBuilder: ((context, index) => RequestWidget(
                        request: bloc.app.requests[index],
                        userType: bloc.app.user.role!,
                      )),
                  itemCount: bloc.app.requests.length),
              stream: bloc.app.requestsStream,
            ))
          ],
        ),
      );
}
