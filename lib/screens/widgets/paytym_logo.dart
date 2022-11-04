import 'package:flutter/material.dart';

class PaytymLogo extends StatelessWidget {
  const PaytymLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: const TextSpan(
        text: "Pay",
        style: TextStyle(
          fontSize: 40,
          fontWeight: FontWeight.w700,
          color: Color.fromRGBO(75, 103, 176, 1),
        ),
        children: [
          TextSpan(
            text: 'tym',
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
