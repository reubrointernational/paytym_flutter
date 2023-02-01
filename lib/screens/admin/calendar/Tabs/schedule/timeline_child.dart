import 'package:flutter/material.dart';

class TimeLineChildAdmin extends StatelessWidget {
  final Map<String, dynamic> schedule;
  final bool isStartChild;
  const TimeLineChildAdmin(
      {super.key, required this.schedule, this.isStartChild = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            !isStartChild ? schedule['task'] : schedule['start_time'],
            style: const TextStyle(
              fontSize: 13.5,
            ),
          ),
          Text(
            !isStartChild ? schedule['location'] : schedule['end_time'],
            style: const TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
