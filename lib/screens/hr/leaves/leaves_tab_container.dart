import 'package:flutter/material.dart';

class LeavesTabContainer extends StatelessWidget {
  final String? text;
  const LeavesTabContainer({super.key, this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 40,
        // width: 130,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          border: Border.all(width: 1, color: Colors.grey.shade400),
        ),
        child: Text(
          text!.toUpperCase(),
        ));
  }
}
