import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paytym/screens/admin/dashboard/hr_dashboard.dart';
import 'package:paytym/screens/finance/bottom_nav/finance_bottom_controller.dart';
import 'package:paytym/screens/splash/splash_screen.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import 'core/init_app.dart';
import 'routes/app_pages.dart';
import 'screens/admin/bottom_nav/bottom_nav_page.dart';
import 'screens/finance/bottom_nav/finance_bottom_nav.dart';

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
    appRunner: () => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      //initialRoute: AppPages.initial,
      home: const SplashScreen(),
      getPages: AppPages.routes,
    );
  }
}
