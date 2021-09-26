import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:okanyohou/api/api_client.dart';
import 'package:okanyohou/api/api_endpoint.dart';
import 'package:okanyohou/api/api_repository.dart';
import 'package:okanyohou/api/api_response.dart';
import 'package:okanyohou/api/model/alert_model.dart';

class TopViewModel extends ChangeNotifier {
  bool initialized=false;
  final _apiRepository = ApiRepository.instance;
  late ApiClient _client;

  Future<void> init() async {
    initialized=true;
    notifyListeners();
  }

  Future<ApiResponse> getAlerts() async {
    try {
      final response = await _client.get(api: API.alerts);
      final responseData = AlertModel.fromJson(response.data as Map<String, dynamic>);
      if (response.statusCode == 200) {
        return ApiResponse(
            apiStatus: ApiResponseType.ok, result: responseData);
      } else {
        throw DioError(
          response: response,
          type: DioErrorType.response,
          requestOptions: RequestOptions(path: ''),
        );
      }
    } on DioError catch (e) {
      throw (e);
    } on Exception catch (_) {
      rethrow;
    }
  }
}
