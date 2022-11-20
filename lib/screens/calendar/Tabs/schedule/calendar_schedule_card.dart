import 'package:flutter/material.dart';

import 'schedule_row.dart';

class CalendarScheduleCard extends StatelessWidget {
  const CalendarScheduleCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 8,
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: const [
              ScheduleRow(),
              Divider(
                thickness: 2,
                height: 40,
              ),
              ScheduleRow(),
            ],
          ),
        ));
  }
}
