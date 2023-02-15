import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/colors/colors.dart';
import '../../core/constants/styles.dart';

class BorderedTextFormField extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final bool? enabled;
  final List<TextInputFormatter>? inputFormatters;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;
  final int? maxLines;
  final int? maxLength;
  const BorderedTextFormField({
    Key? key,
    required this.hintText,
    this.validator,
    this.obscureText = false,
    this.onSaved,
    this.suffixIcon,
    this.keyboardType,
    this.controller,
    this.inputFormatters,
    this.maxLines = 1,
    this.maxLength = 33, this.enabled,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: enabled,
      maxLength: maxLength,
      maxLines: maxLines,
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validator,
      onSaved: onSaved,
      style: const TextStyle(
        color: CustomColors.blackTextColor,
        fontSize: 14,
      ),
      inputFormatters: inputFormatters,
      cursorColor: CustomColors.greyTextColor,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        hintText: hintText,
        counterText: '',
        hintStyle: const TextStyle(
          fontSize: 14,
          color: CustomColors.darkGreyTextColor,
        ),
        enabledBorder: kInputBorderBlueW1p2,
        disabledBorder: kInputBorderBlueW1p2,
        errorBorder: kInputBorderRedW1p2,
        focusedErrorBorder: kInputBorderRedW1p2,
        focusedBorder: kInputBorderBlueW1p2,
      ),
    );
  }
}
