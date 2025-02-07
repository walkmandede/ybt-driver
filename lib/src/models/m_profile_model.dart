import 'package:equatable/equatable.dart';

class ProfileModel extends Equatable {
  final BusDriverDetail busDriverDetail;
  final BusLineDetail busLineDetail;
  final BusVehicleDetail? busVehicleDetail;

  const ProfileModel({
    required this.busDriverDetail,
    required this.busLineDetail,
    this.busVehicleDetail,
  });

  factory ProfileModel.fromJson({required Map<String, dynamic> json}) {
    return ProfileModel(
      busDriverDetail: BusDriverDetail.fromJson(json['busDriverDetail']),
      busLineDetail: BusLineDetail.fromJson(json['busLineDetail']),
      busVehicleDetail: json['busVehicleDetail'] != null
          ? BusVehicleDetail.fromJson(json['busVehicleDetail'])
          : null,
    );
  }

  @override
  List<Object?> get props => [busDriverDetail, busLineDetail, busVehicleDetail];
}

class BusDriverDetail extends Equatable {
  final String busLineId;
  final String createdAt;
  final String id;
  final String name;
  final String phone;
  final String token;

  const BusDriverDetail({
    required this.busLineId,
    required this.createdAt,
    required this.id,
    required this.name,
    required this.phone,
    required this.token,
  });

  factory BusDriverDetail.fromJson(Map<String, dynamic> json) {
    return BusDriverDetail(
      busLineId: json['busLineId'].toString(),
      createdAt: json['createdAt'].toString(),
      id: json['id'].toString(),
      name: json['name'].toString(),
      phone: json['phone'].toString(),
      token: json['token'].toString(),
    );
  }

  @override
  List<Object> get props => [busLineId, createdAt, id, name, phone, token];
}

class BusLineDetail extends Equatable {
  final List<String> busStopIds;
  final String email;
  final String id;
  final String name;
  final String token;

  const BusLineDetail({
    required this.busStopIds,
    required this.email,
    required this.id,
    required this.name,
    required this.token,
  });

  factory BusLineDetail.fromJson(Map<String, dynamic> json) {
    return BusLineDetail(
      busStopIds: List<String>.from(json['busStopIds'] ?? []),
      email: json['email'].toString(),
      id: json['id'].toString(),
      name: json['name'].toString(),
      token: json['token'].toString(),
    );
  }

  @override
  List<Object> get props => [busStopIds, email, id, name, token];
}

class BusVehicleDetail extends Equatable {
  final String busLineId;
  final String driverId;
  final String id;
  final String lastLocationUpdatedAt;
  final String location;
  final String regNo;
  final String serviceStatus;

  const BusVehicleDetail({
    required this.busLineId,
    required this.driverId,
    required this.id,
    required this.lastLocationUpdatedAt,
    required this.location,
    required this.regNo,
    required this.serviceStatus,
  });

  factory BusVehicleDetail.fromJson(Map<String, dynamic> json) {
    return BusVehicleDetail(
      busLineId: json['busLineId'].toString(),
      driverId: json['driverId'].toString(),
      id: json['id'].toString(),
      lastLocationUpdatedAt: json['lastLocationUpdatedAt'].toString(),
      location: json['location'].toString(),
      regNo: json['regNo'].toString(),
      serviceStatus: json['serviceStatus'].toString(),
    );
  }

  @override
  List<Object> get props => [
        busLineId,
        driverId,
        id,
        lastLocationUpdatedAt,
        location,
        regNo,
        serviceStatus
      ];
}
