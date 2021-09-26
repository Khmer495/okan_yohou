

class ApiResponse {
  ApiResponse({
    required this.apiStatus,
    this.result,
  });
  final ApiResponseType apiStatus;
  final dynamic result;

  static ApiResponseType convert(int statusCode) {
    if (statusCode == ApiResponseType.ok.code) {
      return ApiResponseType.ok;
    } else if (statusCode == ApiResponseType.created.code) {
      return ApiResponseType.created;
    } else if (statusCode == ApiResponseType.badRequest.code) {
      return ApiResponseType.badRequest;
    } else if (statusCode == ApiResponseType.internalServerError.code) {
      return ApiResponseType.internalServerError;
    } else {
      return ApiResponseType.other;
    }
  }
}

// ここは必要に応じて定義
enum ApiResponseType {
  ok,
  created,
  yetCreated,
  patched,
  badRequest,
  forbidden,
  unauthorized,
  notFound,
  methodNotAllowed,
  conflict,
  internalServerError,
  internetConnectionError,
  other,
}

extension ApiErrorTypeExtension on ApiResponseType {
  int get code {
    switch (this) {
      case ApiResponseType.ok:
        return 200;
      case ApiResponseType.created:
        return 201;
      case ApiResponseType.patched:
        return 202;
      case ApiResponseType.badRequest:
        return 400;
      case ApiResponseType.unauthorized:
        return 401;
      case ApiResponseType.forbidden:
        return 403;
      case ApiResponseType.internalServerError:
        return 500;
      case ApiResponseType.conflict:
      case ApiResponseType.internetConnectionError:
      case ApiResponseType.other:
      case ApiResponseType.methodNotAllowed:
      case ApiResponseType.notFound:
      case ApiResponseType.yetCreated:
        return 0;
    }
  }
}
