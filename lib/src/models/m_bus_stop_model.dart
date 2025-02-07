import 'package:equatable/equatable.dart';
import 'package:latlong2/latlong.dart';
import 'package:ybt_driver/config/constants/app_functions.dart';

class BusStopModel extends Equatable {
  final String id;
  final String serial;
  final LatLng location;
  final String roadNameEn;
  final String roadNameMm;
  final String stopNameEn;
  final String stopNameMm;

  const BusStopModel({
    required this.id,
    required this.serial,
    required this.location,
    required this.roadNameEn,
    required this.roadNameMm,
    required this.stopNameEn,
    required this.stopNameMm,
  });

/* {
            "_id": "674ffaf54da6667b9cc2e00c",
            "id": "1",
            "location": "16.868886,96.222571",
            "roadNameEn": "No. 2 Main Road",
            "roadNameMm": "အမှတ်(၂)လမ်းမ",
            "stopNameEn": "Nat Sin",
            "stopNameMm": "နတ်စင်"
        },*/
  factory BusStopModel.fromMap({required Map<String, dynamic> data}) {
    return BusStopModel(
      id: data["_id"].toString(),
      serial: data["id"].toString(),
      location: AppFunctions.convertStringToLatLng2Instance(
          latLngString: data["location"].toString()),
      roadNameEn: data["roadNameEn"].toString(),
      roadNameMm: data["roadNameMm"].toString(),
      stopNameEn: data["stopNameEn"].toString(),
      stopNameMm: data["stopNameMm"].toString(),
    );
  }

  @override
  List<Object?> get props => [id, serial, location];
}
