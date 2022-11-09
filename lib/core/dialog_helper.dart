import 'package:paytym/core/constants/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import 'constants/strings.dart';

class DialogHelper {
  //UI for all dialogs, loadings, snackbars and toasts using getx library

  //show dialog

  static void showErrorDialog(
      {String title = 'Error', String desc = 'Something went wrong'}) {
    Get.dialog(
      Scaffold(
        backgroundColor: Colors.white54,
        body: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset('assets/json/404_error.json'),
            Text(
              title,
              style: const TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 20, color: Colors.red),
            ),
            kSizedBoxH10,
            Text(
              desc,
              style: const TextStyle(fontSize: 18),
            ),
            kSizedBoxH10,
            SizedBox(
              width: w * 0.8,
              child: ElevatedButton(
                onPressed: () {
                  if (Get.isDialogOpen ?? false) Get.back();
                },
                child: const Text(
                  'OK',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
  //show toast

  static void showToast({String desc = 'Something went wrong'}) {
    Fluttertoast.showToast(
        msg: desc,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.blue,
        textColor: Colors.white,
        fontSize: 16.0);
  }
  //show snack bar

  // Get.snackbar("Error", desc,
  //     icon: const Icon(Icons.error, color: Colors.red),
  //     snackPosition: SnackPosition.BOTTOM,
  //     backgroundColor: Colors.blue);

  //show loading

  static void showLoading([String message = '']) {
    Get.dialog(
      Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SpinKitThreeBounce(
              color: Colors.red,
            ),
            Text(message),
          ],
        ),
      ),
      barrierDismissible: false,
    );
  }

  static void hideLoading() {
    if (Get.isDialogOpen ?? false) Get.back();
  }
}
