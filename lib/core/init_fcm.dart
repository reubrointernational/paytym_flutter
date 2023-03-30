import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:paytym/core/dialog_helper.dart';
import 'package:paytym/screens/employee/chats/chat_controller.dart';
import 'package:paytym/screens/employee/dashboard/dashboard_controller.dart';
import 'package:paytym/screens/employee/reports/reports_controller.dart';
import 'package:paytym/screens/login/login_controller.dart';

import '../screens/employee/leaves/leaves_controller.dart';

Future<void> initFcm() async {
  final fcmToken = await FirebaseMessaging.instance.getToken();
  print('fcm token =  ${fcmToken ?? '000'} this is not a value');
  LoginController.FCMToken = fcmToken ?? '';

  FirebaseMessaging.instance.onTokenRefresh.listen((fcmToken) {
    LoginController.FCMToken = fcmToken;
    if (Get.find<DashboardController>().initialized) {
      Get.find<DashboardController>().updateFCMToken();
    }
    print('token refreshed');
    // token is generated.
  }).onError((err) {
    // Error getting token.
  });

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    try {
      if (message.notification?.body != null) {
        if (message.notification!.body!.contains('message')) {
          if (Get.find<ChatController>().initialized &&
              Get.find<ChatController>().selectedItemIndex != -1) {
            Get.find<ChatController>().fetchChat(isFromNotification: true);
          }
        }  else {
          DialogHelper.showSnackBar(
              message.notification!.title!, message.notification!.body!);
        }
      }
    } on Exception catch (_) {}
  });

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}
