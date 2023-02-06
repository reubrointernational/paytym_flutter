import 'package:flutter/material.dart';
import 'package:paytym/core/colors/colors.dart';
import 'package:paytym/core/constants/widgets.dart';
import '../../../core/constants/strings.dart';
import 'widgets/app_bar.dart';
import 'widgets/custom_cards.dart';
import 'widgets/check_in_out_card_admin.dart';

class DashboardAdmin extends StatelessWidget {
  const DashboardAdmin({super.key});
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
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
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
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 20),
                        decoration: BoxDecoration(
                          color: CustomColors.whiteCardColor,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: ListView(
                          physics: const BouncingScrollPhysics(),
                          children: [
                            const CheckInOutCardAdmin(),
                            kSizedBoxH10,
                            CustomCardDetails(details: totalEmployeesDetails),
                          ],
                        ),
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
