import 'package:flutter/material.dart';
import 'package:paytym/core/colors/colors.dart';

class EmployeeProjectsTab extends StatelessWidget {
  const EmployeeProjectsTab({super.key});

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
              constraints: const BoxConstraints(maxHeight: 120),
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
                          Text(
                            'Paytym',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.grey.shade600,
                            ),
                          ),
                          const Text(
                            'Robin Reubro',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const Flexible(
                            child: Text(
                              'Akhil, Noushad, Sreejith, Sreehari',
                              style: TextStyle(),
                            ),
                          ),
                          Text(
                            'Status: Progressing',
                            style: TextStyle(
                              color: CustomColors.greyShade600TextColor,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Branch',
                            style: TextStyle(
                              color: CustomColors.greyShade600TextColor,
                            ),
                          ),
                          const Icon(
                            Icons.download,
                            color: Colors.orange,
                          ),
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
