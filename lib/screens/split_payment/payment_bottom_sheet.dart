import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paytym/core/colors/colors.dart';
import 'package:paytym/core/constants/strings.dart';
import 'package:paytym/core/constants/widgets.dart';
import 'package:paytym/screens/employee/reports/reports_controller.dart';

import 'payment_card_textfields.dart';
import 'payment_controller.dart';

class PaymentBottomSheet extends StatelessWidget {
  final String? image;
  final int? index;
  const PaymentBottomSheet({super.key, this.image, this.index});

  @override
  Widget build(BuildContext context) {
    final paymentController = Get.put(PaymentController());
    return SingleChildScrollView(
      child: Container(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      'Split Payment',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                kSizedBoxH15,
                PaymentCardTextFields(
                  hint: 'Enter percentage for bank account',
                  label: '0',
                  width: double.infinity,
                  keyboardType: TextInputType.number,
                  onChanged: (value) =>
                      Get.find<ReportsController>().splitAmount[0] = int.parse(value),
                ),
                PaymentCardTextFields(
                  hint: 'Enter percentage for M-Paisa',
                  label: '0',
                  width: double.infinity,
                  keyboardType: TextInputType.number,
                  onChanged: (value) =>
                      Get.find<ReportsController>()
                      .splitAmount[1] = int.parse(value),
                ),
                PaymentCardTextFields(
                  hint: 'Enter percentage for MyCash',
                  label: '0',
                  width: double.infinity,
                  keyboardType: TextInputType.number,
                  onChanged: (value) =>
                      Get.find<ReportsController>()
                      .splitAmount[2] = int.parse(value),
                ),
                SizedBox(
                  height: 60,
                  width: w,
                  child: ElevatedButton(
                    onPressed: () {
                      

                      Get.find<ReportsController>().setSplitPayment(context);
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      backgroundColor: CustomColors.blueTextColor,
                    ),
                    child: const Text(
                      'Save Payment',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}
