import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:paytym/core/constants/icons.dart';
import 'package:paytym/core/constants/widgets.dart';

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
          ).fromAsset(IconPath.salarySlipPdf),
        ),
        kSizedBoxH8,
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Stack(
                children: [
                  SvgPicture.asset(
                    IconPath.circleBackgroundSvg,
                  ),
                  Positioned(
                    top: 8,
                    left: 8,
                    child: SvgPicture.asset(
                      IconPath.shareIconSvg,
                    ),
                  ),
                ],
              ),
              Stack(
                children: [
                  SvgPicture.asset(
                    IconPath.circleBackgroundSvg,
                  ),
                  Positioned(
                    top: 8,
                    left: 8,
                    child: SvgPicture.asset(
                      IconPath.downloadIconSvg,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
