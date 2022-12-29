import 'package:flutter/material.dart';

import '../../../core/colors/colors.dart';

class CalendarContents extends StatelessWidget {
  final String? time;
  final String? name;
  final String? subText;
  final Widget? widget;
  const CalendarContents(
      {super.key, this.time, this.name, this.subText, this.widget});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 370,
      child: ListView.builder(
        itemCount: 6,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 1),
            child: Card(
              shape: RoundedRectangleBorder(
                side: BorderSide(width: 1, color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 95),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              time!,
                              style: const TextStyle(
                                fontWeight: FontWeight.w400,
                                color: CustomColors.blueTextColor,
                                fontSize: 13,
                              ),
                            ),
                            Text(
                              name!,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              subText!,
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            widget!,
                            Row(
                              children: const [
                                Icon(Icons.edit, color: Colors.green),
                                Icon(
                                  Icons.delete_sharp,
                                  color: Colors.red,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ]),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
