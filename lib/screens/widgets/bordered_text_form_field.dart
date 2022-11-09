import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/colors/colors.dart';
import '../../core/constants/styles.dart';

class BorderedTextFormField extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final List<TextInputFormatter>? inputFormatters;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;
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
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLength: 33,
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validator,
      onSaved: onSaved,
      style: const TextStyle(
        color: CustomColors.greyTextColor,
        fontSize: 14,
      ),
      inputFormatters: inputFormatters,
      cursorColor: CustomColors.greyTextColor,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        contentPadding: const EdgeInsets.symmetric(horizontal: 10),
        hintText: hintText,
        counterText: '',
        hintStyle: const TextStyle(
          color: CustomColors.darkGreyTextColor,
        ),
        enabledBorder: kInputBorderBlueW1p2,
        errorBorder: kInputBorderRedW1p2,
        focusedErrorBorder: kInputBorderRedW1p2,
        focusedBorder: kInputBorderBlueW1p2,
      ),
    );
  }
}
