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
import '../../../../core/constants/strings.dart';
import '../../../../core/dialog_helper.dart';
import '../../../../network/end_points.dart';
import '../../../admin/reports/reports_controller.dart';
import '../widgets/year_dropdown.dart';

class PayslipTab extends StatelessWidget {
  const PayslipTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ReportsController reportsController = Get.put(ReportsController());
    WidgetsBinding.instance
        .addPostFrameCallback((_) => reportsController.fetchPayslip());

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Obx(() {
              return CustomDropdownYearButton(
                lists: years,
                value: reportsController.selectedDropdownYear.value,
                onChanged: (value) {
                  reportsController.selectedDropdownYear.value = value!;
                  reportsController.fetchPayslip();
                },
                hint: '2023 ',
              );
            }),
            Obx(() {
              return CustomDropdownYearButton(
                lists: monthsList,
                value: reportsController.selectedDropdownMonth.value,
                onChanged: (value) {
                  reportsController.selectedDropdownMonth.value = value!;
                  reportsController.fetchPayslip();
                },
                hint: 'Jan ',
              );
            }),
            Obx(() {
              if (reportsController.selectedDropdownDay.value == null ||
                  reportsController.dateList.isEmpty) {
                return const SizedBox(
                  width: 0,
                );
              }
              return CustomDropdownYearButton(
                lists: reportsController.dateList,
                value: reportsController.dateList.firstWhere((element) =>
                    element == reportsController.selectedDropdownDay.value),
                onChanged: (value) {
                  reportsController.selectedDropdownDay.value = value!;
                },
                hint: '08-02-2023 ',
              );
            }),
          ],
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(18, 18, 18, 0),
            child: payslipContainer(),
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
            try {
              if (Get.find<ReportsController>()
                      .payslipResponseModel
                      .value
                      .payroll
                      ?.isNotEmpty ??
                  false) {
                // kStorageUrl = 'https://paytym.net/storage/';
                url =
                    '$kStorageUrl${Get.find<ReportsController>().payslipResponseModel.value.payroll?[Get.find<ReportsController>().dateList.indexOf(Get.find<ReportsController>().selectedDropdownDay.value!)].paySlip}';

                print(Get.find<ReportsController>()
                    .payslipResponseModel
                    .value
                    .payroll
                    .toString());
                print("pdf url:$url");
              } else {
                print("no payslip 1");
                return const SizedBox();
              }
            } on Exception {
              return const SizedBox();
            }

            if (url?.getType() == 'pdf') {
              print(" payslip pdf url:${url.toString()}");
              return PdfViewer(
                url:
                    "https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf"!,
                // url: url!,
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
        // Share button
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
                onPressed: () {
                  // files?[index].isDownloading = true;
                  Get.find<ReportsController>().fileListResponseModel.refresh();
                  Get.find<ReportsControllerAdmin>().downloadFile("hr_rec",
                      'https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf',
                      ((progress, total) {
                    if (progress == total) {
                      // files?[index].isDownloading = false;
                      Get.find<ReportsController>()
                          .fileListResponseModel
                          .refresh();
                      DialogHelper.showToast(desc: 'Download completed');
                    }
                  }));
                  // original code
                  // Get.find<ReportsController>().downloadPdf(url);
                },
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
