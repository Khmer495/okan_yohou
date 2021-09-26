import 'package:dio/dio.dart' hide Headers;
import 'package:okanyohou/util/base_url.dart';

import 'api_endpoint.dart';

class ApiClient {
  factory ApiClient(Dio dio) => _instance ??= ApiClient._internal(dio);
  ApiClient._internal(this.dio);
  final Dio dio;
  static ApiClient? _instance;

  Map<String, dynamic> getAccessTokenHeader() {
    final token = '';
    if (token != null) {
      return <String, dynamic>{
        'content-type': 'application/json',
        'Authorization': 'Bearer $token',
      };
    }
    return <String, dynamic>{'content-type': 'application/json'};
  }

  Future<Response> userCreate(
      {required API api, required FormData data}) async {
    try {
      dio.options.headers['content-Type'] = 'application/json';
      final response = await dio.post(apiDomain() + version() + endPoint(api),
          data: data, options: Options(responseType: ResponseType.json));
      if (response.statusCode == 201) {
        return response;
      } else {
        throw DioError(
          response: response,
          type: DioErrorType.response,
          requestOptions: RequestOptions(path: ''),
        );
      }
    } catch (e) {
      throw (e);
    }
  }

  Future<Response> checkUserExist({
    required API api,
    required String requiredIds,
  }) async {
    dio.options.headers['content-Type'] = 'application/json';
    try {
      final response = await dio.get(
        apiDomain() + version() + endPoint(api) + requiredIds + '/',
        queryParameters: null,
        options: Options(responseType: ResponseType.json),
      );
      if (response.statusCode == 200) {
        return response;
      } else {
        throw DioError(
          response: response,
          type: DioErrorType.response,
          requestOptions: RequestOptions(path: ''),
        );
      }
    } catch (e) {
      throw (e);
    }
  }

  Future<Response> post({required API api, FormData? data}) async {
    dio.options.headers = getAccessTokenHeader();
    try {
      final response = await dio.post(apiDomain() + version() + endPoint(api),
          options: Options(responseType: ResponseType.json), data: data);
      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 202) {
        return response;
      } else {
        throw DioError(
          response: response,
          type: DioErrorType.response,
          requestOptions: RequestOptions(path: ''),
        );
      }
    } catch (e) {
      throw (e);
    }
  }

  Future<Response> patch({
    required API api,
    required FormData? data,
    required String requiredId,
  }) async {
    dio.options.headers = getAccessTokenHeader();
    try {
      final response = await dio.patch(
        apiDomain() + version() + endPoint(api) + requiredId + '/',
        data: data,
        options: Options(responseType: ResponseType.json),
      );

      if (response.statusCode == 202) {
        return response;
      } else {
        throw DioError(
          response: response,
          type: DioErrorType.response,
          requestOptions: RequestOptions(path: ''),
        );
      }
    } catch (e) {
      throw (e);
    }
  }

  Future<Response> deleteWithIds({
    required API api,
    required String requiredId,
  }) async {
    dio.options.headers = getAccessTokenHeader();
    try {
      final response = await dio.delete(
        apiDomain() + version() + endPoint(api) +requiredId+ '/',
        // data: data,
        options: Options(responseType: ResponseType.json),
      );
      if (response.statusCode == 200) {
        return response;
      } else {
        throw DioError(
          response: response,
          type: DioErrorType.response,
          requestOptions: RequestOptions(path: ''),
        );
      }
    } catch (e) {
      throw (e);
    }
  }

  Future<Response> upload({required API api, FormData? data}) async {
    dio.options.headers = getAccessTokenHeader();
    try {
      final response = await dio.post(apiDomain() + version() + endPoint(api),
          data: data, options: Options(responseType: ResponseType.json));
      if (response.statusCode == 200) {
        return response;
      } else {
        throw DioError(
          response: response,
          type: DioErrorType.response,
          requestOptions: RequestOptions(path: ''),
        );
      }
    } catch (e) {
      throw (e);
    }
  }

  Future<Response> get({
    Map<String, dynamic>? parameter,
    required API api,
  }) async {
    dio.options.headers = getAccessTokenHeader();

    try {
      final response = await dio.get(
        apiDomain() + version() + endPoint(api),
        queryParameters: parameter,
        options: Options(responseType: ResponseType.json),
      );
      if (response.statusCode == 200) {
        return response;
      } else {
        throw DioError(
          response: response,
          type: DioErrorType.response,
          requestOptions: RequestOptions(path: ''),
        );
      }
    } catch (e) {
      throw (e);
    }
  }

  Future<Response> getWithIds({
    Map<String, dynamic>? parameter,
    required API api,
    required String requiredIds,
  }) async {
    dio.options.headers = getAccessTokenHeader();
    try {
      final response = await dio.get(
        apiDomain() + version() + endPoint(api) + requiredIds + '/',
        queryParameters: parameter,
        options: Options(responseType: ResponseType.json),
      );
      if (response.statusCode == 200) {
        return response;
      } else {
        throw DioError(
          response: response,
          type: DioErrorType.response,
          requestOptions: RequestOptions(path: ''),
        );
      }
    } catch (e) {
      throw (e);
    }
  }

  Future<Response> postWithIds(
      {required API api,
      required String requiredIds,
      FormData? data}) async {
    dio.options.headers = getAccessTokenHeader();
    print(getAccessTokenHeader());
    try {
      final response = await dio.post(
          apiDomain() + version() + endPoint(api) + requiredIds + '/',
          options: Options(responseType: ResponseType.json),
          data: data);
      if (response.statusCode == 201 || response.statusCode == 200) {
        return response;
      } else {
        throw DioError(
          response: response,
          type: DioErrorType.response,
          requestOptions: RequestOptions(path: ''),
        );
      }
    } catch (e) {
      throw (e);
    }
  }

  Future<Response> patchWithIds({
    required API api,
    required FormData? data,
    required String requiredId,
  }) async {
    dio.options.headers = await getAccessTokenHeader();
    try {
      final response = await dio.patch(
        apiDomain() + version() + endPoint(api) + requiredId + '/',
        data: data,
        options: Options(responseType: ResponseType.json),
      );

      if (response.statusCode == 202 || response.statusCode == 200) {
        return response;
      } else {
        throw DioError(
          response: response,
          type: DioErrorType.response,
          requestOptions: RequestOptions(path: ''),
        );
      }
    } catch (e) {
      throw (e);
    }
  }

  Future<Response> gettoken({
    // Map<String, dynamic>? parameter,
    required API api,
  }) async {
    dio.options.headers = getAccessTokenHeader();
    dio.options.headers['channelName'] = 'abc';
    try {
      final response = await dio.post(
        apiDomain() + version() + endPoint(api) ,
        // queryParameters: parameter,
        // options: Options(responseType: ResponseType.json),
      );
      if (response.statusCode == 200) {
        return response;
      } else {
        throw DioError(
          response: response,
          type: DioErrorType.response,
          requestOptions: RequestOptions(path: ''),
        );
      }
    } on DioError catch (e) {
      //TODO DioErrorの表示
      throw (e);
    } on Exception catch (_) {
      rethrow;
    }
  }
}
