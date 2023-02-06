import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../core/colors/colors.dart';
import '../../core/constants/icons.dart';
import '../../core/constants/strings.dart';
import '../../core/constants/styles.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: const IconThemeData(color: Colors.black),
      elevation: 0,
      backgroundColor: CustomColors.backgroundColor,
      title: Text(
        kCalendarString,
        style: kTextStyleS18W600.copyWith(color: Colors.black),
      ),
      leading: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          child: SvgPicture.asset(
            IconPath.menuSvg,
          ),
        ),
      ),
    );
  }
}
