import 'dart:async';

import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:paytym/core/colors/colors.dart';
import 'package:paytym/core/constants/widgets.dart';
import 'package:flutter/material.dart';
import 'package:paytym/screens/employee/dashboard/dashboard_controller.dart';

import '../../core/constants/enums.dart';
import '../../core/constants/strings.dart';
import '../../core/dialog_helper.dart';
import '../login/login_controller.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            const ScannerAppBar(),
            SizedBox(
              height: h * 0.5,
            child: MobileScanner(
    allowDuplicates: false,
              onDetect: (barcode, args) {
                if (barcode.rawValue == null) {
                  debugPrint('Failed to scan Barcode');
                  Timer(Duration(seconds: 2), () {
                    Get.back();
                  });
                  DialogHelper.showToast(desc: 'QR code not matched with your Employer');
                } else {
                  final loginResponseModel = Get.find<LoginController>().loginResponseModel;

                  if (loginResponseModel != null) {
                    final employee = loginResponseModel.employee;
                    final employerId = employee?.employerId;

                    print("Barcode value: ${barcode.rawValue.toString()}");
                    print("Employer Id: ${employerId}");

                    if (employerId != null && barcode.rawValue.toString() == employerId.toString()) {
                      print("Barcode same Scanning Success");

                      final dashboardController = Get.find<DashboardController>();
                      dashboardController.qr = barcode.rawValue;
                      dashboardController.sliderValueChanged = true;
                      dashboardController.sliderController(
                        dashboardController.sliderValue.value == 0 ? 100 : 0,
                      );

                      Timer(Duration(seconds: 3), () {
                        Get.back();
                      });
                    } else {
                      print("Barcode same Scanning Failed");
                      Get.back();
                      DialogHelper.showToast(desc: 'QR code not matched with your Employer');
                    }
                  } else {
                    print("LoginResponseModel is null");
                  }
                }
              },




            ),
            ),
          ],
        ),
      ),
    );
  }
}



// import 'dart:async';
//
// import 'package:get/get.dart';
// import 'package:mobile_scanner/mobile_scanner.dart';
// import 'package:paytym/core/colors/colors.dart';
// import 'package:paytym/core/constants/widgets.dart';
// import 'package:flutter/material.dart';
// import 'package:paytym/screens/employee/dashboard/dashboard_controller.dart';
//
// import '../../core/constants/enums.dart';
// import '../../core/constants/strings.dart';
// import 'scanner_app_bar.dart';
//
// class ScanTime extends StatefulWidget {
//   const ScanTime({Key? key}) : super(key: key);
//
//   @override
//   State<ScanTime> createState() => _ScanTimeState();
// }
//
// class _ScanTimeState extends State<ScanTime> {
//   // final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
//   // QRViewController? controller;
//   // Barcode? result;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: CustomColors.backgroundColor,
//       body: SafeArea(
//         child: Column(
//           children: [
//             const ScannerAppBar(),
//             SizedBox(
//               height: h * 0.5,
//               child: MobileScanner(
//                   allowDuplicates: false,
//                   onDetect: (barcode, args) {
//                     if (barcode.rawValue == null) {
//                       debugPrint('Failed to scan Barcode');
//                     } else {
//                       Get.find<DashboardController>().qr = barcode.rawValue;
//                       Get.find<DashboardController>().sliderValueChanged = true;
//                       Get.find<DashboardController>().sliderController(
//                         Get.find<DashboardController>().sliderValue.value == 0
//                             ? 100
//                             : 0,
//                       );
//                       Timer(Duration(seconds: 4), () {
//                         Get.back();
//                       });
//                     }
//                   }),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
