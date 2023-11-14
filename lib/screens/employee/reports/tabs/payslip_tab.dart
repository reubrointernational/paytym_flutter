import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:open_file/open_file.dart';
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

bool payslipPresent = false;

class PayslipTab extends StatelessWidget {
  const PayslipTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ReportsController reportsController = Get.put(ReportsController());
    // WidgetsBinding.instance
    //     .addPostFrameCallback((_) => reportsController.fetchPayslip(""));
    WidgetsBinding.instance
        .addPostFrameCallback((_) => reportsController.fetchPayslipCopy());
    Get.put(ReportsControllerAdmin());

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(() {
              // Payslip Year Drop down
              return CustomDropdownYearButton(
                lists: years,
                value: reportsController.selectedDropdownYear.value,
                onChanged: (value) {
                  reportsController.selectedDropdownYear.value = value!;
                  reportsController.fetchPayslipCopy();
                },
                hint: '2023 ',
              );
            }),
            Obx(() {
              // Paylip Month Drop down
              return CustomDropdownYearButton(
                lists: monthsList,
                value: reportsController.selectedDropdownMonth.value,
                onChanged: (value) {
                  reportsController.selectedDropdownMonth.value = value!;
                  reportsController.fetchPayslipCopy();
                },
                hint: 'Jan ',
              );
            }),
            Obx(() {
              // Paylip Date Drop down
              if (reportsController.selectedDropdownDay.value == null ||
                  reportsController.dateList.isEmpty) {
                print("Payslip Date dropdown NULL selected");
                return const SizedBox(
                  width: 0,
                );
              } else {
                print("Payslip Date dropdown selected");
                print(reportsController.selectedDropdownDay.value);
              }
              return CustomDropdownYearButton(
                lists: reportsController.dateList,
                value: reportsController.dateList.firstWhere((element) =>
                    element == reportsController.selectedDropdownDay.value),
                onChanged: (value) {
                  try {
                    print("Payslip Date dropdown selected value: $value");
                    reportsController.selectedDropdownDay.value = value!;
                    reportsController.fetchPayslipCopy();

                    print(
                        "reportsController.selectedDropdownDay.value:${reportsController.selectedDropdownDay.value}");
                  } catch (e) {
                    print("Error: $e");

                    // Handle the range error here, such as showing an error message to the user or taking appropriate action.
                  }
                },
                hint: '08-02-2023',
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
    print("PayslipContainer Called");
    String? url;
    // String? url =
    //     "https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf";
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
                url =
                    '$kStorageUrlForPDF${Get.find<ReportsController>().payslipResponseModel.value.payroll?[Get.find<ReportsController>().dateList.indexOf(Get.find<ReportsController>().selectedDropdownDay.value!)].paySlip}';
                print(
                    "Payslip Date Selection Index:${Get.find<ReportsController>().dateList.indexOf(Get.find<ReportsController>().selectedDropdownDay.value)}");

                if (url?.getType() == 'pdf') {
                  //for testing given an outside file name
                  return PdfViewer(
                    // url:
                    //     "https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf"!,
                    url: url!,
                  );
                } else if (url?.getType() == 'png') {
                  return CachedImage(
                    url: url!,
                  );
                } else {
                  return const SizedBox();
                }
              } else {
                // url =
                //     "https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf";
                // return const SizedBox();
                return const Text("No Payslip Generated during this month");
              }
            } on Exception {
              return const SizedBox();
            }
          }),
        ),
        kSizedBoxH8,
        // Share button
        Obx(() {
          try {
            if (Get.find<ReportsController>()
                    .payslipResponseModel
                    .value
                    .payroll
                    ?.isNotEmpty ??
                false) {
              // Share and Download Button Row , It display only a payslip is present based on the year+month selection
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () => Get.find<ReportsControllerAdmin>()
                          .sharePdf(url, url?.getType()),
                      // Get.find<ReportsController>().sharePdf(url, url?.getType()),
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
                        if (Get.find<ReportsController>()
                                .selectedDropdownDay
                                .value ==
                            null) {
                          DialogHelper.showToast(desc: 'No Payslip found');
                        } else {
                          // files?[index].isDownloading = true;
                          Get.find<ReportsController>()
                              .fileListResponseModel
                              .refresh();
                          Get.find<ReportsControllerAdmin>()
                              .downloadFile("hr_rec", url, ((progress, total) {
                            if (progress == total) {
                              // files?[index].isDownloading = false;
                              Get.find<ReportsController>()
                                  .fileListResponseModel
                                  .refresh();
                              DialogHelper.showToast(
                                  desc: 'Download completed');
                            }
                          }));
                        }
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
              );
            } else {
              return const SizedBox();
            }
          } on Exception {
            return const SizedBox();
          }
        }),
        // Get.find<ReportsController>()
        //         .payslipResponseModel
        //         .value
        //         .payroll!
        //         .isNotEmpty
        //     ? Container(
        //         padding: const EdgeInsets.symmetric(horizontal: 10),
        //         child: Row(
        //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //           children: [
        //             IconButton(
        //               onPressed: () => Get.find<ReportsController>()
        //                   .sharePdf(url, url?.getType()),
        //               // Get.find<ReportsController>().sharePdf(url, url?.getType()),
        //               icon: CircleAvatar(
        //                 backgroundColor: CustomColors.fabColor,
        //                 child: Obx(
        //                   () => Get.find<ReportsController>()
        //                               .isSharingOrDownloading
        //                               .value ==
        //                           SharingOrDownloading.sharing
        //                       ? const SpinKitPulse(
        //                           color: Colors.white,
        //                         )
        //                       : SvgPicture.asset(
        //                           IconPath.shareIconSvg,
        //                         ),
        //                 ),
        //               ),
        //             ),
        //             IconButton(
        //               onPressed: () {
        //                 if (Get.find<ReportsController>()
        //                         .selectedDropdownDay
        //                         .value ==
        //                     null) {
        //                   DialogHelper.showToast(desc: 'No Payslip found');
        //                 } else {
        //                   // files?[index].isDownloading = true;
        //                   Get.find<ReportsController>()
        //                       .fileListResponseModel
        //                       .refresh();
        //                   Get.find<ReportsControllerAdmin>().downloadFile(
        //                       "hr_rec",
        //                       'https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf',
        //                       ((progress, total) {
        //                     if (progress == total) {
        //                       // files?[index].isDownloading = false;
        //                       Get.find<ReportsController>()
        //                           .fileListResponseModel
        //                           .refresh();
        //                       DialogHelper.showToast(
        //                           desc: 'Download completed');
        //                     }
        //                   }));
        //                 }
        //                 // original code
        //                 // Get.find<ReportsController>().downloadPdf(url);
        //               },
        //               icon: CircleAvatar(
        //                 backgroundColor: CustomColors.fabColor,
        //                 child: Obx(
        //                   () => Get.find<ReportsController>()
        //                               .isSharingOrDownloading
        //                               .value ==
        //                           SharingOrDownloading.downloading
        //                       ? Lottie.asset(IconPath.downloadingJson)
        //                       : SvgPicture.asset(
        //                           IconPath.downloadIconSvg,
        //                         ),
        //                 ),
        //               ),
        //             )
        //           ],
        //         ),
        //       )
        //     : Text(""),
      ],
    );
  }
}
