import 'package:flutter/material.dart';

import '../../core/colors/colors.dart';
import '../../models/leaves.dart';

class SickLeavesPage extends StatefulWidget {
  const SickLeavesPage({Key? key}) : super(key: key);

  @override
  State<SickLeavesPage> createState() => _SickLeavesPageState();
}

class _SickLeavesPageState extends State<SickLeavesPage> {
  List<Leaves> leaves = LeavesData;
  List<Leaves> sickLeaves = [];
  @override
  void initState() {
    sickLeaves = leaves.where((leave) {
      return leave.leaveType == "Sick";
    }).toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: sickLeaves.length,
      itemBuilder: (context, index) {
        final leave = sickLeaves[index];
        return Container(
          height: 120,
          margin: const EdgeInsets.only(top: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                leave.date,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color: CustomColors.greyHeadingTextColor,
                ),
              ),
              Container(
                height: 90,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      width: 1,
                      color: CustomColors.greyCardBorderColor,
                    )),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          leave.application,
                          style: const TextStyle(
                            color: CustomColors.greyHeadingTextColor,
                          ),
                        ),
                        Text(
                          leave.leaveDate,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          leave.leaveType,
                          style: const TextStyle(
                            fontSize: 15,
                            color: CustomColors.blueLabelColor,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: leave.bgColor,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            leave.process,
                            style: TextStyle(
                              fontSize: 11,
                              color: leave.color,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Container(
                          height: 25,
                          width: 25,
                          decoration: BoxDecoration(
                            color: CustomColors.leaveAllCardColor,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(
                            Icons.arrow_forward_ios,
                            size: 12,
                            color: CustomColors.leaveAllIconColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
