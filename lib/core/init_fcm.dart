import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:paytym/screens/employee/dashboard/dashboard_controller.dart';
import 'package:paytym/screens/login/login_controller.dart';


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
    print("FCM foreground message");
    print('id = ${message.messageId}');
    print('data = ${message.data.toString()}');
    print('notification body = ${message.notification?.body}');
    print('notification title = ${message.notification?.title}');
  });

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("FCM background message");
  print('id = ${message.messageId}');
  print('data = ${message.data.toString()}');
  print('notification body = ${message.notification?.body}');
  print('notification title = ${message.notification?.title}');
}
