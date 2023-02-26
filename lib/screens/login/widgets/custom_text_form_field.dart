import 'package:flutter/material.dart';

import '../../../core/colors/colors.dart';
import '../../../core/constants/styles.dart';

class CustomTextFormField extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final int? maxLines;
  final TextInputType? inputType;
  final TextInputAction? inputAction;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;
  const CustomTextFormField({
    Key? key,
    required this.hintText,
    this.validator,
    this.obscureText = false,
    this.onSaved,
    this.inputType,
    this.inputAction, this.maxLines = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLines,
      obscureText: obscureText,
      keyboardType: inputType,
      textInputAction: inputAction,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validator,
      onSaved: onSaved,
      style: TextStyle(
        color: CustomColors.greyShade600TextColor,
      ),
      cursorColor: CustomColors.greyShade600TextColor,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(
          color: CustomColors.darkGreyTextColor,
        ),
        fillColor: CustomColors.greyFillTextFieldColor,
        filled: true,
        enabledBorder: kInputBorderNone,
        errorBorder: kInputBorderRed,
        focusedErrorBorder: kInputBorderRed,
        focusedBorder: kInputBorderBlue,
      ),
    );
  }
}
