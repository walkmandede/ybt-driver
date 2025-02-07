import 'package:get/get.dart';
import 'package:ybt_driver/src/views/auth/login/login_page.dart';
import 'package:ybt_driver/src/views/home/home_page.dart';
import 'package:ybt_driver/src/views/service/service_page.dart';

import 'route_names.dart';

class RouteUtils {
  final routes = {
    RouteNames.loginPage: (context) {
      return const LoginPage();
    },
    RouteNames.homePage: (context) {
      return const HomePage();
    },
    RouteNames.servicePage: (context) {
      return ServicePage(
        xTesting: Get.arguments ?? false,
      );
    },
  };
}
