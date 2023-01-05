import 'package:flutter/material.dart';
import 'package:paytym/screens/calendar/Tabs/schedule/timeline_child.dart';
import 'package:timeline_tile/timeline_tile.dart';

import 'dummy_data.dart';


class CalendarSchedule extends StatelessWidget {
  const CalendarSchedule({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: DummyDatas.schedule.length,
        itemBuilder: (context, index) {
          return TimelineTile(
            alignment: TimelineAlign.manual,
            lineXY: 0.25,
            endChild: TimeLineChild(schedule: DummyDatas.schedule[index]),
            startChild: TimeLineChild(
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
            beforeLineStyle:
                LineStyle(thickness: 1, color: Colors.grey.shade300),
            afterLineStyle:
                LineStyle(thickness: 1, color: Colors.grey.shade300),
          );
        });
  }
}
