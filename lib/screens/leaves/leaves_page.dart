import 'package:get/get.dart';
import 'package:paytym/core/colors/colors.dart';
import 'package:paytym/screens/leaves/casual.dart';
import 'package:paytym/screens/leaves/leaves_controller.dart';
import 'package:paytym/screens/leaves/sick.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'all.dart';

class LeavesPage extends StatefulWidget {
  const LeavesPage({Key? key}) : super(key: key);

  @override
  State<LeavesPage> createState() => _LeavesPageState();
}

class _LeavesPageState extends State<LeavesPage> {
  String selectedSegment = "All";
  String? selectedLeaveType = "Annual";

  DateTime? selectedDate = DateTime.now();
  List<String> leaveTypes = ["Annual", "Special", "Bereavement", "Maternity"];

  Future<void> selectDateTime(BuildContext context) async {
    final DateTime? dateTime = await showDatePicker(
      context: context,
      initialDate: selectedDate!,
      firstDate: DateTime(1990),
      lastDate: DateTime(2030),
    );
    setState(() {
      selectedDate = dateTime;
    });
  }

  @override
  Widget build(BuildContext context) {
    final leavesController = Get.put(LeavesController());
    return Scaffold(
      backgroundColor: CustomColors.backgroundColor,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              leavesAppBar(),
              const SizedBox(
                height: 15,
              ),
              CupertinoNavigationBar(
                backgroundColor: Colors.transparent,
                middle: CupertinoSlidingSegmentedControl(
                  padding: EdgeInsets.zero,
                  backgroundColor: CustomColors.selectedTabColor,
                  children: const {
                    "All": SizedBox(
                      width: 100,
                      height: 40,
                      child: Center(
                        child: Text(
                          "All",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.2,
                          ),
                        ),
                      ),
                    ),
                    "Casual": Text(
                      "Casual",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.2,
                      ),
                    ),
                    "Sick": Text(
                      "Sick",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.2,
                      ),
                    ),
                  },
                  groupValue: selectedSegment,
                  onValueChanged: (value) {
                    setState(() {
                      selectedSegment = value!;
                    });
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: selectLeave(selectedSegment),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget selectLeave(segment) {
    if (segment == "All") {
      return const AllLeavesPage();
    } else if (segment == "Casual") {
      return const CasualLeavesPage();
    } else if (segment == "Sick") {
      return const SickLeavesPage();
    }
    return Container();
  }

  Widget leavesAppBar() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Leaves",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          Row(
            children: [
              Stack(children: const [
                Icon(Icons.notifications_outlined),
                Positioned(
                  right: 0,
                  top: 2,
                  child: CircleAvatar(
                    backgroundColor: CustomColors.redColor,
                    radius: 5,
                  ),
                ),
              ]),
              const SizedBox(
                width: 15,
              ),
              Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: CustomColors.blueCardColor,
                ),
                child: GestureDetector(
                    onTap: () {
                      showLeaveDialog(selectedDate!);
                    },
                    child: const Icon(Icons.add,
                        color: CustomColors.whiteIconColor, size: 18)),
              ),
            ],
          ),
        ],
      );

  void showLeaveDialog(DateTime selectedDate) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            scrollable: true,
            title: const Text("Request Leave"),
            // titlePadding: EdgeInsets.zero,
            content: StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 10),
                      hintText: "Title",
                      hintStyle: const TextStyle(
                        color: CustomColors.greyTextColor,
                        fontSize: 14,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                            width: 1.2,
                            color: CustomColors.lightBlueCardBorderColor),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                            width: 1.2,
                            color: CustomColors.lightBlueCardBorderColor),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Container(
                    height: 50,
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                          width: 1.2,
                          color: CustomColors.lightBlueCardBorderColor),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        // dropdownColor: const Color.fromRGBO(75, 103, 176, 1),
                        isExpanded: true,
                        value: selectedLeaveType,
                        onChanged: (String? value) {
                          setState(() {
                            selectedLeaveType = value!;
                          });
                        },
                        items: leaveTypes
                            .map<DropdownMenuItem<String>>((String? value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value!,
                              style: const TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.datetime,
                    decoration: InputDecoration(
                      suffixIcon: GestureDetector(
                          onTap: () => selectDateTime(context),
                          child: const Icon(Icons.calendar_month, size: 18)),
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 10),
                      hintText: "Start Date",
                      hintStyle: const TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                            width: 1.2,
                            color: CustomColors.lightBlueCardBorderColor),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                            width: 1.2,
                            color: CustomColors.lightBlueCardBorderColor),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.datetime,
                    decoration: InputDecoration(
                      suffixIcon: GestureDetector(
                          onTap: () => selectDateTime(context),
                          child: const Icon(Icons.calendar_month, size: 18)),
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 10),
                      hintText: "End Date",
                      hintStyle: const TextStyle(
                        color: CustomColors.greyTextColor,
                        fontSize: 14,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                            width: 1.2,
                            color: CustomColors.lightBlueCardBorderColor),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                            width: 1.2,
                            color: CustomColors.lightBlueCardBorderColor),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 10),
                      hintText: "Days",
                      hintStyle: const TextStyle(
                        color: CustomColors.greyTextColor,
                        fontSize: 14,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                            width: 1.2,
                            color: CustomColors.lightBlueCardBorderColor),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                            width: 1.2,
                            color: CustomColors.lightBlueCardBorderColor),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: CustomColors.blueCardColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        "Request Leave",
                        style: TextStyle(
                          color: CustomColors.whiteTextColor,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }),
          );
        });
  }
}
