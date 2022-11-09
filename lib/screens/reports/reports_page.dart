import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:paytym/core/constants/icons.dart';
import 'package:paytym/core/constants/widgets.dart';
import 'package:paytym/screens/calendar/widgets/custom_svg.dart';
import 'package:paytym/screens/login/login_controller.dart';
import 'package:paytym/screens/reports/attendance.dart';
import 'package:paytym/screens/reports/deduction.dart';
import 'package:paytym/screens/reports/payslip.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:paytym/screens/reports/reports_controller.dart';

import '../../core/colors/colors.dart';
import '../../core/constants/enums.dart';
import '../../core/constants/strings.dart';
import '../../core/constants/styles.dart';

class ReportsPage extends StatefulWidget {
  const ReportsPage({Key? key}) : super(key: key);

  @override
  State<ReportsPage> createState() => _ReportsPageState();
}

class _ReportsPageState extends State<ReportsPage> {
  String? selectedPayment = "";

  Reports _reportTab = Reports.payslip;
  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => ReportsController());

    return Scaffold(
      backgroundColor: CustomColors.backgroundColor,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 6, 9, 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  reportsAppBar(),
                  kSizedBoxH10,
                  Row(
                    children: [
                      CachedNetworkImage(
                        imageUrl: Get.find<LoginController>()
                                .loginResponseModel
                                ?.employee
                                ?.image ??
                            '',
                        imageBuilder: (context, imageProvider) => CircleAvatar(
                          backgroundColor:
                              CustomColors.circleAvatarBackgroundColor,
                          radius: 26,
                          backgroundImage: imageProvider,
                        ),
                        placeholder: (context, url) =>
                            const SpinKitDoubleBounce(
                          color: CustomColors.whiteCircleAvatarBackgroundColor,
                        ),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                      kSizedBoxH10,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${Get.find<LoginController>().loginResponseModel?.employee?.firstName ?? ''} ${Get.find<LoginController>().loginResponseModel?.employee?.lastName ?? ''}',
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: CustomColors.blueTextColor,
                            ),
                          ),
                          kSizedBoxH4,
                          const Text(
                            "#4578340",
                            style: kTextStyleS13W500Cgrey,
                          ),
                          kSizedBoxH4,
                          const Text(
                            "$kNetPayString \$45000",
                            style: kTextStyleS13W500Cgrey,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                color: CustomColors.calendarPageBackgroundColor,
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Column(
                  children: [
                    CupertinoNavigationBar(
                      backgroundColor: Colors.transparent,
                      middle: CupertinoSlidingSegmentedControl(
                        padding: EdgeInsets.zero,
                        backgroundColor: CustomColors.blueTextColor,
                        thumbColor: CustomColors.whiteCardColor,
                        children: {
                          Reports.payslip: SizedBox(
                            width: 100,
                            height: 40,
                            child: Center(
                              child: Text(
                                kPaySlipString,
                                style: kTextStyleS14W600Cgrey300LS0p2,
                              ),
                            ),
                          ),
                          Reports.deduction: Text(
                            kDeductionString,
                            style: kTextStyleS14W600Cgrey300LS0p2,
                          ),
                          Reports.attendance: Text(
                            kAttendanceString,
                            style: kTextStyleS14W600Cgrey300LS0p2,
                          ),
                        },
                        groupValue: _reportTab,
                        onValueChanged: (value) {
                          setState(() {
                            _reportTab = value!;
                          });
                        },
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(18, 18, 18, 0),
                        child: selectedSegmentType(_reportTab),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget selectedSegmentType(segment) {
    if (segment == Reports.payslip) {
      return const PaySlipPage();
    } else if (segment == Reports.deduction) {
      return const DeductionPage();
    } else if (segment == Reports.attendance) {
      return const AttendancePage();
    }
    return Container();
  }

  Widget reportsAppBar() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: const [
              CustomSVG(IconPath.menuSvg, size: 20),
              kSizedBoxW15,
              Text(
                kReportsString,
                style: kTextStyleS18W600,
              ),
            ],
          ),
          PopupMenuButton<Payments>(
            color: CustomColors.blueTextColor,
            onSelected: (Payments value) {
              if (value == Payments.payment) {
                paymentBottomSheet();
              } else if (value == Payments.advance) {
                advanceBottomSheet();
              } else if (value == Payments.logout) {
                Get.find<ReportsController>().logout();
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<Payments>>[
              const PopupMenuItem(
                value: Payments.payment,
                child: Text(
                  kRequestPaymentString,
                  style: TextStyle(
                    color: CustomColors.whiteTextColor,
                  ),
                ),
              ),
              const PopupMenuItem(
                value: Payments.advance,
                child: Text(
                  kRequestAdvanceString,
                  style: kTextStyleCwhite,
                ),
              ),
              const PopupMenuItem(
                value: Payments.logout,
                child: Text(
                  kLogoutString,
                  style: kTextStyleCwhite,
                ),
              ),
            ],
          ),
        ],
      );

  void advanceBottomSheet() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          topLeft: Radius.circular(20),
        ),
      ),
      builder: (BuildContext context) {
        return Container(
          margin:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          padding: const EdgeInsets.all(28),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(20),
              topLeft: Radius.circular(20),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                kRequestAdvanceString,
                style: kTextStyleS18W600.copyWith(
                    color: CustomColors.blueTextColor),
              ),
              kSizedBoxH10,
              Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 10),
                      hintText: kNameString,
                      hintStyle: const TextStyle(
                        color: CustomColors.greyTextColor,
                        fontSize: 14,
                      ),
                      enabledBorder: kInputBorderBlueW1p2,
                      focusedBorder: kInputBorderBlueW1p2,
                    ),
                  ),
                  kSizedBoxH10,
                  TextFormField(
                    decoration: InputDecoration(
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 10),
                      hintText: kEmployeeIDString,
                      hintStyle: const TextStyle(
                        color: CustomColors.greyTextColor,
                        fontSize: 14,
                      ),
                      enabledBorder: kInputBorderBlueW1p2,
                      focusedBorder: kInputBorderBlueW1p2,
                    ),
                  ),
                  kSizedBoxH10,
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 10),
                      hintText: kAmountString,
                      hintStyle: const TextStyle(
                        color: CustomColors.greyTextColor,
                        fontSize: 14,
                      ),
                      enabledBorder: kInputBorderBlueW1p2,
                      focusedBorder: kInputBorderBlueW1p2,
                    ),
                  ),
                ],
              ),
              kSizedBoxH10,
              SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: CustomColors.blueTextColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    kRequestAdvanceString,
                    style: TextStyle(
                      color: CustomColors.whiteTextColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void paymentBottomSheet() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          topLeft: Radius.circular(20),
        ),
      ),
      builder: (BuildContext context) {
        return Container(
          margin:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          padding: const EdgeInsets.all(28),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(20),
              topLeft: Radius.circular(20),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                kRequestPaymentString,
                style: kTextStyleS18W600.copyWith(
                    color: CustomColors.blueTextColor),
              ),
              kSizedBoxH10,
              Column(
                children: [
                  TextField(
                    decoration: InputDecoration(
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 10),
                      hintText: kNameString,
                      hintStyle: const TextStyle(
                        color: CustomColors.greyTextColor,
                        fontSize: 14,
                      ),
                      enabledBorder: kInputBorderBlueW1p2,
                      focusedBorder: kInputBorderBlueW1p2,
                    ),
                  ),
                  kSizedBoxH10,
                  TextField(
                    decoration: InputDecoration(
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 10),
                      hintText: kEmployeeIDString,
                      hintStyle: const TextStyle(
                        color: CustomColors.greyTextColor,
                        fontSize: 14,
                      ),
                      enabledBorder: kInputBorderBlueW1p2,
                      focusedBorder: kInputBorderBlueW1p2,
                    ),
                  ),
                  kSizedBoxH10,
                  TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 10),
                      hintText: kAmountString,
                      hintStyle: const TextStyle(
                        color: CustomColors.greyTextColor,
                        fontSize: 14,
                      ),
                      enabledBorder: kInputBorderBlueW1p2,
                      focusedBorder: kInputBorderBlueW1p2,
                    ),
                  ),
                ],
              ),
              kSizedBoxH10,
              SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: CustomColors.blueTextColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    kRequestPaymentString,
                    style: TextStyle(
                      color: CustomColors.whiteTextColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
