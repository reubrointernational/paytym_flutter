import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import 'core/init_app.dart';
import 'logout_controller.dart';
import 'routes/app_pages.dart';

void main() async {
  await initApp();
  await SentryFlutter.init(
    (options) {
      options.dsn =
          'https://9e678097d2004e8f807d2db325f37080@o4504614729023488.ingest.sentry.io/4504614734135296';
      // Set tracesSampleRate to 1.0 to capture 100% of transactions for performance monitoring.
      // We recommend adjusting this value in production.
      options.tracesSampleRate = 1.0;
    },
    appRunner: () => runApp(DevicePreview(
        enabled: !kReleaseMode, builder: (context) => const MyApp())),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LogoutController logoutController = Get.put(LogoutController());
    return Listener(
      onPointerDown: ((event) => logoutController.restartTimer()),
      child: GetMaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ).copyWith(
          pageTransitionsTheme: const PageTransitionsTheme(
              builders: <TargetPlatform, PageTransitionsBuilder>{
                TargetPlatform.android: ZoomPageTransitionsBuilder(),
              }),
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: AppPages.initial,
        getPages: AppPages.routes,
      ),
    );
  }
}
