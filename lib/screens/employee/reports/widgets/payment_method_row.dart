import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paytym/core/colors/colors.dart';

import 'package:paytym/core/constants/strings.dart';
import 'package:paytym/core/dialog_helper.dart';
import 'package:paytym/screens/employee/reports/reports_controller.dart';

import 'payment_bottom_sheet.dart';

class PaymentMethodRow extends StatefulWidget {
  const PaymentMethodRow({super.key});

  @override
  State<PaymentMethodRow> createState() => _PaymentMethodRowState();
}

class _PaymentMethodRowState extends State<PaymentMethodRow> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: h / 4.5,
        width: w,
        child: ListView.separated(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: 3,
            separatorBuilder: (context, index) => const SizedBox(
                  width: 14,
                ),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  DialogHelper.showBottomSheet(
                    PaymentBottomSheet(
                        image:
                            Get.find<ReportsController>().getImagePath(index),
                        index: index),
                  );
                },
                child: Container(
                  height: h / 4.5,
                  width: w / 3,
                  //margin: const EdgeInsets.only(right: 15),
                  decoration: BoxDecoration(
                    color: CustomColors.whiteCardColor,
                    border: Border.all(width: 3, color: Colors.grey.shade400),
                    borderRadius: BorderRadius.circular(20),
                  ),
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
                                  color: Colors.blue,
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
                                Get.find<ReportsController>()
                                    .getImagePath(index),
                                height: h / 10,
                                width: w / 5,
                                fit: BoxFit.contain,
                              ),
                            ),
                      Positioned(
                        bottom: 20,
                        left: 0,
                        right: 0,
                        child: Text(
                          '\$${Get.find<ReportsController>().splitPaymentAmountList[index]}',
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
            }));
  }
}
