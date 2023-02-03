import 'package:flutter/material.dart';

class PaymentCardTextFields extends StatelessWidget {
  final String? hint;
  final String? label;
  final double? width;
  final TextInputType? keyboardType;
  const PaymentCardTextFields(
      {super.key, this.hint, this.label, this.width, this.keyboardType});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      margin: const EdgeInsets.only(bottom: 6),
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: Colors.grey.shade400),
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey.shade100,
      ),
      child: Wrap(children: [
        Text(
          hint!,
          style: TextStyle(
            color: Colors.grey.shade600,
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
        ),
        TextFormField(
            keyboardType: keyboardType,
            maxLines: null,
            decoration: InputDecoration(
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(vertical: 8),
              hintText: label,
              border: InputBorder.none,
            )),
      ]),
    );
  }
}
