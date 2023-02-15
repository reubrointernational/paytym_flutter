import 'package:flutter/material.dart';
import 'package:paytym/core/constants/strings.dart';
import 'package:paytym/core/constants/widgets.dart';

import '../../../../core/constants/icons.dart';
import '../../../../core/dialog_helper.dart';
import 'payment_history.dart';

class PayPayment extends StatelessWidget {
  const PayPayment({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    InkWell(
                      onTap: () {
                        DialogHelper.showConfirmDialog(
                          title: 'Download',
                          desc: 'Do you want to download this file?',
                        );
                      },
                      child: CircleAvatar(
                        radius: w / 8,
                        backgroundColor: Colors.blue,
                        child: CircleAvatar(
                          radius: w / 8 - 3,
                          backgroundColor: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: const [
                                Icon(
                                  Icons.account_balance,
                                  color: Colors.blue,
                                ),
                                Text(
                                  'Bank Account',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.blue),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    kSizedBoxH10,
                    Text(
                      '\$ 4000',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.amber.shade800,
                      ),
                    ),
                  ],
                ),
                kSizedBoxW10,
                Column(
                  children: [
                    InkWell(
                      onLongPress: () {
                        DialogHelper.showConfirmDialog(
                          title: 'Pay Now',
                          desc:
                              'Do you like to proceed with the m-pesa payment?',
                        );
                      },
                      child: CircleAvatar(
                        radius: w / 8,
                        backgroundColor: Colors.green,
                        child: CircleAvatar(
                          radius: w / 8.5,
                          backgroundColor: Colors.white,
                          child: Image.asset(
                            IconPath.mPesaPng,
                            height: h * 0.3,
                            width: w * 0.3,
                          ),
                        ),
                      ),
                    ),
                    kSizedBoxH10,
                    Text(
                      '\$ 2000',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.amber.shade800,
                      ),
                    ),
                  ],
                ),
                kSizedBoxW10,
                Column(
                  children: [
                    InkWell(
                      onLongPress: () {
                        DialogHelper.showConfirmDialog(
                          title: 'Pay Now',
                          desc:
                              'Do you like to proceed with the mycash payment?',
                        );
                      },
                      child: CircleAvatar(
                        radius: w / 8,
                        backgroundColor: Colors.red,
                        child: CircleAvatar(
                          radius: w / 8.5,
                          backgroundColor: Colors.white,
                          child: Image.asset(
                            IconPath.myCashPng,
                            height: h * 0.3,
                            width: w * 0.3,
                          ),
                        ),
                      ),
                    ),
                    kSizedBoxH10,
                    Text(
                      '\$ 1500',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.amber.shade800,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            kSizedBoxH15,
            const PaymentHistory(),
          ],
        ),
      ),
    );
  }
}
