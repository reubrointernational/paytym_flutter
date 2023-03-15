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
    List<Map<String, dynamic>> paymentMethods = [
      {
        'icon': IconPath.windcavePng,
        'selected': Get.find<PaymentController>().isWindcaveSelected.value,
        'amount': 00.00
      },
      {
        'icon': IconPath.mPesaPng,
        'selected': Get.find<PaymentController>().isMpesaSelected.value,
        'amount': 00.00
      },
      {
        'icon': IconPath.myCashPng,
        'selected': Get.find<PaymentController>().isMyCashSelected.value,
        'amount': 00.00
      },
    ];
    return SizedBox(
      height: h / 4.5,
      width: w,
      child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: paymentMethods.length,
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
                  Obx(() {
                    return Get.find<ReportsController>()
                                .splitPaymentAmountList[index] >
                            0
                        ? Positioned(
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
                                'Split'.toUpperCase(),
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 1.2,
                                    fontSize: 13,
                                    color: Colors.orange.shade800),
                              ),
                            ),
                          )
                        : const SizedBox();
                  }),
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
                            paymentMethods[index]['icon'],
                            height: h * 0.08,
                            width: w * 0.25,
                            fit: BoxFit.contain,
                          ),
                        ),
                  Positioned(
                    bottom: 20,
                    left: 0,
                    right: 0,
                    child: Get.find<ReportsController>()
                                .splitPaymentResponseModel
                                .value
                                .splitpayment !=
                            null
                        ? Text(
                            Get.find<ReportsController>()
                                        .splitPaymentResponseModel
                                        .value
                                        .splitpayment!
                                        .id ==
                                    index
                                ? '\$${Get.find<ReportsController>().splitAmount}'
                                : '\$0',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: CustomColors.greyShade600TextColor,
                            ),
                          )
                        : Text(
                            '\$0',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: CustomColors.greyShade600TextColor,
                            ),
                          ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
