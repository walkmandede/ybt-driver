import 'dart:convert';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';
import 'package:permission_handler/permission_handler.dart';

void dismissKeyboard() {
  FocusManager.instance.primaryFocus?.unfocus();
}

void saveLogFromException(e1, e2) {
  // Get.find<LoggerController>().insertNewLog(
  //     log: LoggerModel.fromExceptions(title: e1.toString(), stackTrace: e2));
}

void vibrateNow() {
  try {
    HapticFeedback.selectionClick();
  } catch (e1, e2) {
    saveLogFromException(e1, e2);
    null;
  }
}

void superPrint(var content, {var title = 'Super Print'}) {
  String callerFrame = '';

  if (kDebugMode) {
    try {
      final stackTrace = StackTrace.current;
      final frames = stackTrace.toString().split("\n");
      callerFrame = kIsWeb ? frames[2] : frames[1];
    } catch (e1, e2) {
      debugPrint(e1.toString(), wrapWidth: 1024);
      saveLogFromException(e1, e2);
    }

    String pathString = "";
    DateTime dateTime = DateTime.now();
    String dateTimeString =
        '${dateTime.hour} : ${dateTime.minute} : ${dateTime.second}.${dateTime.millisecond}';

    if (kIsWeb) {
      const prefix =
          "/Users/poepoeaung/Desktop/kph_projects/ybt/ybt_driver/lib/";
      final basePath = callerFrame.split(" ")[0];
      final lineNumber = callerFrame.split(" ")[1];
      pathString =
          "${basePath.split('(').last.replaceAll(')', '').replaceAll(" ", "").replaceAll("superPrint", "").replaceAll("new", "").replaceAll("packages/ybt_admin/", prefix)}:$lineNumber";
    } else {
      const prefix =
          "/Users/poepoeaung/Desktop/kph_projects/ybt/ybt_driver/lib";

      pathString = callerFrame.split('(').last.replaceAll(')', '');

      pathString = pathString.replaceAll("package:ybt_driver", prefix);
    }

    debugPrint('', wrapWidth: 1024);
    debugPrint('- ${title.toString()} - $pathString', wrapWidth: 1024);
    debugPrint('____________________________');
    try {
      debugPrint(
          const JsonEncoder.withIndent('  ')
              .convert(const JsonDecoder().convert(content)),
          wrapWidth: 1024);
    } catch (e1, _) {
      try {
        debugPrint(
            const JsonEncoder.withIndent('  ')
                .convert(const JsonDecoder().convert(jsonEncode(content))),
            wrapWidth: 1024);
      } catch (e1, _) {
        debugPrint(content.toString());
        // saveLogFromException(e1,e2);;
      }
      // saveLogFromException(e1,e2);;
    }
    debugPrint('____________________________ $dateTimeString');
  }
}

String numberFormat(String numString) {
  return NumberFormat('#,##0').format(int.parse(numString));
}

class AppFunctions {
  Future<LatLng?> getCurrentLocation() async {
    // Check if location services are enabled
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Get.showSnackbar(const GetSnackBar(
        message: "Please enable location service to continue!",
      ));
      return null;
    }

    // Check location permissions
    var permissionStatus = await Permission.location.status;
    if (permissionStatus.isDenied) {
      // Request location permission
      permissionStatus = await Permission.location.request();
      if (permissionStatus.isDenied) {
        Get.showSnackbar(const GetSnackBar(
          message: "Please allow location permission to continue!",
        ));
        return null;
      }
    }

    if (permissionStatus.isPermanentlyDenied) {
      Get.showSnackbar(const GetSnackBar(
        message: "Please allow location permission to continue!",
      ));
      return null;
    }

