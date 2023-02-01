import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/colors/colors.dart';
import '../../../../core/constants/styles.dart';

class BottomsheetTextField extends StatelessWidget {
  final String? hintText;
  final bool? enabled;
  final String? Function(String?)? validator;
  final String? text;
  final void Function(String?)? onSaved;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final int maxLines;
  const BottomsheetTextField(
      {super.key,
      this.hintText,
      this.enabled,
      this.text,
      this.keyboardType,
      this.validator,
      this.onSaved,
      this.inputFormatters,
      this.maxLines = 1});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: text,
      validator: validator,
      maxLines: maxLines,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onSaved: onSaved,
      enabled: enabled,
      inputFormatters: inputFormatters,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.all(10),
        hintText: hintText,
        hintStyle: const TextStyle(
          color: CustomColors.greyTextColor,
          fontSize: 14,
        ),
        enabledBorder: kInputBorderBlueW1p2,
        focusedBorder: kInputBorderBlueW1p2,
        disabledBorder: kInputBorderBlueW1p2,
        errorBorder: kInputBorderRedW1p2,
        focusedErrorBorder: kInputBorderRedW1p2,
      ),
    );
  }
}
