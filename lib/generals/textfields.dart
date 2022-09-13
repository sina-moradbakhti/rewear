import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rewear/generals/colors.dart';

class MyTextfield extends StatefulWidget {
  final String title;
  final String hint;
  final String value;
  final bool isPassword;
  final IconData? suffixIcon;
  final IconData? suffixIcon2;
  final VoidCallback? onTappedSuffixIcon;
  final bool isMultiline;
  final int minLines;
  final int maxLines;
  final bool disable;
  final Function(String)? onChanges;

  const MyTextfield(
      {Key? key,
      required this.title,
      this.hint = '',
      this.value = '',
      this.disable = false,
      this.minLines = 1,
      this.maxLines = 1,
      this.isPassword = false,
      this.isMultiline = false,
      this.suffixIcon,
      this.suffixIcon2,
      this.onChanges,
      this.onTappedSuffixIcon})
      : super(key: key);

  @override
  State<MyTextfield> createState() => _MyTextfieldState();
}

class _MyTextfieldState extends State<MyTextfield> {
  VoidCallback? _onTappedSuffixIcon;
  bool _showPassword = true;
  IconData? _currentSuffix;

  @override
  void initState() {
    _onTappedSuffixIcon = widget.onTappedSuffixIcon;
    _currentSuffix = widget.suffixIcon;
    if (widget.isPassword) {
      _onTappedSuffixIcon = () {
        setState(() {
          _showPassword = !_showPassword;
          _currentSuffix =
              _showPassword ? widget.suffixIcon : widget.suffixIcon2;
        });
      };
    }
    super.initState();
  }

  TextInputType _getInputType() {
    if (widget.title.toLowerCase() == 'address') {
      return TextInputType.streetAddress;
    }
    if (widget.title.toLowerCase().contains('email')) {
      return TextInputType.emailAddress;
    }
    if (widget.title.toLowerCase().contains('number') ||
        widget.title.toLowerCase().contains('phone')) {
      return TextInputType.phone;
    }
    if (widget.title.toLowerCase() == 'age' ||
        widget.title.toLowerCase().contains('code')) {
      return TextInputType.number;
    }
    if (widget.title.toLowerCase().contains('name')) {
      return TextInputType.name;
    }
    if (widget.title.toLowerCase().contains('url')) {
      return TextInputType.url;
    }
    if (widget.title.toLowerCase().contains('date')) {
      return TextInputType.datetime;
    }
    return TextInputType.text;
  }

  Widget _textfield({EdgeInsets? padding}) {
    return TextFormField(
      initialValue: widget.value,
      minLines: widget.isMultiline ? widget.minLines : 1,
      maxLines: widget.isMultiline ? widget.maxLines : 1,
      keyboardType: _getInputType(),
      style: widget.disable
          ? Get.theme.textTheme.bodyText2!.copyWith(color: MyColors.darkGrey)
          : Get.theme.textTheme.bodyText2,
      onChanged: widget.onChanges,
      obscureText: widget.isPassword ? _showPassword : false,
      decoration: InputDecoration(
          enabled: !widget.disable,
          contentPadding: padding,
          suffixIcon: IconButton(
            icon: Icon(_currentSuffix),
            onPressed: _onTappedSuffixIcon,
            padding: EdgeInsets.zero,
          ),
          hintText: widget.hint,
          hintStyle:
              Get.theme.textTheme.bodyText2?.copyWith(color: MyColors.darkGrey),
          disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: MyColors.grey, width: 0.5))),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 2.5, left: 2.5),
            child: Text(
              widget.title,
              style: Get.theme.textTheme.bodyText2
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          widget.isMultiline
              ? _textfield(
                  padding: const EdgeInsets.only(
                      top: 8, bottom: 8, right: 8, left: 8))
              : SizedBox(height: 42.5, child: _textfield())
        ],
      ),
    );
  }
}
