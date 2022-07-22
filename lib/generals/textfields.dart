import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rewear/generals/colors.dart';

class MyTextfield extends StatefulWidget {
  final String title;
  final String hint;
  final bool isPassword;
  final IconData? suffixIcon;
  final IconData? suffixIcon2;
  final VoidCallback? onTappedSuffixIcon;
  final bool isMultiline;
  final int minLines;
  final int maxLines;
  final TextEditingController? controller;

  const MyTextfield(
      {Key? key,
      required this.title,
      this.hint = '',
      this.minLines = 1,
      this.maxLines = 1,
      this.isPassword = false,
      this.isMultiline = false,
      this.controller,
      this.suffixIcon,
      this.suffixIcon2,
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

  Widget _textfield({EdgeInsets? padding}) {
    return TextField(
      controller: widget.controller,
      minLines: widget.isMultiline ? widget.minLines : 1,
      maxLines: widget.isMultiline ? widget.maxLines : 1,
      style: Get.theme.textTheme.bodyText2,
      obscureText: widget.isPassword ? _showPassword : false,
      decoration: InputDecoration(
        contentPadding: padding,
        suffixIcon: IconButton(
          icon: Icon(_currentSuffix),
          onPressed: _onTappedSuffixIcon,
          padding: EdgeInsets.zero,
        ),
        hintText: widget.hint,
        hintStyle:
            Get.theme.textTheme.bodyText2?.copyWith(color: MyColors.darkGrey),
      ),
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
