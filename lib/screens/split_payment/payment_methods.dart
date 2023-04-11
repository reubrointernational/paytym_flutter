import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paytym/core/colors/colors.dart';
import 'package:paytym/core/constants/icons.dart';
import 'package:paytym/core/constants/strings.dart';
import 'package:paytym/core/dialog_helper.dart';
import 'package:paytym/screens/employee/reports/reports_controller.dart';

import 'payment_bottom_sheet.dart';
import 'payment_controller.dart';

class PaymentMethods extends StatefulWidget {
  const PaymentMethods({super.key});

  @override
  State<PaymentMethods> createState() => _PaymentMethodsState();
}

class _PaymentMethodsState extends State<PaymentMethods> {
  @override
  Widget build(BuildContext context) {
    final paymentController = Get.put(PaymentController());

    return SizedBox(
      height: h / 4.5,
      width: w,
      child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: 3,
        separatorBuilder: (context, index) => const SizedBox(
          width: 8,
        ),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              DialogHelper.showBottomSheet(
                PaymentBottomSheet(
                    image: paymentController.getImagePath(index), index: index),
              );
            },
            child: Container(
              width: w / 3.5,
              //margin: const EdgeInsets.only(right: 15),
              decoration: BoxDecoration(
                  color: CustomColors.whiteTextColor,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(width: 2, color: Colors.orange)),
              child: Stack(
                children: [
                  Positioned(
                    top: 20,
                    left: -10,
                    child: Container(
                      height: 25,
                      width: 90,
                      color: Colors.amber,
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.only(left: 10),
                      transform: Matrix4.rotationZ(-0.5),
                      child: Text(
                        'SPLIT',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1.2,
                            fontSize: 13,
                            color: Colors.orange.shade800),
                      ),
                    ),
                  ),
                  index == 0
                      ? const Center(
                          child: Icon(
                            Icons.account_balance,
                            size: 30,
                            color: Colors.blue,
                          ),
                        )
                      : Center(
                          child: Image.asset(
                            paymentController.getImagePath(index),
                            height: h * 0.08,
                            width: w * 0.25,
                            fit: BoxFit.contain,
                          ),
                        ),
                  Positioned(
                      bottom: 20,
                      left: 0,
                      right: 0,
                      child: Obx(() => Text(
                            Get.find<ReportsController>().getSplitAmount(index),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: CustomColors.greyShade600TextColor,
                            ),
                          ))),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
