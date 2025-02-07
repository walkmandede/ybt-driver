import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:ybt_driver/config/route/route_names.dart';
import 'package:ybt_driver/injector.dart';
import 'config/constants/app_theme.dart';
import 'config/route/route_utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MyInjector().initDependencies();
  await Future.delayed(const Duration(seconds: 1));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context)
          .copyWith(textScaler: const TextScaler.linear(1)),
      child: GetMaterialApp(
        routes: RouteUtils().routes,
        initialRoute: RouteNames.loginPage,
        debugShowCheckedModeBanner: false,
        title: 'Yangon Bus Tracking System - Driver App',
        locale: const Locale('en', 'EN'),
        theme: AppTheme.darkTheme, // Use the light theme
        darkTheme: AppTheme.darkTheme, // Use the dark theme
        themeMode: ThemeMode.system,
      ),
    );
  }
}
