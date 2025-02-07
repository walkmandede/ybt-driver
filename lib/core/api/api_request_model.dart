import 'package:equatable/equatable.dart';

enum EnumApiRequestMethods { get, post, put, patch, delete }

// ignore: must_be_immutable
class ApiRequestModel extends Equatable {
  String url;
  EnumApiRequestMethods enumApiRequestMethods;
  Map<String, dynamic> data;
  Map<String, String>? headers;

  ApiRequestModel(
      {required this.url,
      required this.enumApiRequestMethods,
      this.data = const {},
      this.headers});

  @override
  List<Object?> get props => [url, enumApiRequestMethods, data, headers];
}
