import 'package:flutter/material.dart';

class ApproveDeclineButton extends StatelessWidget {
  final String? buttonText;
  final Color? color;
  final Color? bgColor;
  const ApproveDeclineButton({super.key, this.buttonText, this.color, this.bgColor});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 28,
      width: 80,
      child: TextButton(
        onPressed: () {},
        style: TextButton.styleFrom(backgroundColor: bgColor),
        child: Text(
          buttonText!,
          style: TextStyle(
            fontSize: 12,
            color: color,
          ),
        ),
      ),
    );
  }
}
