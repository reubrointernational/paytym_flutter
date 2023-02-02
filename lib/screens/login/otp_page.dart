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
    return Scaffold(
      backgroundColor: CustomColors.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Align(
              alignment: Alignment.center,
              child: PaytymLogo(),
            ),
            const Spacer(),
            const Text(
              kOTPString,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Color.fromRGBO(72, 13, 250, 1),
              ),
            ),
            kSizedBoxH10,
            const Text(
              kEnterTheOTPString,
              style: TextStyle(
                fontSize: 12.5,
                color: Colors.black,
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
                        border: Border.all(width: 1.2, color: Color.fromRGBO(148, 148, 148, 0.37))
                      ),
                      child: TextField(
                        autofocus: index == 0 ? true : false,
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                        onChanged: (value) {
                          Get.find<LoginController>().otpList[index] = value;
                          if (value.isNotEmpty && index != 3) {
                            FocusScope.of(context).nextFocus();
                          } else if (value.isEmpty && index != 0) {
                            FocusScope.of(context).previousFocus();
                          }
                        },
                        textInputAction: index == 3
                            ? TextInputAction.done
                            : TextInputAction.next,
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
            Obx(
              () => SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: Get.find<LoginController>().otpList.contains('')
                      ? null
                      : () {
                          Get.find<LoginController>().goToPasswordResetPage(
                              Get.find<LoginController>()
                                  .otpList
                                  .reduce((value, element) => value + element));
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(72, 13, 250, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    disabledBackgroundColor: CustomColors.disabledButtonColor,
                  ),
                  child: const Text(
                    kSubmitString,
                    style: TextStyle(
                      color: CustomColors.whiteTextColor,
                    ),
                  ),
                ),
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
