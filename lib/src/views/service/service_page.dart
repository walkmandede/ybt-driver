import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:ybt_driver/config/constants/app_constants.dart';
import 'package:ybt_driver/config/constants/app_functions.dart';
import 'package:ybt_driver/config/constants/app_svgs.dart';
import 'package:ybt_driver/src/controllers/app_data_controller.dart';
import 'package:ybt_driver/src/views/service/c_service_page_controller.dart';

class ServicePage extends StatefulWidget {
  final bool xTesting;
  const ServicePage({super.key, required this.xTesting});

  @override
  State<ServicePage> createState() => _ServicePageState();
}

class _ServicePageState extends State<ServicePage> {
  late ServicePageController servicePageController;

  @override
  void initState() {
    servicePageController =
        Get.put(ServicePageController(xTesting: widget.xTesting));
    super.initState();
  }

  @override
  void dispose() {
    Get.delete<ServicePageController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Testing : ${servicePageController.xTesting}"),
        actions: [
          IconButton(
              onPressed: () {
                AppDataController appDataController = Get.find();
                appDataController.updateProfile();
              },
              icon: const Icon(Icons.refresh))
        ],
      ),
      body: SizedBox.expand(
        child: GetBuilder<AppDataController>(
          builder: (appDataController) {
            return GetBuilder<ServicePageController>(
              builder: (servicePageController) {
                return Stack(
                  children: [
                    mapWidget(),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: metaWidget(),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }

  Widget mapWidget() {
    try {
      AppDataController appDataController = Get.find();

      final busLine = appDataController.profile.value!.busLineDetail;
      final busVehicleDetail =
          appDataController.profile.value!.busVehicleDetail;

      return FlutterMap(
        mapController: servicePageController.mapController,
        options: MapOptions(
          initialZoom: 12,
          interactionOptions:
              const InteractionOptions(enableMultiFingerGestureRace: true),
          initialCenter: const LatLng(16.775545012652657, 96.1670323640905),
          onTap: (tapPosition, point) {
            if (widget.xTesting) {
              servicePageController.proceedUpdateNewLocation(location: point);
            }
          },
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.kphkph.ybtadmin',
          ),
          MarkerClusterLayerWidget(
            options: MarkerClusterLayerOptions(
              maxClusterRadius: 45,
              size: const Size(100, 40),
              markers: [
                ...appDataController.allBusStops.value.where((eachStop) {
                  return busLine.busStopIds.contains(eachStop.id);
                }).map((eachStop) {
                  bool xContained = busLine.busStopIds.contains(eachStop.id);
                  return Marker(
                      width: Get.width * 0.25,
                      height: Get.width * 0.125,
                      point: eachStop.location,
                      child: InkWell(
                        onTap: () {},
                        child: Card(
                          elevation: 0,
                          color: !xContained
                              ? Theme.of(context).cardColor.withOpacity(0.8)
                              : Theme.of(context).primaryColor.withOpacity(0.8),
                          child: Padding(
                            padding: EdgeInsets.all(Get.width * 0.025),
                            child: FittedBox(
                              child: Text(
                                eachStop.stopNameEn,
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onPrimary),
                              ),
                            ),
                          ),
                        ),
                      ));
                }).toList(),
              ],
              polygonOptions: PolygonOptions(
                borderColor: Theme.of(context).primaryColor,
                color: Theme.of(context).primaryColor.withAlpha(100),
                borderStrokeWidth: 2,
              ),
              builder: (context, markers) {
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Theme.of(context).cardColor.withOpacity(0.8),
                  ),
                  child: Center(
                    child: Text(
                      markers.length.toString(),
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                );
              },
            ),
          ),
          MarkerLayer(markers: [
            Marker(
              alignment: Alignment.center,
              width: Get.width * 0.15,
              height: Get.width * 0.15,
              point: AppFunctions.convertStringToLatLng2Instance(
                  latLngString: busVehicleDetail!.location),
              child: SvgPicture.string(AppSvgs.busPinIcon),
            )
          ])
        ],
      );
    } catch (_) {
      return const SizedBox.shrink();
    }
  }

  Widget metaWidget() {
    AppDataController appDataController = Get.find();
    final profile = appDataController.profile.value;
    if (profile == null) {
      return const SizedBox.shrink();
    } else if (profile.busVehicleDetail == null) {
      return const SizedBox.shrink();
    }
    return SizedBox(
      width: double.infinity,
      child: Card(
        margin: EdgeInsets.symmetric(
            horizontal: AppConstants.basePadding,
            vertical: AppConstants.basePadding + Get.mediaQuery.padding.bottom),
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: AppConstants.basePadding,
              vertical: AppConstants.basePadding),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              [
                "Bus Detail",
                "${profile.busLineDetail.name} (${profile.busVehicleDetail!.regNo})"
              ],
              ["Location", (profile.busVehicleDetail!.location)],
              [
                "Last Updated At",
                (profile.busVehicleDetail!.lastLocationUpdatedAt)
              ],
            ].map((each) {
              final label = each[0];
              final text = each[1];
              return TextField(
                readOnly: true,
                controller: TextEditingController(text: text),
                decoration: InputDecoration(
                    labelText: label,
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
