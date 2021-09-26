import 'package:dio/dio.dart' hide Headers;
import 'package:okanyohou/api/model/alert_model.dart';
import 'api_client.dart';
import 'api_endpoint.dart';
import 'api_response.dart';

class ApiRepository {
  ApiRepository._() {
    // リリースモードでは assert が走らないことを利用して環境を分けている
    // 参考: https://star-zero.medium.com/flutterでdebug実行を判定する-769d92fa682c
    assert(isDebug = true);

    final dio = new Dio();
    dio.options.connectTimeout = 60*1000;
    dio.options.receiveTimeout =  60*1000;
    dio.options.sendTimeout = 60*10000;

    if (isDebug) {
      dio.interceptors.add(
        LogInterceptor()
          ..requestBody = true
          ..responseBody = true,
      );
    }
    _client = ApiClient(dio);
  }

  /// リポジトリを使用する場合は ApiRepository.instance を呼ぶこと
  static ApiRepository instance = ApiRepository._();

  late ApiClient _client;
  bool isDebug = false;


  // ユーザーがobjectiveRoomに参加しているかを確認する
  Future<ApiResponse> postAlert({required Map<String, dynamic> parameter})async {
    try {
      final response = await _client.post(api: API.alerts,data: parameter);
      final responseData =
        AlertModel.fromJson(response.data as Map<String, dynamic>);

      if (response.statusCode == 200) {
        if (responseData != null){
          return ApiResponse(
              apiStatus: ApiResponseType.notFound,
              result: null);
        }else {
          return ApiResponse(
              apiStatus: ApiResponseType.ok,
              result: responseData);
        }
      } else {
        return ApiResponse(
            apiStatus: ApiResponseType.badRequest,
            result: null);
      }
    } on DioError catch (e) {
      throw DioError(
        response: e.response,
        type: DioErrorType.response,
        requestOptions: RequestOptions(path: ''),
      );
    } on Exception catch (_) {
      print("user exist other error");
      print(_);
      rethrow;
    }
  }


  Future<ApiResponse> getAlerts() async {
    try {
      final response = await _client.get(api: API.alerts);
      List<dynamic> responseData = response.data;
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
