import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:paytym/core/colors/colors.dart';
import 'package:paytym/core/constants/enums.dart';
import 'package:paytym/core/constants/icons.dart';
import 'package:paytym/core/constants/widgets.dart';
import 'package:paytym/screens/employees_screens/reports/reports_controller.dart';
import 'package:paytym/screens/employees_screens/reports/widgets/cached_image.dart';
import 'package:paytym/screens/employees_screens/reports/widgets/months_tab_bar.dart';
import 'package:paytym/screens/employees_screens/reports/widgets/pdf_viewer.dart';
import 'package:paytym/core/extensions/camelcase.dart';
import 'package:paytym/screens/employees_screens/reports/widgets/year_dropdown.dart';

import '../../../core/constants/strings.dart';
import '../../widgets/custom_tab_bar.dart';

class PaySlipTab extends StatelessWidget {
  const PaySlipTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ReportsController reportsController = Get.put(ReportsController());
    reportsController.selectedDropdownYear.value = years.first;

    return Column(
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
              child: CustomMonthsTabBar(
                controller: reportsController.subTabController,
                tabsList: monthsTabList,
                backgroundColor: CustomColors.blueCardColor,
                width: 20,
                swapBlackWhiteText: true,
              ),
            ),
          ],
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.fromLTRB(18, 18, 18, 0),
            child: TabBarView(
              controller: reportsController.subTabController,
              physics: BouncingScrollPhysics(),
              children: [
                payslipContainer(),
                Container(),
                Container(),
                Container(),
                Container(),
                Container(),
                Container(),
                Container(),
                Container(),
                Container(),
                Container(),
                Container(),
              ],
            ),
          ),
        ),
      ],
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
