import 'package:paytym/core/colors/colors.dart';
import 'package:paytym/core/constants/widgets.dart';
import 'package:paytym/screens/login/login_controller.dart';
import 'package:paytym/screens/widgets/paytym_logo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../core/constants/strings.dart';

class OTPPage extends StatelessWidget {
  const OTPPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> otpList = ['0', '0', '0', '0'];
    return Scaffold(
      backgroundColor: CustomColors.backgroundColor,
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 50),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const PaytymLogo(),
              Padding(
                padding: const EdgeInsets.fromLTRB(25, 10, 25, 50),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      kOTPString,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: CustomColors.blueTextColor,
                      ),
                    ),
                    kSizedBoxH10,
                    const Text(
                      kEnterTheOTPString,
                      style: TextStyle(
                        fontSize: 12.5,
                        color: CustomColors.darkGreyTextColor,
                      ),
                    ),
                    kSizedBoxH35,
                    Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        height: 50,
                        width: 230,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 4,
                          itemBuilder: (context, index) {
                            return Container(
                              width: 50,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 18, vertical: 4),
                              margin: const EdgeInsets.only(right: 8),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: CustomColors.greyFillTextFieldColor,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: TextField(
                                style: const TextStyle(
                                  fontSize: 18,
                                ),
                                onChanged: (value) => otpList[index] = value,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                  LengthLimitingTextInputFormatter(1),
                                ],
                                decoration: const InputDecoration(
                                  hintText: "0",
                                  hintStyle: TextStyle(
                                    color: CustomColors.darkGreyTextColor,
                                  ),
                                  border: InputBorder.none,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    kSizedBoxH40,
                    SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Get.find<LoginController>().goToMainPage(otpList
                              .reduce((value, element) => value + element));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: CustomColors.blueTextColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          kSubmitString,
                          style: TextStyle(
                            color: CustomColors.whiteTextColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              kSizedBoxH60,
            ],
          ),
        ),
      ),
    );
  }
}
