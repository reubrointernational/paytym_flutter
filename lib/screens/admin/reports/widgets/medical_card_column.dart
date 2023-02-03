import 'package:flutter/material.dart';
import '../../../../core/constants/styles.dart';
import '../../../../core/constants/widgets.dart';

class MedicalCardColumn extends StatelessWidget {
  final String branch;
  final String name;
  final String heading;
  final String condition;
  final bool isNameGrey;
  final bool isHeadingBlue;
  const MedicalCardColumn({
    Key? key,
    required this.branch,
    required this.name,
    required this.heading,
    required this.condition,
    this.isNameGrey = false, this.isHeadingBlue = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          branch,
          style: kTextStyleS12W600CcustomGrey,
        ),
        kSizedBoxH8,
        Text(
          name,
          style: kTextStyleS14W600Cgrey300LS0p2.copyWith(
              color: isNameGrey ? Colors.grey : Colors.black),
        ),
        Divider(
          thickness: 1,
          height: 24,
          color: Colors.grey.shade200,
        ),
        Text(heading,
            style: kTextStyleS14C255140x3.copyWith(fontWeight: isHeadingBlue?FontWeight.bold:null, color: isHeadingBlue? Colors.lightBlue: Colors.black)),
        kSizedBoxH4,
        Text(condition,
            style: kTextStyleS14C255140x3.copyWith(color: Colors.lightBlue)),
      ],
    );
  }
}
