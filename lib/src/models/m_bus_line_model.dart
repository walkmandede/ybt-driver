import 'package:equatable/equatable.dart';

class BusLineModel extends Equatable {
  final String id;
  final String email;
  final String name;
  final List<String> busStopIds;

  const BusLineModel(
      {required this.id,
      required this.email,
      required this.name,
      required this.busStopIds});

  factory BusLineModel.fromMap({required Map<String, dynamic> data}) {
    Iterable rawStops = data["busStopIds"] ?? [];
    return BusLineModel(
        id: data["id"].toString(),
        email: data["email"].toString(),
        name: data["name"].toString(),
        busStopIds: rawStops.map((e) => e.toString()).toList());
  }

  factory BusLineModel.getInstance() {
    return const BusLineModel(id: "", email: "", name: "", busStopIds: []);
  }

  bool xValid() {
    return id.isNotEmpty;
  }

  @override
  List<Object?> get props => [id, email, name, busStopIds];
}
