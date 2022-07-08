import 'package:flutter/material.dart';
import 'package:rewear/generals/colors.dart';
import 'package:rewear/generals/constants.dart';
import 'package:rewear/generals/images.dart';

class MyPrimaryButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  const MyPrimaryButton(
      {Key? key, required this.onPressed, required this.title})
      : super(key: key);

  @override
  ClipRRect build(BuildContext context) {
    return ClipRRect(
      borderRadius: MyConstants.buttonCircularRadius,
      child: MaterialButton(
        height: 50,
        minWidth: double.infinity,
        color: MyColors.orange,
        onPressed: onPressed,
        child: Text(
          title,
          style: TextStyle(
              height: 1.4,
              fontSize: 14,
              color: MyColors.white,
              fontWeight: FontWeight.w400),
        ),
      ),
    );
  }
}

class GoogleButton extends StatelessWidget {
  final VoidCallback onPressed;
  const GoogleButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Container build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: MyConstants.buttonCircularRadius,
          border: Border.all(width: 1.5, color: MyColors.grey)),
      child: ClipRRect(
          borderRadius: MyConstants.buttonCircularRadius,
          child: MaterialButton(
            height: 50 - (2 * 1.5),
            minWidth: double.infinity,
            color: MyColors.white,
            onPressed: onPressed,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: Image.asset(
                    MyImages.googleLogo,
                    height: 20,
                    width: 20,
                  ),
                ),
                Text(
                  'Continue with Google',
                  style: TextStyle(
                      height: 1.4,
                      fontSize: 14,
                      color: MyColors.lightBlack,
                      fontWeight: FontWeight.w400),
                )
              ],
            ),
          )),
    );
  }
}
