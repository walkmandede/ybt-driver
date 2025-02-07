import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:ybt_driver/core/api/api_repo.dart';
import 'package:ybt_driver/src/models/m_bus_stop_model.dart';

import '../models/m_profile_model.dart';

class AppDataController extends GetxController {
  //variables
  String apiToken = "";
  ValueNotifier<ProfileModel?> profile = ValueNotifier(null);
  ValueNotifier<List<BusStopModel>> allBusStops = ValueNotifier([]);

  //functions
  BusStopModel? getBusStopModelById({required String id}) {
    for (final each in allBusStops.value) {
      if (each.id == id) {
        return each;
      }
    }
    return null;
  }

  Future<void> updateProfile() async {
    ApiRepoController apiRepoController = Get.find();
    await apiRepoController.postUpdateMe();
  }
}
