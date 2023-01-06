import 'package:flutter/material.dart';

import '../../../core/colors/colors.dart';
import '../../../core/constants/strings.dart';

class EmployeesMedicalTab extends StatelessWidget {
  const EmployeesMedicalTab({super.key});

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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Branch',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: CustomColors.greyShade600TextColor,
                          ),
                        ),
                        Text(
                          '',
                          style: TextStyle(
                            fontSize: 12,
                            color: CustomColors.greyShade600TextColor,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Akhil Reubro',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          '4095030201',
                          style: TextStyle(
                            color: CustomColors.greyShade600TextColor,
                          ),
                        ),
                      ],
                    ),
                    const Divider(
                      thickness: 2,
                      height: 10,
                    ),
                    IntrinsicHeight(
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  "Medical Conditions: ",
                                  style: TextStyle(
                                    fontSize: 13,
                                  ),
                                ),
                                SizedBox(
                                  height: 6,
                                ),
                                Flexible(
                                  child: Text(
                                    'Hypertension, Depression',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: CustomColors.blueTextColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          VerticalDivider(
                            width: w * 0.1,
                            thickness: 2,
                            color: Colors.grey.shade400,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  "Medications: ",
                                  style: TextStyle(
                                    fontSize: 13,
                                  ),
                                ),
                                SizedBox(
                                  height: 6,
                                ),
                                Flexible(
                                  child: Text(
                                    'Medicines',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: CustomColors.blueTextColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
