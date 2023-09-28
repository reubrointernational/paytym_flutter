import 'package:paytym/core/colors/colors.dart';
import 'package:paytym/core/constants/widgets.dart';
import 'package:paytym/screens/login/login_controller.dart';
import 'package:paytym/screens/widgets/paytym_logo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../core/constants/strings.dart';
import '../../routes/app_routes.dart';

class LicenseExpired extends StatelessWidget {
  const LicenseExpired({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.backgroundColor,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/png/license_exp.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Align(
                  alignment: Alignment.center,
                  child: PaytymLogo(),
                ),
                SizedBox(
                  height: h * 0.2,
                ),
                Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: CustomColors.lightBlueColor,
                          border:
                              Border.all(color: CustomColors.blueLabelColor),
                          borderRadius: BorderRadius.circular(10)),
                      height: MediaQuery.of(context).size.height / 4,
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                        child: Column(
                          children: [
                            Icon(
                              Icons.info_outline_rounded,
                              size: 100,
                              color: CustomColors.orangeLabelColor,
                            ),
                            Text(
                              kLicenseExpiredString,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: CustomColors.buttonColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    kSizedBoxH10,
                    // const Text(
                    //   kEnterTheOTPString,
                    //   style: TextStyle(
                    //     fontSize: 12.5,
                    //     color: CustomColors.blackTextColor,
                    //   ),
                    // ),
                    kSizedBoxH35,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      // children: List.generate(
                      //   4,
                      //   (index) => Container(
                      //     width: 50,
                      //     padding: const EdgeInsets.symmetric(
                      //         horizontal: 18, vertical: 4),
                      //     margin: const EdgeInsets.only(right: 8),
                      //     alignment: Alignment.center,
                      //     decoration: BoxDecoration(
                      //         color: CustomColors.greyFillTextFieldColor,
                      //         borderRadius: BorderRadius.circular(12),
                      //         border: Border.all(
                      //             width: 1.2,
                      //             color:
                      //                 const Color.fromRGBO(148, 148, 148, 0.37))),
                      //     child: TextField(
                      //       autofocus: index == 0 ? true : false,
                      //       style: const TextStyle(
                      //         fontSize: 18,
                      //       ),
                      //       onChanged: (value) {
                      //         Get.find<LoginController>().otpList[index] = value;
                      //         if (value.isNotEmpty && index != 3) {
                      //           FocusScope.of(context).nextFocus();
                      //         } else if (value.isEmpty && index != 0) {
                      //           FocusScope.of(context).previousFocus();
                      //         }
                      //       },
                      //       textInputAction: index == 3
                      //           ? TextInputAction.done
                      //           : TextInputAction.next,
                      //       keyboardType: TextInputType.number,
                      //       inputFormatters: [
                      //         FilteringTextInputFormatter.digitsOnly,
                      //         LengthLimitingTextInputFormatter(1),
                      //       ],
                      //       decoration: const InputDecoration(
                      //         hintText: "0",
                      //         hintStyle: TextStyle(
                      //           color: CustomColors.darkGreyTextColor,
                      //         ),
                      //         border: InputBorder.none,
                      //       ),
                      //     ),
                      //   ),
                      // ),
                    ),
                    kSizedBoxH40,
                    // Obx(
                    //   () => SizedBox(
                    //     height: 50,
                    //     width: double.infinity,
                    //     child: ElevatedButton(
                    //       onPressed:
                    //           Get.find<LoginController>().otpList.contains('')
                    //               ? null
                    //               : () {
                    //                   Get.find<LoginController>()
                    //                       .goToPasswordResetPage(
                    //                           Get.find<LoginController>()
                    //                               .otpList
                    //                               .reduce((value, element) =>
                    //                                   value + element));
                    //                 },
                    //       style: ElevatedButton.styleFrom(
                    //         backgroundColor: CustomColors.buttonColor,
                    //         shape: RoundedRectangleBorder(
                    //           borderRadius: BorderRadius.circular(50),
                    //         ),
                    //         disabledBackgroundColor:
                    //             CustomColors.disabledButtonColor,
                    //       ),
                    //       child: const Text(
                    //         kSubmitString,
                    //         style: TextStyle(
                    //           color: CustomColors.whiteTextColor,
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    kSizedBoxH60,
                    kSizedBoxH40,
                    SizedBox(
                      height: 50,
                      width: 100,
                      child: ElevatedButton(
                        onPressed: () {
                          Get.toNamed(Routes.login);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: CustomColors.buttonColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: const Text(
                          kLogInString,
                          style: TextStyle(
                            color: CustomColors.whiteTextColor,
                          ),
                        ),
                      ),
                    ),
                    // GestureDetector(
                    //   onTap: () {
                    //     print("Goto Login screen");
                    //     // Get.toNamed(Routes.login);
                    //   },
                    //   child: Text(
                    //     kLogInString,
                    //     style: TextStyle(
                    //       fontSize: 12.5,
                    //       color: CustomColors.blackTextColor,
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
