import 'package:flutter/material.dart';
// import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';

import 'core/init_app.dart';
import 'logout_controller.dart';
import 'routes/app_pages.dart';

void main() async {
  await initApp();
  runApp(const MyApp());
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
