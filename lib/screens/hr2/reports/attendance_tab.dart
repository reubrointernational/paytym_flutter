import 'package:flutter/material.dart';
import 'package:paytym/core/colors/colors.dart';



class EmployeeAttendanceTab extends StatelessWidget {
  const EmployeeAttendanceTab({super.key});

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
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            'Branch',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.grey.shade500,
                            ),
                          ),
                          const Text(
                            'Robin Reubro',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            '401020304',
                            style: TextStyle(
                              color: CustomColors.greyShade600TextColor,
                            ),
                          ),
                          Row(
                            children: [
                              RichText(
                                  text: const TextSpan(
                                      text: 'IN: ',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: CustomColors.blackTextColor,
                                      ),
                                      children: [
                                    TextSpan(
                                      text: '9:00 AM',
                                      style: TextStyle(
                                        color: CustomColors.blueTextColor,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ])),
                              const SizedBox(
                                width: 10,
                              ),
                              RichText(
                                  text: const TextSpan(
                                      text: 'OUT: ',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: CustomColors.blackTextColor,
                                      ),
                                      children: [
                                    TextSpan(
                                      text: '6:00 PM',
                                      style: TextStyle(
                                        color: CustomColors.blueTextColor,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ])),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // ApproveDeclineButton(
                          //     buttonText: 'Decline',
                          //     color: CustomColors.pinkColor,
                          //     bgColor: CustomColors.pinkWithOpacity),
                          // ApproveDeclineButton(
                          //     buttonText: 'Approve',
                          //     color: CustomColors.greenColorShade700,
                          //     bgColor: CustomColors.greenWithOpacity),
                          // ApproveDeclineButton(
                          //     buttonText: 'Upload',
                          //     color: CustomColors.orangeColor,
                          //     bgColor: CustomColors.orangeWithOpacity),
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
