import 'package:flutter/material.dart';
import 'package:paytym/core/constants/strings.dart';

import '../../../../core/colors/colors.dart';
import '../../../../core/constants/styles.dart';
import 'wages_list.dart';

class WagesPage extends StatelessWidget {
  const WagesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Wages',
          style: kTextStyleS18W600white,
        ),
        elevation: 0,
        backgroundColor: Colors.lightBlue,
      ),
      backgroundColor: CustomColors.lightBlueColor,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          height: h * 0.9,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
          ),
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 8),
          child: const Expanded(
            child: WagesList(),
          ),
        ),
      ),
    );
  }
}
