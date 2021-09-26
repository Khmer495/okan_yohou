import 'package:dio/dio.dart' hide Headers;
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



}
