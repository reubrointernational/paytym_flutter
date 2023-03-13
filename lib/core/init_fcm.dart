import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> initFcm() async {
  final fcmToken = await FirebaseMessaging.instance.getToken();
  print('fcm token =  ${fcmToken ?? '000'} this is not a value');

  FirebaseMessaging.instance.onTokenRefresh.listen((fcmToken) {
    print('fcm token$fcmToken');
    // token is generated.
  }).onError((err) {
    // Error getting token.
  });

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');

    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
    }
  });
}
