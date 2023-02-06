import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:paytym/core/colors/colors.dart';
import 'package:paytym/core/constants/enums.dart';
import 'package:paytym/core/constants/icons.dart';
import 'package:paytym/core/constants/widgets.dart';
import 'package:paytym/screens/employee/reports/reports_controller.dart';
import 'package:paytym/screens/employee/reports/widgets/cached_image.dart';
import 'package:paytym/screens/employee/reports/widgets/pdf_viewer.dart';
import 'package:paytym/core/extensions/camelcase.dart';

import '../../../core/constants/strings.dart';
import '../../widgets/custom_tab_bar.dart';

import 'widgets/year_dropdown.dart';

class PaySlipTab extends StatelessWidget {
  const PaySlipTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ReportsController reportsController = Get.put(ReportsController());
    reportsController.selectedDropdownYear.value = years.first;
    return DefaultTabController(
      length: monthsTabList.length,
      child: Column(
        children: [
          Row(
            children: [
              Obx(() {
                return CustomDropdownYearButton(
                  lists: years,
                  value: reportsController.selectedDropdownYear.value,
                  onChanged: (value) {
                    reportsController.selectedDropdownYear.value = value!;
                  },
                  hint: 'years',
                );
              }),
              Expanded(
                child: CustomTabBar(
                  tabsList: monthsTabList,
                  color: CustomColors.blueCardColor,
                  height: 36,
                  width: 20,
                ),
              ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(18, 18, 18, 0),
              child: TabBarView(
                physics: const BouncingScrollPhysics(),
                children: [
                  payslipContainer(),
                  payslipContainer(),
                  payslipContainer(),
                  payslipContainer(),
                  payslipContainer(),
                  payslipContainer(),
                  payslipContainer(),
                  payslipContainer(),
                  payslipContainer(),
                  payslipContainer(),
                  payslipContainer(),
                  payslipContainer(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget payslipContainer() {
    String? url;
    return Column(
      children: [
        Expanded(
          child: Obx(() {
            url = Get.find<ReportsController>()
                .payslipResponseModel
                .value
                .payroll
                ?.paySlip;
            if (url?.getType() == 'pdf') {
              return PdfViewer(
                url: url!,
              );
            } else if (url?.getType() == 'png') {
              return CachedImage(
                url: url!,
              );
            } else {
              return const SizedBox();
            }
          }),
        ),
        kSizedBoxH8,
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () =>
                    Get.find<ReportsController>().sharePdf(url, url?.getType()),
                icon: CircleAvatar(
                  backgroundColor: CustomColors.fabColor,
                  child: Obx(
                    () => Get.find<ReportsController>()
                                .isSharingOrDownloading
                                .value ==
                            SharingOrDownloading.sharing
                        ? const SpinKitPulse(
                            color: Colors.white,
                          )
                        : SvgPicture.asset(
                            IconPath.shareIconSvg,
                          ),
                  ),
                ),
              ),
              IconButton(
                onPressed: () => Get.find<ReportsController>().downloadPdf(url),
                icon: CircleAvatar(
                  backgroundColor: CustomColors.fabColor,
                  child: Obx(
                    () => Get.find<ReportsController>()
                                .isSharingOrDownloading
                                .value ==
                            SharingOrDownloading.downloading
                        ? Lottie.asset(IconPath.downloadingJson)
                        : SvgPicture.asset(
                            IconPath.downloadIconSvg,
                          ),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
