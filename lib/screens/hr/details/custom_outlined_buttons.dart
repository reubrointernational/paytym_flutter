import 'package:flutter/material.dart';

class CustomOutlinedButton extends StatelessWidget {
  final String? text;
  final Color? color;
  const CustomOutlinedButton({super.key, this.text, this.color});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.06,
      width: size.width * 0.44,
      child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(width: 1.5, color: color!),
              )),
          child: Text(
            text!,
            style: TextStyle(color: color),
          )),
    );
  }
}
