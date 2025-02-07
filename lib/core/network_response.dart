import 'package:ybt_driver/core/api/api_response_model.dart';

class NetworkResponse {
  final ApiResponseModel apiResponse;
  NetworkResponse({
    required this.apiResponse,
  });
}

class NetworkSuccessResponse extends NetworkResponse {
  NetworkSuccessResponse({required super.apiResponse});
}

class NetworkFailureResponse extends NetworkResponse {
  final Exception exception;
  NetworkFailureResponse({required super.apiResponse, required this.exception});

  factory NetworkFailureResponse.getInstance() {
    return NetworkFailureResponse(
        apiResponse: ApiResponseModel.getInstance(), exception: Exception("-"));
  }
}
