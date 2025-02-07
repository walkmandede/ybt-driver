import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

class AppConstants {
  static String mapTemplateUrl =
      "https://cartodb-basemaps-{s}.global.ssl.fastly.net/light_all/{z}/{x}/{y}.png";
  static String baseRasterTileWhiteUrl =
      // "https://s.basemaps.cartocdn.com/rastertiles/voyager/{z}/{x}/{y}.png";
      "https://api.maptiler.com/maps/350b059e-93c6-428e-8a5a-da7f1cda974f/{z}/{x}/{y}.png?key=SD6Ev9Xf11MLip5FQDt5";
  // static String baseRasterTileWhiteUrl = "https://tile.openstreetmap.org/{z}/{x}/{y}.png";
  // static String baseRasterTileWhiteUrl = "https://cartodb-basemaps-{s}.global.ssl.fastly.net/light_all/{z}/{x}/{y}.png";
  static LatLng suleCenterPoint = LatLng(16.77450980042373, 96.15986809670441);

  static TextStyle appTextStyle1 = GoogleFonts.poppins();

  static const double basePadding = 20;
  static const double baseButtonHeight = 50;
  static const double baseButtonHeightL = 60;
  static const double baseButtonHeightS = 30;
  static const double baseButtonHeightMS = 40;
  static const double basePaddingL = 20;
  static const double baseBorderRadius = 10;
  static const double baseBorderRadiusS = 8;
  static const double baseFontSizeM = 14;
  static const double baseFontSizeS = 12;
  static const double baseFontSizeXs = 10;
  static const double baseFontSizeL = 16;
  static const double baseFontSizeXL = 20;
  static const double baseFontSizeXXL = 26;
}
