import 'package:flutter/material.dart';

import 'event_row.dart';

class CalendarEventCard extends StatelessWidget {
  const CalendarEventCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 8,
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: const [
              EventRow(),
              Divider(
                thickness: 2,
                height: 40,
              ),
              EventRow(),
            ],
          ),
        ));
  }
}
