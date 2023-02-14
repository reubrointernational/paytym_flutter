import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paytym/screens/admin/reports/widgets/rounded_icons.dart';

import '../../../../core/constants/styles.dart';
import '../../../../core/constants/widgets.dart';
import '../reports_controller.dart';

class AttendanceTabAdmin extends StatelessWidget {
  const AttendanceTabAdmin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
        (_) => Get.find<ReportsControllerAdmin>().getDeduction());
    return Obx(
      () => ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: Get.find<ReportsControllerAdmin>()
                .deductionResponseModel
                .value
                .deductions
                ?.length ??
            0,
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade200),
                borderRadius: BorderRadius.circular(10)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const AttendanceCardColumn(),
                const AttendanceCardColumn(
                  isLeftTab: true,
                ),
                Column(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: RoundedIcon(
                        iconPath: Icons.done,
                        circleColor: Colors.green.shade100,
                      ),
                    ),
                    IconButton(
                      onPressed: Get.find<ReportsControllerAdmin>()
                            .showBottomSheetForReason,
                      icon: RoundedIcon(
                        iconPath: Icons.edit_outlined,
                        iconColor: Colors.blue,
                        circleColor: Colors.blue.shade100,
                      ),
                    ),
                    IconButton(
                      onPressed: Get.find<ReportsControllerAdmin>()
                          .showBottomSheetForReason,
                      icon: RoundedIcon(
                        iconPath: Icons.close,
                        iconColor: Colors.red,
                        circleColor: Colors.red.shade100,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class AttendanceCardColumn extends StatelessWidget {
  final bool isLeftTab;
  const AttendanceCardColumn({
    Key? key,
    this.isLeftTab = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Branch/Dept',
            style: isLeftTab ? kTextStyleS15W600CBlack : kTextStyleS15W600CGrey,
          ),
          kSizedBoxH4,
          Text(
            'Name',
            style: isLeftTab ? kTextStyleS15W600CBlack : kTextStyleS15W600CGrey,
          ),
          kSizedBoxH4,
          Text(
            'Employee ID',
            style: isLeftTab ? kTextStyleS15W600CBlack : kTextStyleS15W600CGrey,
          ),
          kSizedBoxH20,
          const Text(
            'Check-in',
            style: kTextStyleS15W600CBlack,
          ),
          kSizedBoxH4,
          Text(
            '09:00 AM',
            style: kTextStyleS15W600CBlack.copyWith(
                color: !isLeftTab ? Colors.green : Colors.red),
          ),
        ],
      ),
    );
  }
}
