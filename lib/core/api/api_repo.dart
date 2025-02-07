import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:ybt_driver/config/constants/app_functions.dart';
import 'package:ybt_driver/core/api/api_end_points.dart';
import 'package:ybt_driver/core/api/api_request_model.dart';
import 'package:ybt_driver/core/api/api_response_model.dart';
import 'package:ybt_driver/core/api/api_service.dart';
import 'package:ybt_driver/src/controllers/app_data_controller.dart';
import 'package:ybt_driver/src/models/m_profile_model.dart';

import '../../config/constants/app_enums.dart';
import '../../src/models/m_bus_stop_model.dart';

enum EnumGetMusicTypes {
  artists(label: "Artists"),
  albums(label: "Albums"),
  genres(label: "Genres");

  final String label;
  const EnumGetMusicTypes({required this.label});
}

class ApiRepoController extends GetxController {
  Future<ApiResponseModel> postLogin(
      {required String phone, required String password}) async {
    ApiResponseModel result = ApiResponseModel.getInstance();
    try {
      result = await ApiServiceController().makeARequest(
          apiRequestData: ApiRequestModel(
              enumApiRequestMethods: EnumApiRequestMethods.post,
              url: ApiEndPoints.login,
              data: {"phone": phone, "password": password}),
          xNeedToken: false);
      AppDataController appDataController = Get.find();
      appDataController.apiToken = result.bodyData["data"]["token"].toString();
    } catch (e) {
      superPrint(e, title: "API LOGIN NOW");
    }
    return result;
  }

  Future<void> postUpdateMe() async {
    try {
      final result = await ApiServiceController().makeARequest(
          apiRequestData: ApiRequestModel(
            enumApiRequestMethods: EnumApiRequestMethods.get,
            url: ApiEndPoints.me,
          ),
          xNeedToken: true);
      if (result.xSuccess) {
        AppDataController appDataController = Get.find();
        appDataController.profile.value =
            ProfileModel.fromJson(json: result.bodyData["data"]);
        appDataController.update();
      }
    } catch (e) {
      superPrint(e, title: "API UPDATING ME");
    }
  }

  Future<ApiResponseModel> patchUpdateABus({
    required String busVehicleId,
    LatLng? location,
    EnumBusServiceStatus? serviceStatus,
    String? driverId,
  }) async {
    ApiResponseModel result = ApiResponseModel.getInstance();
    try {
      final payLoad = {
        if (location != null)
          "location": AppFunctions.convertLatLng2InstanceToString(
              latLng2Instance: location),
        if (serviceStatus != null) "serviceStatus": serviceStatus.label,
        "driverId": driverId,
      };
      superPrint(payLoad);
      result = await ApiServiceController().makeARequest(
          apiRequestData: ApiRequestModel(
              enumApiRequestMethods: EnumApiRequestMethods.patch,
              url: "${ApiEndPoints.patchUpdateABus}/$busVehicleId",
              data: payLoad),
          xNeedToken: true);
      superPrint(result.bodyData);
    } catch (e) {
      superPrint(e, title: "API Patch bus");
    }
    return result;
  }

  Future<void> getUpdateBusStops() async {
    try {
      final result = await ApiServiceController().makeARequest(
          apiRequestData: ApiRequestModel(
            enumApiRequestMethods: EnumApiRequestMethods.get,
            url: ApiEndPoints.busStops,
          ),
          xNeedToken: true);
      if (result.xSuccess) {
        AppDataController appDataController = Get.find();
        appDataController.allBusStops.value = [];
        Iterable rawStops = result.bodyData["data"] ?? [];
        appDataController.allBusStops.value =
            rawStops.map((each) => BusStopModel.fromMap(data: each)).toList();
      }
    } catch (e) {
      superPrint(e, title: "API UPDATING ME");
    }
  }

  // Future<List<BusVehicleModel>> getAllBuses() async {
  //   List<BusVehicleModel> result = [];
  //   try {
  //     final apiResult = await ApiServiceController().makeARequest(
  //         apiRequestData: ApiRequestModel(
  //           enumApiRequestMethods: EnumApiRequestMethods.get,
  //           url: ApiEndPoints.getAllBuses,
  //         ),
  //         xNeedToken: true);
  //     if (apiResult.xSuccess) {
  //       Iterable rawData = apiResult.bodyData["data"] ?? [];
  //       result = rawData.map((e) => BusVehicleModel.fromMap(data: e)).toList();
  //     }
  //   } catch (e) {
  //     superPrint(e, title: "API Create bus");
  //   }
  //   return result;
  // }
}
