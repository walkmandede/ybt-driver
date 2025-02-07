import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:ybt_driver/config/constants/app_constants.dart';
import 'package:ybt_driver/config/constants/app_extensions.dart';
import 'package:ybt_driver/config/constants/app_functions.dart';
import 'package:ybt_driver/config/route/route_names.dart';
import 'package:ybt_driver/src/controllers/app_data_controller.dart';
import 'package:ybt_driver/src/views/home/c_home_page_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomePageController homePageController;

  @override
  void initState() {
    homePageController = Get.put(HomePageController());
    super.initState();
  }

  @override
  void dispose() {
    Get.delete<HomePageController>();
    super.dispose();
  }

  Future<void> onClickStartService() async {
    final result = await AppFunctions().getCurrentLocation();
    if (result != null) {
      Get.toNamed(RouteNames.servicePage, arguments: false);
    } else {
      superPrint("denied");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                homePageController.initLoad();
              },
              icon: const Icon(Icons.refresh_rounded))
        ],
      ),
      body: SizedBox.expand(
        child: GetBuilder<AppDataController>(
          builder: (appDataController) {
            return GetBuilder<HomePageController>(
              builder: (homePageController) {
                if (homePageController.xLoading) {
                  return const Center(
                    child: CupertinoActivityIndicator(),
                  );
                }

                final profile = appDataController.profile.value;
                if (profile == null) {
                  return const Center(
                    child: Text("Something went wrong"),
                  );
                } else {
                  return SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppConstants.basePadding,
                        vertical: AppConstants.basePadding),
                    child: Column(
                      children: [
                        ...[
                          ["Name", profile.busDriverDetail.name],
                          ["Phone", profile.busDriverDetail.phone],
                          ["Bus Line", profile.busLineDetail.name],
                          [
                            "Current Bus Vehicle",
                            profile.busVehicleDetail == null
                                ? "-"
                                : profile.busVehicleDetail!.regNo
                          ],
                        ].map((each) {
                          final label = each[0];
                          final text = each[1];
                          return Padding(
                            padding: const EdgeInsets.only(
                                bottom: AppConstants.basePadding),
                            child: TextField(
                              readOnly: true,
                              controller: TextEditingController(text: text),
                              decoration: InputDecoration(labelText: label),
                            ),
                          );
                        }).toList(),
                        (AppConstants.basePadding / 2).heightBox(),
                        if (profile.busVehicleDetail != null)
                          SizedBox(
                            width: Get.width,
                            height: AppConstants.baseButtonHeight,
                            child: ElevatedButton(
                                onPressed: () {
                                  onClickStartService();
                                },
                                child: const Text("Start Service")),
                          ),
                        (AppConstants.basePadding / 2).heightBox(),
                        if (profile.busVehicleDetail != null)
                          SizedBox(
                            width: Get.width,
                            height: AppConstants.baseButtonHeight,
                            child: ElevatedButton(
                                onPressed: () {
                                  Get.toNamed(RouteNames.servicePage,
                                      arguments: true);
                                },
                                child: const Text(
                                    "Start Service in testing mode")),
                          ),
                        (AppConstants.basePadding / 2).heightBox(),
                        if (profile.busVehicleDetail != null)
                          Text(
                              "Starting service in testing mode does not gather device's current location and user(driver) has to tap the map to update current location of the bus"),
                      ],
                    ),
                  );
                }
              },
            );
          },
        ),
      ),
    );
  }
}
