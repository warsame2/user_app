import 'package:dio/dio.dart';
import 'package:user_app/data/model/error_response.dart';
import 'package:user_app/features/auth/controllers/auth_controller.dart';
import 'package:user_app/main.dart';
import 'package:provider/provider.dart';

class ApiErrorHandler {
  static dynamic getMessage(error) {
    dynamic errorDescription = "";
    if (error is Exception) {
      try {
        if (error is DioException) {
          switch (error.type) {
            case DioExceptionType.cancel:
              errorDescription = "Request to API server was cancelled";
              break;
            case DioExceptionType.connectionTimeout:
              errorDescription = "Connection timeout with API server";
              break;
            case DioExceptionType.sendTimeout:
              errorDescription = "Send timeout";
              break;
            case DioExceptionType.receiveTimeout:
              errorDescription =
                  "Receive timeout in connection with API server";
              break;
            case DioExceptionType.badResponse:
              switch (error.response!.statusCode) {
                case 403:
                  if (error.response!.data['errors'] != null) {
                    print(
                        '---------(api response -------${error.response!.data}----)');
                    ErrorResponse errorResponse =
                        ErrorResponse.fromJson(error.response?.data);
                    errorDescription = errorResponse.errors?[0].message;

                    print(
                        '---------(api response -------$errorDescription----)');
                  } else {
                    errorDescription = error.response!.data['message'];
                  }
                  break;
                case 401:
                  if (error.response!.data['errors'] != null) {
                    ErrorResponse errorResponse =
                        ErrorResponse.fromJson(error.response?.data);
                    errorDescription = errorResponse.errors?[0].message;
                  } else {
                    errorDescription = error.response!.data['message'];
                  }
                  Provider.of<AuthController>(Get.context!, listen: false)
                      .clearSharedData();
                  break;
                case 404:
                case 403:
                  if (error.response!.data['error_type'] != null) {
                    errorDescription = error.response!.data['message'];
                  }
                case 500:
                  errorDescription = 'Internal server error';
                case 503:
                case 429:
                  errorDescription = error.response!.statusMessage;
                  break;
                default:
                  ErrorResponse errorResponse =
                      ErrorResponse.fromJson(error.response!.data);
                  if (errorResponse.errors != null &&
                      errorResponse.errors!.isNotEmpty) {
                    errorDescription = errorResponse;
                  } else {
                    errorDescription =
                        "Failed to load data - status code: ${error.response!.statusCode}";
                  }
              }
              break;
            case DioExceptionType.badCertificate:
              // TODO: Handle this case.
              break;
            case DioExceptionType.connectionError:
              // TODO: Handle this case.
              break;
            case DioExceptionType.unknown:
              errorDescription = "Request to API call limit excited ";
              break;
          }
        } else {
          errorDescription = "Unexpected error occured";
        }
      } on FormatException catch (e) {
        errorDescription = e.toString();
      }
    } else {
      errorDescription = "is not a subtype of exception";
    }
    return errorDescription;
  }
}
