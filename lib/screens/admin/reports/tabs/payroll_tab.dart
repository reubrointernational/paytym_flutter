import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paytym/screens/admin/reports/reports_controller.dart';
import 'package:paytym/screens/admin/reports/widgets/pending_payroll_listview.dart';
import '../widgets/pay_payment.dart';

class PayrollTab extends StatefulWidget {
  const PayrollTab({super.key});

  @override
  State<PayrollTab> createState() => _PayrollTabState();
}

class _PayrollTabState extends State<PayrollTab> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // SizedBox(
        //   height: 60,
        //   child: ListView(
        //     scrollDirection: Axis.horizontal,
        //     children: [
        //       // Obx(() {
        //       //   return CustomDropdownYearButton(
        //       //     lists: years,
        //       //     value: Get.find<ReportsControllerAdmin>()
        //       //         .selectedDropdownYear
        //       //         .value,
        //       //     onChanged: (value) {
        //       //       Get.find<ReportsControllerAdmin>()
        //       //           .selectedDropdownYear
        //       //           .value = value!;
        //       //     },
        //       //     hint: '2022 ',
        //       //   );
        //       // }),
        //       ...List.generate(
        //         2,
        //         (index) => InkWell(
        //           onTap: () => Get.find<ReportsControllerAdmin>()
        //               .payrollClickedButton
        //               .value = index,
        //           child: Obx(() => Container(
        //                 padding: const EdgeInsets.all(10),
        //                 margin: const EdgeInsets.all(10),
        //                 decoration: BoxDecoration(
        //                     color: Get.find<ReportsControllerAdmin>()
        //                                 .payrollClickedButton
        //                                 .value ==
        //                             index
        //                         ? Colors.lightBlue
        //                         : null,
        //                     border: Border.all(color: Colors.grey.shade200),
        //                     borderRadius: BorderRadius.circular(10)),
        //                 child: Text(
        //                   payrollTabList[index],
        //                   style: Get.find<ReportsControllerAdmin>()
        //                               .payrollClickedButton
        //                               .value ==
        //                           index
        //                       ? kTextStyleS15W600CWhite
        //                       : kTextStyleS15W600CBlack,
        //                 ),
        //               )),
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
        Obx(() {
          return Get.find<ReportsControllerAdmin>()
                      .payrollClickedButton
                      .value ==
                  0
              ? const PendingPayrollListview()
              : const PayPayment();
        })
      ],
    );
  }
}
