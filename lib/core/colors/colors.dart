import 'package:flutter/material.dart';

abstract class CustomColors {
  static const Color backgroundColor = Colors.white;
  static const Color bottomNavSelectedItemColor =
      Color.fromRGBO(72, 13, 250, 1);
  static const Color bottomNavUnselectedItemColor =
      Color.fromRGBO(140, 140, 140, 1);
  static const Color calendarPageBackgroundColor =
      Color.fromRGBO(246, 247, 249, 1);
  static const Color chatPageBackgroundColor = Color.fromRGBO(221, 226, 239, 1);
  static const Color fabColor = Color.fromRGBO(72, 13, 250, 1);
  static const Color dashboardGreyBackgroundColor =
      Color.fromRGBO(236, 238, 240, 1);

  static const Color lightBlueColor = Color.fromRGBO(2, 170, 235, 1);

  //card/tab colors
  static const Color whiteTabColor = Colors.white;
  static const Color selectedTabColor = Color.fromRGBO(243, 243, 243, 1);
  static const Color whiteCardColor = Colors.white;
  //static const Color blueCardColor = Color.fromRGBO(75, 103, 176, 1);
  static const Color blueCardColor = Color.fromRGBO(72, 13, 250, 1);
  static const Color cardBackgroundCircleColor = Colors.white10;
  static const Color leaveAllCardColor = Color.fromRGBO(235, 235, 235, 1);

  //text colors
  static const Color customGreyTextColor = Color.fromRGBO(138, 138, 138, 1);
  static const Color greyTextColor = Colors.grey;
  static Color greyShade600TextColor = Colors.grey.shade600;
  static const Color blackTextColor = Colors.black;
  static const Color whiteTextColor = Colors.white;
  static Color whiteWithOpacityTextColor = Colors.white.withOpacity(0.6);
  static const Color blueTextColor = Color.fromRGBO(72, 13, 250, 1);
  static const Color darkGreyTextColor = Color.fromARGB(255, 143, 143, 143);
  static const Color grey80x3TextColor = Color.fromARGB(255, 80, 80, 80);
  static const Color grey156x3TextColor = Color.fromARGB(255, 156, 156, 156);
  static const Color greyHeadingTextColor = Color.fromRGBO(140, 140, 140, 1);
  static const Color greyCardBorderColor = Color.fromRGBO(219, 219, 219, 1);
  static const Color lightBlueCardBorderColor =
      Color.fromRGBO(75, 103, 176, 0.37);
  static const Color greyFillTextFieldColor =
      Color.fromARGB(255, 246, 246, 246);
  static const Color redBorderTextFieldColor = Color.fromARGB(247, 223, 10, 10);
  static const Color blueBorderTextFieldColor =
      Color.fromARGB(247, 97, 132, 221);

  //custom colors
  static Color circleAvatarBackgroundColor = Colors.grey.shade300;
  static const Color whiteCircleAvatarBackgroundColor = Colors.white;
  static const Color orangeLabelColor = Colors.orange;
  static final Color lightOrangeColor = Colors.orange.shade50;
  static const Color blueLabelColor = Colors.blue;
  static const Color redColor = Colors.red;
  static final Color lightRedColor = Colors.red.shade50;
  static const Color greenColor = Colors.green;
  static final Color lightGreenColor = Colors.green.shade50;
  static const Color leaveAllIconColor = Color.fromRGBO(153, 155, 163, 1);
  static const Color greyIconColor = Color.fromARGB(255, 105, 105, 105);
  static const Color whiteIconColor = Colors.white;
  static const Color disabledButtonColor = Color.fromARGB(255, 124, 188, 240);

  static const Color pinkColor = Colors.pink;
  static Color orangeWithOpacity = Colors.orange.withOpacity(0.2);
  static Color pinkWithOpacity = Colors.pinkAccent.withOpacity(0.2);
  static const Color orangeColor = Colors.orange;
  static Color greenWithOpacity = Colors.greenAccent.withOpacity(0.2);
  static Color greenColorShade700 = Colors.green.shade700;

  //color list
  static List<Color> cardColorList = [
    const Color.fromRGBO(0, 148, 66, 1),
    const Color.fromRGBO(250, 42, 20, 1),
    const Color.fromRGBO(18, 115, 205, 1),
    const Color.fromARGB(255, 253, 241, 4),
  ];
}
