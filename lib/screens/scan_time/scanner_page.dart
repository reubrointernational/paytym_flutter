import 'package:paytym/core/constants/widgets.dart';
import 'package:flutter/material.dart';

import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../core/constants/strings.dart';
import 'scanner_app_bar.dart';

class ScanTime extends StatefulWidget {
  const ScanTime({Key? key}) : super(key: key);

  @override
  State<ScanTime> createState() => _ScanTimeState();
}

class _ScanTimeState extends State<ScanTime> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  Barcode? result;
  Color? primaryColor = const Color.fromRGBO(75, 103, 176, 1);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const ScannerAppBar(),
            Expanded(
              child: QRView(
                key: qrKey,
                onQRViewCreated: onQRViewCreated,
              ),
            ),
            SizedBox(
              height: h * 0.13,
              child: Center(
                child: (result != null)
                    ? Text(
                        "Data: ${result!.code}",
                      )
                    : const Text(
                        "Scan Code",
                      ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "Submit",
                  style: TextStyle(
                    color: Colors.white,
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

  void onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((event) {
      setState(() {
        result = event;
      });
    });
  }
}
