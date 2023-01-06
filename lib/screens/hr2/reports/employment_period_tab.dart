import 'package:flutter/material.dart';
import 'package:paytym/core/colors/colors.dart';

class EmployeesEmploymentPeriod extends StatelessWidget {
  const EmployeesEmploymentPeriod({super.key});

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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Employment Period: ',
                          style: TextStyle(
                            fontSize: 13,
                            color: CustomColors.greyShade600TextColor,
                          ),
                        ),
                        const Text(
                          '6 Month',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: CustomColors.blueTextColor,
                          ),
                        ),
                      ],
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
