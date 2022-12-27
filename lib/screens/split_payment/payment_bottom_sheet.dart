import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paytym/core/colors/colors.dart';
import 'package:paytym/core/constants/widgets.dart';

import 'payment_card_textfields.dart';
import 'payment_controller.dart';

class PaymentBottomSheet extends StatelessWidget {
  final String? image;
  final int? index;
  const PaymentBottomSheet({super.key, this.image, this.index});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Card details',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        kSizedBoxH4,
                        Text(
                          'Please enter your details',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade600,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    Image.asset(
                      image!,
                      height: size.height / 15,
                      width: size.width / 5,
                      fit: BoxFit.contain,
                    ),
                  ],
                ),
                kSizedBoxH15,
                const PaymentCardTextFields(
                  hint: 'Card Holder name',
                  label: 'name',
                  width: double.infinity,
                  keyboardType: TextInputType.text,
                ),
                const PaymentCardTextFields(
                  hint: 'Card Number',
                  label: '01230 4587 8901 1234',
                  width: double.infinity,
                  keyboardType: TextInputType.number,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    PaymentCardTextFields(
                      hint: 'Expiry Date',
                      label: '05/23',
                      width: size.width / 2 - 22,
                      keyboardType: TextInputType.datetime,
                    ),
                    PaymentCardTextFields(
                      hint: 'CCV',
                      label: '159',
                      width: size.width / 2 - 22,
                      keyboardType: TextInputType.number,
                    ),
                  ],
                ),
                const PaymentCardTextFields(
                    hint: 'Total',
                    label: '\$2000.00',
                    width: double.infinity,
                    keyboardType: TextInputType.number),
                kSizedBoxH15,
                Container(
                  height: size.height / 14,
                  width: size.width,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      paymentController.selectPaymentMethod(index);
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
