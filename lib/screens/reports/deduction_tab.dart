import 'package:flutter/material.dart';

import '../../core/colors/colors.dart';
import '../../core/constants/strings.dart';
import '../../core/constants/styles.dart';

class DeductionPage extends StatelessWidget {
  const DeductionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 2,
      itemBuilder: (context, index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                "01-09-2022",
                style: kTextStyleS13W600CustomGrey,
              ),
            ),
            Container(
              height: 180,
              padding: const EdgeInsets.only(top: 8, bottom: 10),
              child: Card(
                color: CustomColors.whiteCardColor,
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        kDeductionsString,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            kFundDeductionsString,
                            style: kTextStyleS12W600CcustomGrey,
                          ),
                          Text(
                            "\$20.00",
                            style: kTextStyleS12W600CcustomGrey,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            kProfessionalTaxString,
                            style: kTextStyleS12W600CcustomGrey,
                          ),
                          Text(
                            "\$10.00",
                            style: kTextStyleS12W600CcustomGrey,
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              kTotalString,
                              style: kTextStyleS13W600Cblue,
                            ),
                            Text(
                              "\$30.00",
                              style: kTextStyleS13W600Cblue,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
