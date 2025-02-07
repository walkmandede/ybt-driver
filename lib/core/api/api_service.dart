import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:ybt_driver/config/constants/app_functions.dart';
import 'package:ybt_driver/core/api/api_response_model.dart';
import 'package:ybt_driver/src/controllers/app_data_controller.dart';
import 'api_request_model.dart';

class ApiServiceController extends GetxController {
  static String baseUrl = "https://ybt-backend-flask.onrender.com/api";
  // static String baseUrl = "http://127.0.0.1:2345/api";

  static String getNetworkImage({required String path}) {
    return baseUrl + path;
  }

  Future<ApiResponseModel> makeARequest(
      {required ApiRequestModel apiRequestData,
      bool xNeedToken = false}) async {
    ApiResponseModel apiResponseModel = ApiResponseModel.getInstance();
    apiRequestData.url = baseUrl + apiRequestData.url;
    AppDataController dataController = Get.find();
    apiRequestData.headers = {
      "Content-Type": "application/json",
      if (xNeedToken) "apiToken": dataController.apiToken
    }..addAll(apiRequestData.headers ?? {});
    try {
      switch (apiRequestData.enumApiRequestMethods) {
        case EnumApiRequestMethods.get:
          apiResponseModel = convertHttpResponseIntoApiResponseModel(
              httpResponse: await _getRequest(apiRequestData: apiRequestData));
          break;
        case EnumApiRequestMethods.post:
          apiResponseModel = convertHttpResponseIntoApiResponseModel(
              httpResponse: await _postRequest(apiRequestData: apiRequestData));
          break;
        case EnumApiRequestMethods.put:
          apiResponseModel = convertHttpResponseIntoApiResponseModel(
              httpResponse: await _getRequest(apiRequestData: apiRequestData));
          break;
        case EnumApiRequestMethods.patch:
          apiResponseModel = convertHttpResponseIntoApiResponseModel(
              httpResponse:
                  await _patchRequest(apiRequestData: apiRequestData));
          break;
        case EnumApiRequestMethods.delete:
          apiResponseModel = convertHttpResponseIntoApiResponseModel(
              httpResponse:
                  await _deleteRequest(apiRequestData: apiRequestData));
          break;
      }
    } catch (exception) {
      superPrint(exception);
    }
    return apiResponseModel;
  }

  static Future<bool> checkInternet() async {
    if (kIsWeb) {
      return true;
    } else {
      try {
        final result = await InternetAddress.lookup('google.com');
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          return true;
        }
      } on SocketException catch (_) {
        return false;
      }
      return false;
    }
  }

  ApiResponseModel convertHttpResponseIntoApiResponseModel(
      {required http.Response httpResponse}) {
    ApiResponseModel apiResponseModel = ApiResponseModel.getInstance();
    try {
      apiResponseModel.bodyData = jsonDecode(httpResponse.body);
      apiResponseModel.bodyString = httpResponse.body;
      apiResponseModel.statusCode = httpResponse.statusCode;
      apiResponseModel.xSuccess =
          apiResponseModel.bodyData["status"].toString() == "error"
              ? false
              : true;
      apiResponseModel.message = apiResponseModel.bodyData["message"] ?? "-";
    } catch (e) {
      superPrint(e, title: "Converting HTTP Response to Api Response Model");
    }
    return apiResponseModel;
  }

  Future<http.Response> _getRequest(
      {required ApiRequestModel apiRequestData}) async {
    return http.get(
      Uri.parse(apiRequestData.url),
      headers: apiRequestData.headers,
    );
  }

  Future<http.Response> _postRequest(
      {required ApiRequestModel apiRequestData}) async {
    return http.post(
      Uri.parse(apiRequestData.url),
      body: jsonEncode(apiRequestData.data),
      headers: apiRequestData.headers,
    );
  }

  Future<http.Response> _patchRequest(
      {required ApiRequestModel apiRequestData}) async {
    return http.patch(
      Uri.parse(apiRequestData.url),
      body: jsonEncode(apiRequestData.data),
      headers: apiRequestData.headers,
    );
  }

  Future<http.Response> _deleteRequest(
      {required ApiRequestModel apiRequestData}) async {
    return http.delete(
      Uri.parse(apiRequestData.url),
      headers: apiRequestData.headers,
    );
  }
}
