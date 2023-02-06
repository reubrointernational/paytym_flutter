import 'package:flutter/material.dart';
import 'package:paytym/screens/admin/calendar/Tabs/schedule/timeline_child.dart';
import 'package:timeline_tile/timeline_tile.dart';

import 'dummy_data.dart';

class CalendarScheduleAdmin extends StatelessWidget {
  const CalendarScheduleAdmin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: DummyDatas.schedule.length,
        itemBuilder: (context, index) {
          return Container(
            alignment: Alignment.topLeft,
            // height: 120,
            child: TimelineTile(
              isLast: index == DummyDatas.schedule.length - 1 ? true : false,
              alignment: TimelineAlign.manual,
              lineXY: 0.25,
              endChild:
                  TimeLineChildAdmin(schedule: DummyDatas.schedule[index]),
              startChild: TimeLineChildAdmin(
                schedule: DummyDatas.schedule[index],
                isStartChild: true,
              ),
              indicatorStyle: IndicatorStyle(
                  indicatorXY: 0,
                  drawGap: true,
                  height: 12,
                  width: 12,
                  indicator: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        width: 2,
                        color: Colors.grey.shade500,
                      ),
                    ),
                  )),
              // beforeLineStyle:
              //     LineStyle(thickness: 1, color: Colors.grey.shade300),
              afterLineStyle:
                  LineStyle(thickness: 1, color: Colors.grey.shade300),
            ),
          );
        });
  }
}
