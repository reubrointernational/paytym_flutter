import 'package:flutter/material.dart';

import 'approve_decline_btn.dart';

class LeavesTabDetails extends StatelessWidget {
  const LeavesTabDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 6,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 2),
          child: Card(
            shape: RoundedRectangleBorder(
              side: BorderSide(width: 1, color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8),
            ),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 85),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Rhys Hawkins',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            '004579942',
                            style: TextStyle(
                              color: Colors.grey.shade600,
                            ),
                          ),
                          const Text(
                            'Casual',
                            style: TextStyle(
                              color: Colors.orange,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ApproveDeclineButton(buttonText: 'Decline',color: Colors.pink,
                             bgColor: Colors.pinkAccent.withOpacity(0.2)),
                          ApproveDeclineButton(
                              buttonText: 'Approve',
                              color: Colors.green.shade700,
                              bgColor: Colors.greenAccent.withOpacity(0.5)),
                        ],
                      ),
                    ]),
              ),
            ),
          ),
        );
      },
    );
  }
}
