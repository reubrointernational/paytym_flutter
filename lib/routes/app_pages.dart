import 'package:paytym/screens/login/login_page.dart';
import 'package:paytym/screens/login/otp_page.dart';
import 'package:paytym/screens/reports/reports_page.dart';
import 'package:paytym/screens/scan_time/scanner_page.dart';
import 'package:paytym/screens/splash/splash_screen.dart';
import 'package:get/get.dart';

import '../screens/bottom_nav/bottom_nav_page.dart';
import '../screens/dashboard/dashboard.dart';
import '../screens/login/forgot_password.dart';
import '../screens/login/reset_password_page.dart';
import 'app_routes.dart';

class AppPages {
  static const initial = Routes.splash;

  static final routes = [
    GetPage(
      name: Routes.splash,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: Routes.login,
      page: () => const LoginPage(),
    ),
    GetPage(
      name: Routes.bottomNav,
      page: () => const BottomNavigationPage(),
    ),
    GetPage(
      name: Routes.resetPassword,
      page: () => const ResetPasswordPage(),
    ),
    GetPage(
      name: Routes.forgotPassword,
      page: () => const ForgetPasswordPage(),
      // binding: DownloadsBinding(),
    ),
    GetPage(
      name: Routes.otp,
      page: () => const OTPPage(),
    ),
    GetPage(
      name: Routes.reports,
      page: () => const ReportsPage(),
    ),
    GetPage(
      name: Routes.dashboard,
      page: () => const DashboardPage(),
    ),
    GetPage(
      name: Routes.scanTime,
      page: () => const ScanTime(),
    ),
  ];
}
