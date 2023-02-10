import 'package:flutter/material.dart';
import 'package:paytym/core/constants/strings.dart';
import 'package:paytym/core/constants/widgets.dart';

class PayPayment extends StatelessWidget {
  const PayPayment({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: w / 8,
          child: const Text('Bank Account', textAlign: TextAlign.center,),
        ),
        kSizedBoxW10,
        CircleAvatar(
          radius: w / 8,
          child: const Text('MPesa'),
        ),
        kSizedBoxW10,
        CircleAvatar(
          radius: w / 8,
          child: const Text('MyCash'),
        ),
      ],
    );
  }
}
