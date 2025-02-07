import 'package:equatable/equatable.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:ybt_driver/config/constants/app_enums.dart';
import 'package:ybt_driver/config/constants/app_functions.dart';

class BusVehicleModel extends Equatable {
  final String id;
  final String busLineId;
  final String? driverId;
  final String lastLocationUpdatedAt;
  final LatLng location;
  final String regNo;
  final EnumBusServiceStatus enumBusServiceStatus;

  BusVehicleModel(
      {required this.id,
      required this.busLineId,
      required this.driverId,
      required this.enumBusServiceStatus,
      required this.lastLocationUpdatedAt,
      required this.location,
      required this.regNo});

  factory BusVehicleModel.fromMap({required Map<String, dynamic> data}) {
    return BusVehicleModel(
        id: data["_id"].toString(),
        driverId: data["driverId"],
        busLineId: data["busLineId"].toString(),
        lastLocationUpdatedAt: data["lastLocationUpdatedAt"].toString(),
        location: AppFunctions.convertStringToLatLng2Instance(
            latLngString: data["location"].toString()),
        enumBusServiceStatus: EnumBusServiceStatus.values.firstWhereOrNull(
                (e) => e.label == data["serviceStatus"].toString()) ??
            EnumBusServiceStatus.off,
        regNo: data["regNo"].toString());
  }

  @override
  List<Object?> get props => [
        id,
        driverId,
      ];
}
