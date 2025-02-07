import 'package:equatable/equatable.dart';

class BusDriverModel extends Equatable {
  final String id;
  final String name;
  final String phone;

  const BusDriverModel(
      {required this.id, required this.name, required this.phone});

  factory BusDriverModel.fromMap({required Map<String, dynamic> data}) {
    return BusDriverModel(
        id: data["_id"].toString(),
        name: data["name"].toString(),
        phone: data["phone"].toString());
  }

  @override
  List<Object?> get props => [];
}
