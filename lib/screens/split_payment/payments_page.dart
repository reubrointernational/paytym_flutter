import 'package:flutter/material.dart';
import 'package:paytym/core/colors/colors.dart';
import 'package:paytym/core/constants/strings.dart';
import 'package:paytym/core/constants/widgets.dart';
import 'package:paytym/screens/split_payment/payment_controller.dart';

import 'payment_methods.dart';

class PaymentsPage extends StatefulWidget {
  const PaymentsPage({super.key});

  @override
  State<PaymentsPage> createState() => _PaymentsPageState();
}

class _PaymentsPageState extends State<PaymentsPage> {
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: CustomColors.blueTextColor,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 12,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            Text(
                              'Would you like to',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontFamily: 'DMSerif'),
                            ),
                            kSizedBoxH10,
                            Text(
                              'Split Your Salary',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 28,
                                  fontFamily: 'DMSerif'),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: w,
                        padding: const EdgeInsets.all(30),
                        decoration: BoxDecoration(
                          color: CustomColors.whiteTextColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Your balance is',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: CustomColors.blueTextColor,
                                ),
                              ),
                              kSizedBoxH10,
                              Text(
                                '\$45,782.00',
                                style: TextStyle(
                                  fontSize: 35,
                                  color: Colors.grey.shade600,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              kSizedBoxH6,
                              RichText(
                                text: const TextSpan(
                                    text: '8,82% ',
                                    style: TextStyle(
                                      color: CustomColors.blackTextColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: '(+\$876)',
                                        style: TextStyle(
                                          color: CustomColors.greyTextColor,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ]),
                              )
                            ]),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Payment Method',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                          kSizedBoxH10,
                          Text(
                            'Select your payment method',
                            style: TextStyle(
                              color: Colors.white70,
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      const PaymentMethods(),
                    ]),
              ),
            ),
            Expanded(
              flex: 3,
              child: Align(
                alignment: Alignment.center,
                child: SizedBox(
                  height: h / 15,
                  width: w / 1.8,
                  child: ElevatedButton(
                    onPressed: () {
                      // PaymentController().goToMPaisaPayment();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      padding: const EdgeInsets.all(10),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    child: const Text(
                      'Continue',
                      style: TextStyle(
                        color: CustomColors.blueTextColor,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
