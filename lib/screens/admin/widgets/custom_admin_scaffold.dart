import 'package:flutter/material.dart';
import '../../../core/colors/colors.dart';
import '../../../core/constants/styles.dart';

class CustomAdminScaffold extends StatelessWidget {
  final String title;
  final Widget widget;
  final Widget? floatingActionButton;

  const CustomAdminScaffold({
    super.key,
    required this.title,
    required this.widget, this.floatingActionButton,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: floatingActionButton,
      appBar: AppBar(
        title: Text(
          title,
          style: kTextStyleS18W600white,
        ),
        elevation: 0,
        backgroundColor: Colors.lightBlue,
      ),
      backgroundColor: CustomColors.lightBlueColor,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30)),
          ),
          child: widget,
        ),
      ),
    );
  }
}
