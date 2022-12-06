import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> initFcm() async {
  final fcmToken = await FirebaseMessaging.instance.getToken();
  print('fcm token00  ${fcmToken ?? '000'}000000');

  FirebaseMessaging.instance.onTokenRefresh.listen((fcmToken) {
    print('fcm token$fcmToken');
    // token is generated.
  }).onError((err) {
    // Error getting token.
  });
}
