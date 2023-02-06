import 'package:flutter/material.dart';
import 'package:paytym/core/constants/styles.dart';

import '../../../../core/colors/colors.dart';
import '../../../../core/constants/strings.dart';
import 'leave_dialogue.dart';

class LeavesAppBar extends StatelessWidget {
  const LeavesAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          kLeavesString,
          style: kTextStyleS18W600,
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
            GestureDetector(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return const LeaveDialogue();
                    });
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: CustomColors.blueCardColor,
                  ),
                  child: const Icon(Icons.add,
                      color: CustomColors.whiteIconColor, size: 18),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
