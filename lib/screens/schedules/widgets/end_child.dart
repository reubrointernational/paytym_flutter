import 'package:flutter/material.dart';

class EndChildWidget extends StatelessWidget {
  final Map<String, dynamic> schedule;
  const EndChildWidget({super.key, required this.schedule});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Flexible(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              schedule['task'],
              style: const TextStyle(
                fontSize: 13.5,
              ),
            ),
            Text(
              schedule['location'],
              style: const TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
