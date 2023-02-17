import 'package:flutter/material.dart';

import '../../../../core/colors/colors.dart';
import '../../../../core/constants/strings.dart';

class UploadTextButton extends StatelessWidget {
  final String? text;
  final void Function()? onPressed;
  final Color? backgroundColor;
  const UploadTextButton({super.key, this.text, this.onPressed, this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: h * 0.05,
      width: w * 0.4,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(
          text!,
          style: const TextStyle(
            color: CustomColors.whiteTabColor,
          ),
        ),
      ),
    );
  }
}