    // Get the current location
    try {
      Position position = await Geolocator.getCurrentPosition();

      return LatLng(position.latitude, position.longitude);
    } catch (e) {
      print("Error getting location: $e");
      return null;
    }
  }

  int calculateMaxPage(int productsLength, int size) {
    if (productsLength % size == 0) {
      return productsLength ~/ size;
    } else {
      return (productsLength ~/ size) + 1;
    }
  }

  static LatLng convertStringToLatLng2Instance({required String latLngString}) {
    try {
      return LatLng(double.tryParse(latLngString.split(",").first) ?? 0,
          double.tryParse(latLngString.split(",").last) ?? 0);
    } catch (e) {
      return const LatLng(0, 0);
    }
  }

  static String convertLatLng2InstanceToString(
      {required LatLng latLng2Instance}) {
    return "${latLng2Instance.latitude},${latLng2Instance.longitude}";
  }

  void addScrollEndListener(
      {required ScrollController scrollController,
      required Function() onReachBottom}) {
    scrollController.addListener(
      () {
        if (scrollController.position.atEdge) {
          bool isBottom = scrollController.position.pixels != 0;
          if (isBottom) {
            onReachBottom();
          }
        }
      },
    );
  }

  String hideMiddleCharacters(String input, int start) {
    if (input.length < 6) {
      // Not enough characters to hide
      return input;
    }

    // Replace characters in the middle with asterisks
    int startIndex = start;
    int endIndex = input.length - 4;
    String hiddenPart = '*' * (endIndex - startIndex + 1);
    String result = input.replaceRange(startIndex, endIndex + 1, hiddenPart);

    return result;
  }

  String convertMinutesToHoursAndMinutes(int minutes) {
    if (minutes < 0) {
      return "Invalid input";
    }

    int hours = minutes ~/ 60;
    int remainingMinutes = minutes % 60;

    if (hours == 0) {
      return "${remainingMinutes}min";
    } else if (remainingMinutes == 0) {
      return "${hours}hr";
    } else {
      return "${hours}hr ${remainingMinutes}min";
    }
  }

  dynamic parseEnum<T>({
    required List<Enum> values,
    required String query,
    required Enum defaultValue,
  }) {
    dynamic result = defaultValue;
    try {
      result = values.where((element) {
            return query.toUpperCase() == element.name.toUpperCase();
          }).firstOrNull ??
          defaultValue;
    } catch (e1, _) {
      //
    }
    return result;
  }

  bool isSameDay({required DateTime dateTime1, required DateTime dateTime2}) {
    return dateTime1.toString().substring(0, 10) ==
        dateTime2.toString().substring(0, 10);
  }

  List<DateTime> getBetweenDates({required DateTimeRange dtr}) {
    List<DateTime> result = [];
    DateTime tempDate = dtr.start;
    do {
      result.add(tempDate);
      tempDate = tempDate.add(const Duration(days: 1));
    } while (!isSameDay(
        dateTime1: tempDate, dateTime2: dtr.end.add(const Duration(days: 1))));
    return result;
  }

  ///if xStartWithMonday is false, the result will be started in Sunday
  List<int?> getCalendarData(
      {required DateTime dateTime, bool xStartWithMonday = false}) {
    if (xStartWithMonday) {
      return _getCalendarDataWithMondayStart(dateTime: dateTime);
    } else {
      return _getCalendarDataWithSundayStart(dateTime: dateTime);
    }
  }

  List<int?> _getCalendarDataWithSundayStart({required DateTime dateTime}) {
    int startWeekDay = 7;

    //toIncreaseNextWeek
    int endWeekDay = {
      1: 7,
      2: 1,
      3: 2,
      4: 3,
      5: 4,
      6: 5,
      7: 6,
    }[startWeekDay]!;

    //1=Monday, 7=Sunday
    DateTimeRange dateTimeRange =
        AppFunctions().getCurrentMonth(dateTime: dateTime);
    final start = dateTimeRange.start;
    final end = dateTimeRange.end;
    int currentDay = 1;
    int currentWeek = 1;
    List<int?> data = List.generate(42, (index) => null);
    do {
      DateTime thatDay = start.copyWith(day: currentDay);
      int weekday = (thatDay.weekday);
      int rowIndex = (startWeekDay + weekday) % 7;
      final currentWeekIndex = currentWeek - 1;
      int index = rowIndex + (currentWeekIndex * 7);

      data[index] = currentDay;
      currentDay++;
      if (weekday == endWeekDay) {
        //sunday
        currentWeek++;
      }
    } while (currentDay <= end.day);
    return data;
  }

  List<int?> _getCalendarDataWithMondayStart({required DateTime dateTime}) {
    //1=Monday, 7=Sunday
    DateTimeRange dateTimeRange =
        AppFunctions().getCurrentMonth(dateTime: dateTime);
    final start = dateTimeRange.start;
    final end = dateTimeRange.end;
    int currentDay = 1;
    int currentWeek = 1;
    List<int?> data = List.generate(42, (index) => null);
    do {
      DateTime thatDay = start.copyWith(day: currentDay);
      int weekday = (thatDay.weekday);
      int index = (((currentWeek - 1) * 7) + weekday) - 1;
      data[index] = currentDay;
      currentDay++;
      if (weekday == 7) {
        //sunday
        currentWeek++;
      }
    } while (currentDay <= end.day);
    return data;
  }

  DateTimeRange getCurrentMonth({required DateTime dateTime}) {
    DateTime start = DateTime.now();
    DateTime end = DateTime.now();
    try {
      start = DateTime(dateTime.year, dateTime.month, 1, 0, 0);
      end = DateTime(start.year, start.month + 1, 1, 23, 59, 59, 999)
          .subtract(const Duration(days: 1));
    } catch (e1, _) {
      //
    }
    final DateTimeRange dateTimeRange = DateTimeRange(start: start, end: end);
    return dateTimeRange;
  }

  DateTimeRange getNextMonth({required DateTime dateTime}) {
    DateTime start = DateTime.now();
    DateTime end = DateTime.now();
    try {
      start = DateTime(dateTime.year, dateTime.month + 1, 1, 0, 0);
      end = DateTime(start.year, start.month + 1, 1, 23, 59, 59, 999)
          .subtract(const Duration(days: 1));
    } catch (e1, _) {
      //
    }
    final DateTimeRange dateTimeRange = DateTimeRange(start: start, end: end);
    return dateTimeRange;
  }

  DateTimeRange getPrevMonth({required DateTime dateTime}) {
    DateTime start = DateTime.now();
    DateTime end = DateTime.now();
    try {
      start = DateTime(dateTime.year, dateTime.month - 1, 1, 0, 0);
      end = DateTime(start.year, start.month + 1, 1, 23, 59, 59, 999)
          .subtract(const Duration(days: 1));
    } catch (e1, _) {
      //
    }
    final DateTimeRange dateTimeRange = DateTimeRange(start: start, end: end);
    return dateTimeRange;
  }

  DateTimeRange getCurrentWeek({required DateTime focusedDate}) {
    int weekday = focusedDate.weekday;
    DateTime start = DateTime.now();

    if (weekday == 7) {
      start = focusedDate;
    } else {
      do {
        focusedDate = focusedDate.subtract(const Duration(days: 1));
        weekday = focusedDate.weekday;
      } while (weekday != 7);
      start = focusedDate;
    }
    return DateTimeRange(start: start, end: start.add(const Duration(days: 6)));
  }

  String getWeekdayString(int weekdayIndex) {
    Map<int, String> data = {
      1: "Monday",
      2: "Tuesday",
      3: "Wednesday",
      4: "Thursday",
      5: "Friday",
      6: "Saturday",
      7: "Sunday",
    };

    return data[weekdayIndex] ?? "";
  }

  String getDateRangeString(
      {required DateTime firstDate, required DateTime lastDate}) {
    String dateString = "-";
    try {
      if (firstDate.year == lastDate.year) {
        //sameYear
        if (firstDate.month == lastDate.month) {
          //sameYearSameMonth
          if (firstDate.day == lastDate.day) {
            //sameYearSameMonthSameDay
            dateString = DateFormat("d MMM").format(lastDate);
          } else {
            //sameMonthButNotSameDay
            dateString =
                "${firstDate.day}-${DateFormat("d MMM").format(lastDate)}";
          }
        } else {
          //sameYearButNotSameMonth
          dateString =
              "${DateFormat("d MMM").format(firstDate)}-${DateFormat("d MMM").format(lastDate)}";
        }
      } else {
        //notSameYear
        dateString =
            "${DateFormat.yMMMd().format(firstDate)}-${DateFormat.yMMMd().format(lastDate)}";
      }
    } catch (e1, _) {
      //
    }
    return dateString;
  }

  convertDate(String dateTimeString) {
    DateTime convertedDateTime = DateTime.parse(dateTimeString);
    var formattedDate = DateFormat('d MMM, yyyy').format(convertedDateTime);
    return formattedDate;
  }

  static Map<int, String> numbersMap = const {
    0: '၀',
    1: '၁',
    2: '၂',
    3: '၃',
    4: '၄',
    5: '၅',
    6: '၆',
    7: '၇',
    8: '၈',
    9: '၉',
  };

  static Map<int, String> monthsMap = const {
    1: 'ဇန်နဝရီ',
    2: 'ဖေဖော်ဝါရီ',
    3: 'မတ်',
    4: 'ဧပြီ',
    5: 'မေ',
    6: 'ဇွန်',
    7: 'ဇူလိုင်',
    8: 'သြဂုတ်',
    9: 'စက်တင်ဘာ',
    10: 'အောက်တိုဘာ',
    11: 'နိုဝင်ဘာ',
    12: 'ဒီဇင်ဘာ',
  };

  static String convertNumbersToLocalizedString(int numbers) {
    String result = '';
    String raw = numbers.toString();
    for (var element in raw.characters) {
      try {
        result = result + numbersMap[int.tryParse(element)].toString();
      } catch (e) {
        null;
      }
    }
    return result;
  }

  Future<LatLng?> requestCurrentLocation() async {
    LatLng? result;
    try {
      bool xGranted = false;
      final status = await Permission.location.status;

      //checking permission is granted properly
      if (status.isGranted || status.isLimited) {
        xGranted = true;
      } else {
        final requestResult = await Permission.location.request();
        if (requestResult.isGranted || requestResult.isLimited) {
          xGranted = true;
        }
      }

      //getting current location

      if (xGranted) {
        final geoResult = await Geolocator.getCurrentPosition(
          locationSettings: WebSettings(
            timeLimit: const Duration(seconds: 20),
            accuracy: LocationAccuracy.best,
          ),
        );
        result = LatLng(geoResult.latitude, geoResult.longitude);
      }
    } catch (_) {}
    return result;
  }

  static Widget getSvgIcon(
      {required String svgData,
      required Color color,
      Size size = const Size(20, 20)}) {
    return SvgPicture.string(
      svgData,
      colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
      width: size.width,
      height: size.height,
    );
  }
}
