import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paytym/core/colors/colors.dart';
import 'package:paytym/core/constants/strings.dart';
import 'package:paytym/core/constants/widgets.dart';
import 'package:paytym/screens/employee/reports/reports_controller.dart';
import 'package:paytym/screens/split_payment/payment_controller.dart';

import '../../../login/login_controller.dart';
import '../../../split_payment/payment_methods.dart';

class SplitPaymentTab extends StatefulWidget {
  const SplitPaymentTab({super.key});

  @override
  State<SplitPaymentTab> createState() => _SplitPaymentTabState();
}

class _SplitPaymentTabState extends State<SplitPaymentTab> {
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
        (_) => Get.find<ReportsController>().getSplitPayment());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(30),
                      decoration: BoxDecoration(
                        color: CustomColors.whiteTextColor,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(width: 1, color: Colors.black),
                      ),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Your balance is',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: CustomColors.blackTextColor,
                              ),
                            ),
                            kSizedBoxH10,
                            Text(
                              '\$${Get.find<LoginController>().loginResponseModel?.employee?.rate ?? '0'}',
                              style: TextStyle(
                                fontSize: 35,
                                color: Colors.grey.shade600,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ]),
                    ),
                    kSizedBoxH20,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Payment Method',
                          style: TextStyle(
                            color: Colors.orange.shade800,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                        kSizedBoxH15,
                      ],
                    ),
                    const PaymentMethods(),
                  ]),
            ),
            // Align(
            //   alignment: Alignment.center,
            //   child: SizedBox(
            //     height: h / 15,
            //     width: w / 1.6,
            //     child: ElevatedButton(
            //       onPressed: () {
            //         // PaymentController().goToMPaisaPayment();
            //       },
            //       style: ElevatedButton.styleFrom(
            //         backgroundColor: Colors.white,
            //         padding: const EdgeInsets.all(10),
            //         shape: RoundedRectangleBorder(
            //             side: const BorderSide(
            //                 width: 1, color: CustomColors.blueCardColor),
            //             borderRadius: BorderRadius.circular(10)),
            //       ),
            //       child: const Text(
            //         'Submit',
            //         style: TextStyle(
            //           color: CustomColors.blueTextColor,
            //           fontSize: 16,
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
