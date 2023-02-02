import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paytym/screens/dashboard/dashboard.dart';
import 'package:paytym/screens/dashboard/widgets/dashboard_app_bar.dart';
import 'package:paytym/screens/hr_screens/hr_bottom_nav/bottom_nav.dart';
import 'package:paytym/screens/hr_screens/hr_dashboard.dart';

import 'core/init_app.dart';
import 'routes/app_pages.dart';
import 'screens/hr_screens/employees_list.dart';
import 'screens/splash/splash_screen.dart';

void main() async {
  await initApp();
  runApp(const MyApp());
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
