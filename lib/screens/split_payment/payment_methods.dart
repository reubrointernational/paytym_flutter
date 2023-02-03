import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paytym/core/colors/colors.dart';
import 'package:paytym/core/constants/icons.dart';
import 'package:paytym/core/dialog_helper.dart';

import 'payment_bottom_sheet.dart';
import 'payment_controller.dart';

class PaymentMethods extends StatefulWidget {
  const PaymentMethods({super.key});

  @override
  State<PaymentMethods> createState() => _PaymentMethodsState();
}

class _PaymentMethodsState extends State<PaymentMethods> {
  Widget build(BuildContext context) {
    @override
    var size = MediaQuery.of(context).size;
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
        height: size.height / 4.5,
        width: size.width,
        child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: paymentMethods.length,
            separatorBuilder: (context, index) => const SizedBox(
                  width: 14,
                ),
            itemBuilder: (context, index) {
              final payment = paymentMethods[index];
              print(payment['selected']);
              return GestureDetector(
                onTap: () {
                  DialogHelper.showBottomSheet(PaymentBottomSheet(
                      image: paymentController.getImagePath(index),
                      index: index));
                },
                child: Container(
                  width: size.width / 3.5,
                  //margin: const EdgeInsets.only(right: 15),
                  decoration: BoxDecoration(
                    color: CustomColors.whiteTextColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Stack(
                    children: [
                      payment['selected']
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
                          : Container(),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 15),
                        child: Center(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Image.asset(
                                  payment['icon'],
                                  height: size.height / 10,
                                  width: size.width / 5,
                                  fit: BoxFit.contain,
                                ),
                                Flexible(
                                  child: Text(
                                    '\$${payment['amount']}',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: CustomColors.greyShade600TextColor,
                                    ),
                                  ),
                                ),
                                /*Padding(
                                      padding: const EdgeInsets.only(bottom: 10),
                                      child: CircleAvatar(
                                        backgroundColor: CustomColors.blueTextColor,
                                        radius: 10,
                                        child: CircleAvatar(
                                          backgroundColor: Colors.white,
                                          radius: 8,
                                          child: payment['selected']
                                              ? const CircleAvatar(
                                                  backgroundColor:
                                                      CustomColors.blueTextColor,
                                                  radius: 6,
                                                )
                                              : null,
                                        ),
                                      ),
                                    ),*/
                              ]),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }));
  }
}
