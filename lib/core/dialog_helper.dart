import 'package:paytym/core/constants/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../network/base_client.dart';
import 'constants/strings.dart';

class DialogHelper {
  //UI for all dialogs, loadings, snackbars and toasts using getx library
  //show dialog

  static void showErrorDialog({
    String title = 'Error',
    String desc = 'Something went wrong',
  }) {
    Get.dialog(
      Scaffold(
        backgroundColor: Colors.white54,
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Lottie.asset('assets/json/404_error.json'),
              const CircleAvatar(
                backgroundColor: Colors.red,
                child: Icon(Icons.close),
              ),
              kSizedBoxH10,
              Text(
                title,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.red),
              ),
              kSizedBoxH10,
              Text(
                desc,
                style: const TextStyle(fontSize: 18),
              ),
              kSizedBoxH10,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: w * 0.4,
                    child: ElevatedButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: const Text(
                        'Cancel',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  kSizedBoxW12,
                  SizedBox(
                    width: w * 0.4,
                    child: ElevatedButton(
                      onPressed: () {
                        if (Get.find<BaseClient>().onError != null) {
                          Get.find<BaseClient>().onError!();
                        }
                        if (Get.isDialogOpen ?? false) Get.back();
                      },
                      child: Text(
                        Get.find<BaseClient>().onError != null ? 'Retry' : 'OK',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  static void showConfirmDialog({
    String title = 'Logout',
    String desc = 'Do you want to Logout?',
    void Function()? onConfirm,
    void Function()? onCancel,
  }) {
    Get.defaultDialog(
        title: title,
        middleText: desc,
        onConfirm: onConfirm,
        onCancel: onCancel,
        textConfirm: 'YES',
        confirmTextColor: Colors.white,
        textCancel: 'NO');
  }

  static void showUploadImageDialog({
    String title = 'Upload Image',
    Widget? content,
  }) {
    Get.defaultDialog(
      title: title.toUpperCase(),
      titleStyle: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: Colors.grey.shade500,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      titlePadding: const EdgeInsets.only(top: 20),
      content: content,
    );
  }

  //show toast

  static void showToast(
      {String desc = 'Something went wrong',
      Color backgroundColor = Colors.blue}) {
    Fluttertoast.showToast(
      msg: desc,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 3,
      backgroundColor: backgroundColor,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  //show snack bar
  static void showSnackBar(String title, String desc) {
    Get.snackbar(title, desc,
        icon: const Icon(Icons.notifications, color: Colors.blue),
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.blue.shade100);
  }

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

  //show bottomsheet
  static void showBottomSheet(Widget child) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: Get.context!,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          topLeft: Radius.circular(20),
        ),
      ),
      builder: (BuildContext context) {
        return child;
      },
    );
  }
}
