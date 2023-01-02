import 'package:flutter/material.dart';

class StartChildWidget extends StatelessWidget {
  final Map<String, dynamic> time;
  const StartChildWidget({super.key, required this.time});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            time['start_time'],
            style: const TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
          Text(
            time['end_time'],
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
