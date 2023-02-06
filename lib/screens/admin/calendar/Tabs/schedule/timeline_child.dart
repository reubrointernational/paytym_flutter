import 'package:flutter/material.dart';
import 'package:paytym/core/constants/widgets.dart';

class TimeLineChildAdmin extends StatelessWidget {
  final Map<String, dynamic> schedule;
  final bool isStartChild;
  const TimeLineChildAdmin(
      {super.key, required this.schedule, this.isStartChild = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
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
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              isStartChild
                  ? const SizedBox()
                  : IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.add_circle_outline,
                        color: Colors.green,
                      ),
                    ),
              isStartChild
                  ? const SizedBox()
                  : IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.delete_outline_outlined,
                        color: Colors.red,
                      ),
                    ),
            ],
          ),
          kSizedBoxH20
        ],
      ),
    );
  }
}
