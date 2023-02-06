import 'package:flutter/material.dart';
import '../../../../core/constants/styles.dart';
import '../../../../core/constants/widgets.dart';

class MedicalTitleTag extends StatelessWidget {
  final String branch;
  final String name;
  final String employmentId;
  const MedicalTitleTag({
    Key? key,
    required this.branch,
    required this.name,
    required this.employmentId,
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              name,
              style:
                  kTextStyleS14W600Cgrey300LS0p2.copyWith(color: Colors.black),
            ),
            Text(
              employmentId,
              style:
                  kTextStyleS14W600Cgrey300LS0p2.copyWith(color: Colors.grey),
            ),
          ],
        ),
        Divider(
          thickness: 1,
          height: 24,
          color: Colors.grey.shade200,
        ),
      ],
    );
  }
}
