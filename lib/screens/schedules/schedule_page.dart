import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:timeline_tile/timeline_tile.dart';

import 'dummy_data.dart';
import 'schedules_app_bar.dart';
import 'widgets/end_child.dart';
import 'widgets/start_child.dart';
import 'widgets/table_calendar.dart';

class SchedulesPage extends StatefulWidget {
  const SchedulesPage({super.key});

  @override
  State<SchedulesPage> createState() => _SchedulesPageState();
}

class _SchedulesPageState extends State<SchedulesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: ListView(
                  children: const [
                    SchedulesAppBar(),
                    SizedBox(
                      height: 10,
                    ),
                    CustomTableCalendar(),
                  ],
                ),
              ),
            ),
            Divider(
              color: Colors.grey.shade300,
              height: 10,
              thickness: 3,
            ),
            Expanded(
              flex: 11,
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 1,
                      child: RichText(
                        text: const TextSpan(
                            text: 'Tuesday ',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black,
                            ),
                            children: [
                              TextSpan(
                                text: '12 December',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                            ]),
                      ),
                    ),
                    Expanded(
                      flex: 10,
                      child: ListView.builder(
                          itemCount: DummyDatas.schedules.length,
                          itemBuilder: (context, index) {
                            final time = DummyDatas.times[index];
                            final schedule = DummyDatas.schedules[index];
                            return TimelineTile(
                              alignment: TimelineAlign.manual,
                              lineXY: 0.25,
                              endChild: EndChildWidget(
                                schedule: schedule,
                              ),
                              startChild: StartChildWidget(
                                time: time,
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
                              beforeLineStyle: LineStyle(
                                  thickness: 1, color: Colors.grey.shade300),
                              afterLineStyle: LineStyle(
                                  thickness: 1, color: Colors.grey.shade300),
                            );
                          }),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
