import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:paytym/core/colors/colors.dart';
import 'package:paytym/core/constants/widgets.dart';
import 'package:flutter/material.dart';
import 'package:paytym/screens/dashboard/dashboard_controller.dart';

import '../../core/constants/strings.dart';
import 'scanner_app_bar.dart';

class ScanTime extends StatefulWidget {
  const ScanTime({Key? key}) : super(key: key);

  @override
  State<ScanTime> createState() => _ScanTimeState();
}

class _ScanTimeState extends State<ScanTime> {
  // final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  // QRViewController? controller;
  // Barcode? result;
  String? code;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            const ScannerAppBar(),
            Expanded(
              child: MobileScanner(
                  allowDuplicates: false,
                  onDetect: (barcode, args) {
                    if (barcode.rawValue == null) {
                      debugPrint('Failed to scan Barcode');
                    } else {
                      code = barcode.rawValue!;
                      debugPrint('success to scan Barcode $code');
                      Get.find<DashboardController>().updateCheckInOut(code);
                      setState(() {
                        code;
                      });
                    }
                  }),
            ),
            SizedBox(
              height: h * 0.13,
              child: Center(
                child: (code != null)
                    ? Text(
                        "$kDataString $code",
                      )
                    : const Text(
                        kScanCodeString,
                      ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: CustomColors.blueTextColor,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  kSubmitString,
                  style: TextStyle(
                    color: CustomColors.whiteTextColor,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
            kSizedBoxH40,
          ],
        ),
      ),
    );
  }

  // void onQRViewCreated(QRViewController controller) {
  //   this.controller = controller;
  //   controller.scannedDataStream.listen((event) {
  //     setState(() {
  //       result = event;
  //     });
  //   });
  // }
}
