import 'package:flutter/material.dart';

import 'event_row.dart';

class CalendarEventCardAdmin extends StatelessWidget {
  final int index;
  const CalendarEventCardAdmin({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 8,
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              EventRow(index: index,),
              // Divider(
              //   thickness: 2,
              //   height: 40,
              // ),
              // EventRow(),
            ],
          ),
        ));
  }
}
