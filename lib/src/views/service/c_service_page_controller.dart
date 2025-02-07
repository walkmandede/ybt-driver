import 'dart:async';

import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:ybt_driver/config/constants/app_enums.dart';
import 'package:ybt_driver/config/constants/app_functions.dart';
import 'package:ybt_driver/core/api/api_repo.dart';
import 'package:ybt_driver/src/controllers/app_data_controller.dart';

class ServicePageController extends GetxController {
  final bool xTesting;

  ServicePageController({required this.xTesting});

  //variables
  MapController mapController = MapController();
  Timer? timer;
  AppFunctions appFunctions = AppFunctions();

  @override
  void onInit() {
    initLoad();
    super.onInit();
  }

  @override
  void onClose() {
    if (timer != null) {
      timer!.cancel();
    }
    super.onClose();
  }

  Future<void> initLoad() async {
    timer = Timer.periodic(const Duration(seconds: 5), (_) async {
      if (!xTesting) {
        final result = await appFunctions.getCurrentLocation();
        if (result != null) {
          proceedUpdateNewLocation(location: result);
        }
      }
    });
  }

  Future<void> proceedUpdateNewLocation({required LatLng location}) async {
    ApiRepoController apiRepoController = Get.find();
    AppDataController appDataController = Get.find();
    await apiRepoController.patchUpdateABus(
        driverId: appDataController.profile.value!.busDriverDetail.id,
        busVehicleId: appDataController.profile.value!.busVehicleDetail!.id,
        location: location,
        serviceStatus: EnumBusServiceStatus.on);
    await apiRepoController.postUpdateMe();
    mapController.move(
        AppFunctions.convertStringToLatLng2Instance(
            latLngString:
                appDataController.profile.value!.busVehicleDetail!.location),
        mapController.camera.zoom);
  }
}
