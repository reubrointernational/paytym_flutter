import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:paytym/core/colors/colors.dart';
import 'package:paytym/core/constants/icons.dart';
import 'package:paytym/core/constants/widgets.dart';
import 'package:paytym/screens/reports/reports_controller.dart';

class PaySlipPage extends StatefulWidget {
  const PaySlipPage({Key? key}) : super(key: key);

  @override
  State<PaySlipPage> createState() => _PaySlipPageState();
}

class _PaySlipPageState extends State<PaySlipPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: const PDF(
            enableSwipe: true,
            swipeHorizontal: false,
            autoSpacing: false,
            pageFling: false,
            preventLinkNavigation: true,
          ).cachedFromUrl(
            'http://africau.edu/images/default/sample.pdf',
            placeholder: (progress) => const Center(
              child: SpinKitCubeGrid(
                color: Colors.blue,
                size: 50.0,
              ),
            ),
            errorWidget: (error) => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(
                  Icons.error_outline_sharp,
                  color: Colors.red,
                  size: 50,
                ),
                Text('error.toString()'),
              ],
            ),
          ),
        ),
        kSizedBoxH8,
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () => Get.find<ReportsController>().sharePdf(
                    'https://www.wlwv.k12.or.us/cms/lib8/OR01001812/Centricity/Domain/1309/Kate%20Chopin%20Story%20Texts.pdf'),
                icon: CircleAvatar(
                  backgroundColor: CustomColors.fabColor,
                  child: Obx(
                    () => Get.find<ReportsController>().isSharing.isFalse
                        ? SvgPicture.asset(
                            IconPath.shareIconSvg,
                          )
                        : const SpinKitPulse(
                            color: Colors.white,
                          ),
                  ),
                ),
              ),
              IconButton(
                onPressed: () => Get.find<ReportsController>().downloadPdf(
                    'https://www.wlwv.k12.or.us/cms/lib8/OR01001812/Centricity/Domain/1309/Kate%20Chopin%20Story%20Texts.pdf'),
                icon: CircleAvatar(
                  backgroundColor: CustomColors.fabColor,
                  child: Obx(
                    () => Get.find<ReportsController>().isDownloading.isFalse
                        ? SvgPicture.asset(
                            IconPath.downloadIconSvg,
                          )
                        : Lottie.asset(IconPath.downloadingJson),
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
