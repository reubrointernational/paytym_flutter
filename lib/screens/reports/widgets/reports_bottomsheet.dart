import 'package:flutter/material.dart';

import '../../../core/colors/colors.dart';
import '../../../core/constants/strings.dart';
import '../../../core/constants/styles.dart';
import '../../../core/constants/widgets.dart';

class ReportsBottomsheet extends StatelessWidget {
  const ReportsBottomsheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      padding: const EdgeInsets.all(28),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          topLeft: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            kRequestAdvanceString,
            style:
                kTextStyleS18W600.copyWith(color: CustomColors.blueTextColor),
          ),
          kSizedBoxH10,
          Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                  hintText: kNameString,
                  hintStyle: const TextStyle(
                    color: CustomColors.greyTextColor,
                    fontSize: 14,
                  ),
                  enabledBorder: kInputBorderBlueW1p2,
                  focusedBorder: kInputBorderBlueW1p2,
                ),
              ),
              kSizedBoxH10,
              TextFormField(
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                  hintText: kEmployeeIDString,
                  hintStyle: const TextStyle(
                    color: CustomColors.greyTextColor,
                    fontSize: 14,
                  ),
                  enabledBorder: kInputBorderBlueW1p2,
                  focusedBorder: kInputBorderBlueW1p2,
                ),
              ),
              kSizedBoxH10,
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                  hintText: kAmountString,
                  hintStyle: const TextStyle(
                    color: CustomColors.greyTextColor,
                    fontSize: 14,
                  ),
                  enabledBorder: kInputBorderBlueW1p2,
                  focusedBorder: kInputBorderBlueW1p2,
                ),
              ),
            ],
          ),
          kSizedBoxH10,
          SizedBox(
            height: 50,
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: CustomColors.blueTextColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                kRequestAdvanceString,
                style: TextStyle(
                  color: CustomColors.whiteTextColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
