import 'package:flutter/material.dart';

class SettingsTitles extends StatelessWidget {
  final String? text;
  const SettingsTitles({super.key, this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      color: Colors.grey.shade100,
      alignment: Alignment.centerLeft,
      child: Text(
        text!.toUpperCase(),
        style: const TextStyle(
          color: Colors.grey,
        ),
      ),
    );
  }
}
