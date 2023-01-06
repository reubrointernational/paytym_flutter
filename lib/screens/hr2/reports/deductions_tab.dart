import 'package:flutter/material.dart';
import 'package:paytym/core/colors/colors.dart';

import '../../../core/constants/strings.dart';
import '../../../core/constants/styles.dart';

class EmployeesDeductionTab extends StatelessWidget {
  const EmployeesDeductionTab({super.key});

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
                          'March/2022',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: CustomColors.greyShade600TextColor,
                          ),
                        ),
                        Text(
                          'Branch',
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
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              kFundDeductionsString,
                              style: kTextStyleS12W600CcustomGrey,
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            Text(
                              '\$1000',
                              style: TextStyle(
                                fontSize: 14,
                                color: CustomColors.blueTextColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              kProfessionalTaxString,
                              style: kTextStyleS12W600CcustomGrey,
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            Text(
                              '\$2000',
                              style: TextStyle(
                                fontSize: 14,
                                color: CustomColors.blueTextColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              kTotalString,
                              style: kTextStyleS12W600CcustomGrey,
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            Text(
                              '\$3000',
                              style: TextStyle(
                                fontSize: 14,
                                color: CustomColors.blueTextColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
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
