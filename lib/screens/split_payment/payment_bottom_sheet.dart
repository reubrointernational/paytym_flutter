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
                  children: [
                    const Text(
                      'Split Payment',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    index == 0
                        ? const Icon(
                            Icons.account_balance,
                            size: 30,
                            color: Colors.blue,
                          )
                        : Image.asset(
                            image!,
                            height: h / 15,
                            width: w / 5,
                            fit: BoxFit.contain,
                          ),
                  ],
                ),
                kSizedBoxH15,
                PaymentCardTextFields(
                  hint: 'Enter the amount',
                  label: '0',
                  width: double.infinity,
                  keyboardType: TextInputType.number,
                  onChanged: (value) =>
                      Get.find<ReportsController>().splitAmount.value = value,
                ),
                SizedBox(
                  height: h / 14,
                  width: w,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      paymentController.selectPaymentMethod(index);
                      Get.find<ReportsController>().setSplitPayment(index);
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
