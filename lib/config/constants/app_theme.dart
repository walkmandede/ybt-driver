import 'package:flutter/material.dart';
import 'package:ybt_driver/config/constants/app_constants.dart';

class AppTheme {
  static Color primary = Colors.blue;
  // static Color primary = const primary;

  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    fontFamily: "Poppins",
    primaryColor: primary, // Updated to a soft blue from the image
    scaffoldBackgroundColor:
        const Color(0xFFF7F9FF), // Light grayish background
    colorScheme: ColorScheme.light(
      primary: primary, // Soft blue as primary color
      secondary:
          Color(0xFF4F8C94), // Complementary soft greenish-blue secondary color
      background: Color(0xFFF7F9FF), // Screen background
      surface: Color(0xFFFFFFFF), // White card background
      error: Colors.red, // Error color remains red
      onPrimary: Colors.white, // Text on primary
      onSecondary: Colors.white, // Text on secondary
      onBackground: Color(0xFF333333), // Text on background
      onSurface: Color(0xFF333333), // Text on surface
      onError: Colors.white, // Text on error
    ),
    textTheme: TextTheme(
      displayLarge: AppConstants.appTextStyle1.copyWith(
          fontSize: 32.0,
          fontWeight: FontWeight.bold,
          color: const Color(0xFF333333)),
      bodyLarge: AppConstants.appTextStyle1
          .copyWith(fontSize: 16.0, color: Color(0xFF333333)),
      bodyMedium: AppConstants.appTextStyle1
          .copyWith(fontSize: 14.0, color: Color(0xFF555555)),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: primary,
      foregroundColor: Colors.white,
      elevation: 4.0,
      iconTheme: IconThemeData(color: Colors.white),
      actionsIconTheme: IconThemeData(color: Colors.white),
      toolbarTextStyle:
          AppConstants.appTextStyle1.copyWith(color: Colors.white),
      titleTextStyle: AppConstants.appTextStyle1.copyWith(color: Colors.white),
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: primary,
      textTheme: ButtonTextTheme.primary,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: primary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xFF4F8C94)),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: primary),
      ),
      hintStyle: AppConstants.appTextStyle1.copyWith(color: Colors.grey),
    ),
    dividerColor: Colors.grey[300],
    cardColor: Colors.white,
    chipTheme: ChipThemeData(
      backgroundColor: primary,
      deleteIconColor: Colors.white,
      labelStyle: AppConstants.appTextStyle1.copyWith(color: Colors.white),
      padding: EdgeInsets.all(4.0),
      shape: StadiumBorder(),
      secondaryLabelStyle:
          AppConstants.appTextStyle1.copyWith(color: Colors.white),
      secondarySelectedColor: Color(0xFF4F8C94),
      selectedColor: Color(0xFF4F8C94),
    ),
    iconTheme: const IconThemeData(
      color: Color(0xFF4F8C94),
      size: 24,
    ),
    tabBarTheme: TabBarTheme(
      indicatorColor: primary,
      labelColor: primary,
      unselectedLabelColor: Colors.grey,
    ),
    cardTheme: const CardTheme(
      color: Colors.white,
      elevation: 2.0,
      margin: EdgeInsets.symmetric(vertical: 8.0),
    ),
    dialogTheme: DialogTheme(
      backgroundColor: Colors.white,
      titleTextStyle:
          AppConstants.appTextStyle1.copyWith(color: Color(0xFF333333)),
      contentTextStyle:
          AppConstants.appTextStyle1.copyWith(color: Color(0xFF333333)),
    ),
    checkboxTheme: CheckboxThemeData(
      fillColor:
          WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
        if (states.contains(WidgetState.disabled)) {
          return null;
        }
        if (states.contains(WidgetState.selected)) {
          return primary;
        }
        return null;
      }),
    ),
    radioTheme: RadioThemeData(
      fillColor:
          WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
        if (states.contains(WidgetState.disabled)) {
          return null;
        }
        if (states.contains(WidgetState.selected)) {
          return primary;
        }
        return null;
      }),
    ),
    switchTheme: SwitchThemeData(
      thumbColor:
          WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
        if (states.contains(WidgetState.disabled)) {
          return null;
        }
        if (states.contains(WidgetState.selected)) {
          return primary;
        }
        return null;
      }),
      trackColor:
          WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
        if (states.contains(WidgetState.disabled)) {
          return null;
        }
        if (states.contains(WidgetState.selected)) {
          return primary;
        }
        return null;
      }),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    fontFamily: "Poppins",
    primaryColor: primary, // Dark blue as the primary color
    scaffoldBackgroundColor: const Color(0xFF191919), // Dark grey background
    colorScheme: ColorScheme.dark(
      primary: primary, // Dark blue as the primary color
      secondary: Color(0xFF9E9E9E), // Light grey for secondary elements
      surface: Color(0xFF222222), // Card background
      error: Colors.red, // Error color
      onPrimary: Colors.white, // Text on primary
      onSecondary: Colors.white, // Text on secondary
      onBackground: Color(0xFFFFFFFF), // Text on background
      onSurface: Color(0xFFDDDDDD), // Text on surface
      onError: Colors.white, // Text on error
    ),
    textTheme: TextTheme(
      displayLarge: AppConstants.appTextStyle1.copyWith(
          fontSize: 32.0,
          fontWeight: FontWeight.bold,
          color: Color(0xFFFFFFFF)),
      bodyLarge: AppConstants.appTextStyle1.copyWith(
          fontSize: 16.0, color: Color(0xFFDDDDDD)), // Light grey text
      bodyMedium: AppConstants.appTextStyle1.copyWith(
          fontSize: 14.0, color: Color(0xFFBBBBBB)), // Subtle grey text
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Color(0xFF222222), // Dark grey for AppBar
      foregroundColor: Colors.white,
      elevation: 4.0,
      iconTheme: IconThemeData(color: Colors.white),
      actionsIconTheme: IconThemeData(color: Colors.white),
      toolbarTextStyle:
          AppConstants.appTextStyle1.copyWith(color: Colors.white),
      titleTextStyle: AppConstants.appTextStyle1.copyWith(color: Colors.white),
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: primary, // Dark blue for buttons
      textTheme: ButtonTextTheme.primary,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: primary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: const OutlineInputBorder(),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xFF9E9E9E)), // Light grey
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: primary), // Dark blue when focused
      ),
      hintStyle: AppConstants.appTextStyle1.copyWith(color: Colors.grey[600]),
    ),
    dividerColor: Colors.grey[800], // Subtle dividers
    cardColor: const Color(0xFF222222), // Dark grey for cards
    chipTheme: ChipThemeData(
      backgroundColor: primary, // Dark blue chips
      deleteIconColor: Colors.white,
      labelStyle: AppConstants.appTextStyle1.copyWith(color: Colors.white),
      padding: EdgeInsets.all(4.0),
      shape: StadiumBorder(),
      secondaryLabelStyle:
          AppConstants.appTextStyle1.copyWith(color: Colors.white),
      secondarySelectedColor: Color(0xFF9E9E9E),
      selectedColor: Color(0xFF9E9E9E), // Selected chips in light grey
    ),
    iconTheme: IconThemeData(
      color: primary, // Dark blue for icons
      size: 24,
    ),
    tabBarTheme: TabBarTheme(
      indicatorColor: primary, // Dark blue indicator
      labelColor: primary, // Dark blue label
      unselectedLabelColor: Colors.grey, // Grey for unselected
    ),
    cardTheme: const CardTheme(
      color: Color(0xFF222222), // Card background
      elevation: 2.0,
      margin: EdgeInsets.symmetric(vertical: 8.0),
    ),
    dialogTheme: DialogTheme(
      backgroundColor: Color(0xFF222222), // Dialog background
      titleTextStyle: AppConstants.appTextStyle1
          .copyWith(color: Color(0xFFFFFFFF)), // White for titles
      contentTextStyle: AppConstants.appTextStyle1
          .copyWith(color: Color(0xFFDDDDDD)), // Light grey text
    ),
    checkboxTheme: CheckboxThemeData(
      fillColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
        if (states.contains(MaterialState.disabled)) return null;
        if (states.contains(MaterialState.selected))
          return primary; // Dark blue when checked
        return null;
      }),
    ),
    radioTheme: RadioThemeData(
      fillColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
        if (states.contains(MaterialState.disabled)) return null;
        if (states.contains(MaterialState.selected))
          return primary; // Dark blue when selected
        return null;
      }),
    ),
    switchTheme: SwitchThemeData(
      thumbColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
        if (states.contains(MaterialState.disabled)) return null;
        if (states.contains(MaterialState.selected))
          return primary; // Dark blue for the thumb
        return null;
      }),
      trackColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
        if (states.contains(MaterialState.disabled)) return null;
        if (states.contains(MaterialState.selected))
          return primary; // Dark blue for the track
        return null;
      }),
    ),
  );
}
