import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paytym/core/colors/colors.dart';
import 'package:paytym/core/constants/widgets.dart';
import '../../../core/constants/strings.dart';
import '../../../dummy_status.dart';
import 'employees_list.dart';
import 'widgets/app_bar.dart';
import 'widgets/custom_cards.dart';
import 'widgets/hr_check_in_out.dart';

class HRDashboard extends StatelessWidget {
  const HRDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.lightBlueColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(18, 0, 18, 0),
              child: HrAppBar(),
            ),
            Expanded(
              child: ListView(children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Welcome',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: CustomColors.whiteTextColor,
                        ),
                      ),
                      kSizedBoxH4,
                      Text(
                        'John Doe',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: CustomColors.whiteTextColor,
                        ),
                      ),
                    ],
                  ),
                ),
                kSizedBoxH4,
                Container(
                  height: MediaQuery.of(context).size.height,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  decoration: BoxDecoration(
                    color: CustomColors.whiteCardColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const HRCheckInOutCard(),
                      CustomCardDetails(
                          details: Status.isHrSession ? hrDetails : financeDetails),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () => Get.to(HrEmployeesList()),
                            child: const Text(
                              'Employees Details',
                              style: TextStyle(
                                fontSize: 16,
                                color: CustomColors.blackTextColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          kSizedBoxH10,
                          CustomCardDetails(details: totalEmployeesDetails),
                        ],
                      ),
                    ],
                  ),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
