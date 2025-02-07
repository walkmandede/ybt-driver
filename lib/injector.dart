import 'package:get/get.dart';
import 'package:ybt_driver/core/api/api_repo.dart';
import 'package:ybt_driver/core/api/api_service.dart';
import 'package:ybt_driver/src/controllers/app_data_controller.dart';

class MyInjector {
  Future<void> initDependencies() async {
    Get.put(AppDataController());
    Get.put(ApiServiceController());
    Get.put(ApiRepoController());
  }
}
