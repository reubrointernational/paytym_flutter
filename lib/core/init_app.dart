import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import '../firebase_options.dart';
import 'init_fcm.dart';

Future<void> initApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  // if (Platform.isAndroid) {
  //   binding.renderView.automaticSystemUiAdjustment = false;
  // }

  // await SystemChrome.setPreferredOrientations(
  //     [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  final data = MediaQueryData.fromWindow(WidgetsBinding.instance.window);
  if (data.size.shortestSide > 600) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeRight,
    ]);
  } else {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await FlutterDownloader.initialize(
      debug:
          true, // optional: set to false to disable printing logs to console (default: true) //todo set to false
      ignoreSsl: true //todo delete if server is https
      //todo delete usescleartext from manifest file

      );

  initFcm();
}
