import 'package:paytym/screens/login/login_page.dart';
import 'package:paytym/screens/login/otp_page.dart';
import 'package:paytym/screens/reports/reports_page.dart';
import 'package:paytym/screens/splash/splash_screen.dart';
import 'package:get/get.dart';

import '../screens/bottom_nav/bottom_nav_page.dart';
import '../screens/dashboard/dashboard.dart';
import '../screens/login/forgot_password.dart';
import '../screens/login/reset_password_page.dart';
import 'app_routes.dart';

class AppPages {
  static const initial = Routes.login;
  static final routes = [
    GetPage(
      name: Routes.splash,
      page: () => const SplashScreen(),
      // binding: DownloadsBinding(),
    ),
    GetPage(
      name: Routes.login,
      page: () => const LoginPage(),
    ),
    GetPage(
      name: Routes.bottomNav,
      page: () => const BottomNavigationPage(),
      // binding: DownloadsBinding(),
    ),
    GetPage(
      name: Routes.resetPassword,
      page: () => const ResetPasswordPage(),
      // binding: DownloadsBinding(),
    ),
    GetPage(
      name: Routes.forgotPassword,
      page: () => const ForgetPasswordPage(),
      // binding: DownloadsBinding(),
    ),
    GetPage(
      name: Routes.otp,
      page: () => const OTPPage(),
      // binding: DownloadsBinding(),
    ),
    GetPage(
      name: Routes.reports,
      page: () => const ReportsPage(),
    ),
    GetPage(
      name: Routes.dashboard,
      page: () => const DashboardPage(),
    ),
  ];
}
