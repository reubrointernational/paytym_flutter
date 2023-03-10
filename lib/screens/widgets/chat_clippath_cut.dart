import 'package:flutter/material.dart';

class CustomSenderChatDesign extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    double h = size.height;
    double w = size.width;

    path.lineTo(0, h);
    path.lineTo(w - 30, h);
    path.quadraticBezierTo(w - 10, h, w - 10, h - 10);
    path.lineTo(w - 10, 10);
    path.lineTo(w, 0);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}

class CustomReceiverChatDesign extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    double h = size.height;
    double w = size.width;

    /*path.moveTo(10, 0);
    path.lineTo(10, h - 10);
    path.lineTo(0, h);
    path.lineTo(w, h);
    path.lineTo(w, 0);
    path.lineTo(30, 0);
    path.quadraticBezierTo(10, 0, 10, 15);*/

    path.moveTo(0, 0);
    path.lineTo(10, 10);
    path.lineTo(10, h - 20);
    path.quadraticBezierTo(10, h, 30, h);
    path.lineTo(w, h);
    path.lineTo(w, 0);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
