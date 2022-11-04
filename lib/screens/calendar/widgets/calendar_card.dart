import 'package:flutter/material.dart';
import 'package:paytym/core/colors/colors.dart';
import 'package:paytym/core/constants/icons.dart';

import '../../../core/constants/widgets.dart';
import '../calendar_controller.dart';
import 'calendar_app_bar.dart';
import 'calendar_arrows.dart';

class CalendarCard extends StatelessWidget {
  const CalendarCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: CustomColors.whiteCardColor,
      padding: const EdgeInsets.all(18),
      child: Column(
        children: [
          const CalendarAppBar(),
          kSizedBoxH12,
          Container(
            height: 150,
            width: double.infinity,
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: CustomColors.blueCardColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    CalendarArrows(svg: IconPath.backArrowSvg),
                    Text(
                      "October 2022",
                      style: TextStyle(
                        color: CustomColors.whiteTextColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    CalendarArrows(svg: IconPath.forwardArrowSvg),
                  ],
                ),
                kSizedBoxH20,
                Expanded(
                  child: NotificationListener<OverscrollIndicatorNotification>(
                    onNotification: (overscroll) {
                      overscroll.disallowIndicator();
                      return false;
                    },
                    child: ListView.builder(
                      physics: const ClampingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: CalendarController.kCalendarModelList.length,
                      itemBuilder: (context, index) {
                        final dates =
                            CalendarController.kCalendarModelList[index];
                        return SizedBox(
                          width: 50,
                          child: TextButton(
                            onPressed: () {},
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              backgroundColor: dates.bgColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  dates.date,
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: dates.textColor,
                                  ),
                                ),
                                kSizedBoxH15,
                                Text(
                                  dates.day,
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: dates.textColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
