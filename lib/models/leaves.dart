import 'package:flutter/material.dart';

class Leaves {
  final String date;
  final String application;
  final String leaveDate;
  final String leaveType;
  final String process;
  final Color bgColor;
  final Color color;

  Leaves({
    required this.date,
    required this.application,
    required this.leaveDate,
    required this.leaveType,
    required this.process,
    required this.bgColor,
    required this.color,
  });
}

final List<Leaves> leavesData = [
  Leaves(
    date: "December 2022",
    application: "Half Day Application",
    leaveDate: "Wed, 16 Dec",
    leaveType: "Casual",
    process: "Awaiting",
    bgColor: Colors.orangeAccent.withOpacity(0.2),
    color: Colors.deepOrange,
  ),
  Leaves(
    date: "November 2022",
    application: "Full Day Application",
    leaveDate: "Mon, 28 Nov",
    leaveType: "Casual",
    process: "Approved",
    bgColor: Colors.greenAccent.withOpacity(0.2),
    color: Colors.green,
  ),
  Leaves(
    date: "November 2022",
    application: "3 Day Application",
    leaveDate: "Tue, 22 Nov-Fri, 2022",
    leaveType: "Casual",
    process: "Declined",
    bgColor: Colors.pinkAccent.withOpacity(0.2),
    color: Colors.pinkAccent,
  ),
  Leaves(
    date: "November 2022",
    application: "Full Day Application",
    leaveDate: "Wed, 02 Nov",
    leaveType: "Sick",
    process: "Approved",
    bgColor: Colors.greenAccent.withOpacity(0.2),
    color: Colors.green,
  ),
];
