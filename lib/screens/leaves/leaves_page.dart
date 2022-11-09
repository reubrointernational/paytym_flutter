import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:paytym/core/colors/colors.dart';
import 'package:paytym/core/constants/widgets.dart';
import 'package:paytym/screens/leaves/leaves_controller.dart';
import 'package:flutter/material.dart';
import '../../core/constants/enums.dart';
import '../../core/constants/strings.dart';
import '../../core/constants/styles.dart';
import 'widgets/leaves_app_bar.dart';

class LeavesPage extends StatelessWidget {
  const LeavesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(LeavesController());
    return Scaffold(
      backgroundColor: CustomColors.backgroundColor,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              const LeavesAppBar(),
              kSizedBoxH15,
              Obx(
                () => CupertinoSlidingSegmentedControl(
                  padding: EdgeInsets.zero,
                  backgroundColor: CustomColors.selectedTabColor,
                  children: const {
                    LeavesTab.all: SizedBox(
                      width: 100,
                      height: 40,
                      child: Center(
                        child: Text(
                          kAllString,
                          style: kTextStyleS14W600LS0p2,
                        ),
                      ),
                    ),
                    LeavesTab.casual: Text(
                      kCasualString,
                      style: kTextStyleS14W600LS0p2,
                    ),
                    LeavesTab.sick: Text(
                      kSickString,
                      style: kTextStyleS14W600LS0p2,
                    ),
                  },
                  groupValue: Get.find<LeavesController>().leavesTab.value,
                  onValueChanged: (value) {
                    Get.find<LeavesController>().leavesTab.value = value!;
                  },
                ),
              ),
              kSizedBoxH10,
              Expanded(
                child: Obx(() => Get.find<LeavesController>().selectLeave()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
