import 'package:flutter/material.dart';

import '../../constants.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    required this.controller,
    this.validate,
    this.prefixIcon,
    this.hintText,
    this.onChange,
    this.onSubmit,
    this.obsecureText = false,
    this.circularRadius,
    this.verticalPadding,
    this.horizontalPadding,
    this.maxLines,
    this.textInputType,
    this.cursorHeight,
    this.cursorWidth,
    this.suffixIcon,
    this.hintTextStyle,
  });

  final String? hintText;
  final Icon? prefixIcon;
  final Icon? suffixIcon;
  final bool obsecureText;
  final Function(String)? onChange;
  final Function(String)? onSubmit;
  final FormFieldValidator? validate;
  final TextEditingController? controller;
  final double? circularRadius;
  final double? verticalPadding;
  final double? horizontalPadding;
  final int? maxLines;
  final TextInputType? textInputType;
  final double? cursorHeight;
  final double? cursorWidth;
  final TextStyle? hintTextStyle;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLines ?? 1,
      controller: controller,
      obscureText: obsecureText,
      validator: validate,
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
      cursorColor: kPrimaryColor,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        isDense: true,
        contentPadding: EdgeInsets.symmetric(
          vertical: verticalPadding ?? 15,
          horizontal: horizontalPadding ?? 8,
        ),
        hintText: "$hintText",
        hintStyle: hintTextStyle,
        prefixIcon: prefixIcon != null ? prefixIcon : null,
        filled: true,
        fillColor: Colors.white,
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 2),
          borderRadius: BorderRadius.circular(circularRadius ?? 8),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(circularRadius ?? 8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade300, width: 1.2),
          borderRadius: BorderRadius.circular(circularRadius ?? 8),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
          borderRadius: BorderRadius.circular(circularRadius ?? 8),
        ),
      ),
      keyboardType: textInputType ?? TextInputType.text,
      cursorHeight: cursorHeight ?? 21,
      cursorWidth: cursorWidth ?? 2,
    );
  }
}
