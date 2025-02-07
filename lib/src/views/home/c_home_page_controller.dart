import 'package:get/get.dart';
import 'package:ybt_driver/core/api/api_repo.dart';
import 'package:ybt_driver/src/controllers/app_data_controller.dart';

class HomePageController extends GetxController {
  bool xLoading = false;
  ApiRepoController apiRepoController = Get.find();
  AppDataController appDataController = Get.find();

  @override
  void onInit() {
    initLoad();
    super.onInit();
  }

  @override
  void onClose() {
    //
    super.onClose();
  }

  Future<void> initLoad() async {
    xLoading = true;
    update();
    await Future.value([
      apiRepoController.postUpdateMe(),
      apiRepoController.getUpdateBusStops()
    ]);
    xLoading = false;
    update();
  }
}
