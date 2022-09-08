import 'package:flutter/material.dart';
import 'package:rewear/config/app_init.dart';
import 'package:rewear/generals/images.dart';
import 'package:rewear/models/userType.enum.dart';
import 'package:rewear/views/findServices/customerService.widget.dart';
import 'package:rewear/views/findServices/sellerService.widget.dart';

class FindServices extends StatelessWidget {
  const FindServices({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AppInit().user.role! == UserType.customer
                  ? CustomerServiceWidget()
                  : StreamBuilder(
                      stream: AppInit().tailorsStream,
                      builder: ((context, snapshot) => SellerServiceWidget())),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 70),
                child: Image.asset(
                  MyImages.eco_banner,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
