import 'dart:async';
import 'package:dio/dio.dart';
import '../observers/dio_observer.dart';
import 'parts_and_exceptions/base_api_services.dart';
import 'parts_and_exceptions/network_response.dart';

class NetworkApiService extends BaseApiServices {
  final _dio = Dio();

  NetworkApiService() {
    _dio.interceptors.add(dioObserver);
    _dio.options.headers = {'Content-Type': 'application/json'};
  }

  @override
  /// Makes a GET request to the specified [url] with [headers] and returns a [NetworkResponse] object with either a successful response or a failed response.
  ///
  /// If the request is successful, the response is mapped to a tuple of (Response, null) and the successful response is returned. If the request fails, the error is mapped to a tuple of (null, ResponseFail) and the failed response is returned.
  ///
  /// The [CancelToken] can be used to cancel the request at any point of time.
  ///
  /// @param url The URL to make the GET request to.
  /// @param headers The headers to be sent with the GET request.
  /// @param cancelToken The [CancelToken] to be used to cancel the GET request. If not provided, a new [CancelToken] is created.
  /// @return A [NetworkResponse] object with either a successful response or a failed response.
  Future<NetworkResponse> getAPIResponse(String url,
      Map<String, dynamic> headers, CancelToken? cancelToken) async {
    try {
      Map<String, dynamic> requestHeaders = headers.isNotEmpty ? headers : {};
      final response = await _dio.get(
        url,
        cancelToken: cancelToken,
        options: Options(headers: requestHeaders),
      );
      final result = await responseStatus(response);
      if (result.$1 != null) {
        return ResponseSuccess(response: result.$1!);
      }
      return result.$2!;
    } on DioException catch (e) {
      return _handleDioError(e);
    }
  }

  @override
  /// Makes a PUT request to the specified [url] with [data] and [headers] and returns a [NetworkResponse] object with either a successful response or a failed response.
  ///
  /// If the request is successful, the response is mapped to a tuple of (Response, null) and the successful response is returned. If the request fails, the error is mapped to a tuple of (null, ResponseFail) and the failed response is returned.
  ///
  /// The [CancelToken] can be used to cancel the request at any point of time.
  ///
  /// @param url The URL to make the request to.
  /// @param data The data to be sent with the request. This can be a [Map<String, dynamic>], a [String], or a [FormData].
  /// @param headers The headers to be sent with the request.
  /// @param cancelToken The [CancelToken] to be used to cancel the request. If not provided, a new [CancelToken] is created.
  /// @return A [NetworkResponse] object with either a successful response or a failed response.
  Future<NetworkResponse> putAPIResponse(String url, dynamic data,
      Map<String, dynamic> headers, CancelToken? cancelToken) async {

    try {
      final requestHeaders = headers;
      final response = await _dio.put(
        url,
        data: data,
        cancelToken: cancelToken,
        options: Options(headers: requestHeaders),
      );
      final result = await responseStatus(response);
      if (result.$1 != null) {
        return ResponseSuccess(response: result.$1!);
      }
      return result.$2!;
    } on DioException catch (e) {
      return _handleDioError(e);
    }
  }

  @override
  /// Makes a POST request to the specified [url] with [data] and [headers] and returns a [NetworkResponse] object with either a successful response or a failed response.
  ///
  /// If the request is successful, the response is mapped to a tuple of (Response, null) and the successful response is returned. If the request fails, the error is mapped to a tuple of (null, ResponseFail) and the failed response is returned.
  ///
  /// The [CancelToken] can be used to cancel the request at any point of time.
  ///
  /// @param url The URL to make the POST request to.
  /// @param data The data to be sent with the POST request. This should be a [FormData] object.
  /// @param headers The headers to be sent with the POST request.
  /// @param cancelToken The [CancelToken] to be used to cancel the POST request. If not provided, a new [CancelToken] is created.
  /// @return A [NetworkResponse] object with either a successful response or a failed response.
  Future<NetworkResponse> postAPIResponse(
      String url,
      FormData data,

      /// @return A [NetworkResponse] object with either a successful response or a failed response.
      Map<String, dynamic> headers,
      CancelToken? cancelToken) async {

    try {
      final requestHeaders = headers;
      final response = await _dio.post(
        url,
        data: data,
        cancelToken: cancelToken,
        options: Options(headers: requestHeaders),
      );
      final result = await responseStatus(response);
      if (result.$1 != null) {
        return ResponseSuccess(response: result.$1!);
      }
      return result.$2!;
    } on DioException catch (e) {
      return _handleDioError(e);
    }
  }

  @override
  /// Makes a DELETE request to the specified [url] with [data] and [headers] and returns a [NetworkResponse] object with either a successful response or a failed response.
  ///
  /// If the request is successful, the response is mapped to a tuple of (Response, null) and the successful response is returned. If the request fails, the error is mapped to a tuple of (null, ResponseFail) and the failed response is returned.
  ///
  /// The [CancelToken] can be used to cancel the request at any point of time.
  ///
  /// @param url The URL to make the request to.
  /// @param data The data to be sent with the request. This can be a [Map<String, dynamic>], a [String], or a [FormData].
  /// @param headers The headers to be sent with the request.
  /// @param cancelToken The [CancelToken] to be used to cancel the request. If not provided, a new [CancelToken] is created.
  /// @return A [NetworkResponse] object with either a successful response or a failed response.
  Future<NetworkResponse> delateAPIResponse(String url, dynamic data,
      Map<String, dynamic> headers, CancelToken? cancelToken) async {
    try {
      final requestHeaders = headers;
      final response = await _dio.delete(
        url,
        data: data,
        cancelToken: cancelToken,
        options: Options(headers: requestHeaders),
      );
      final result = await responseStatus(response);
      if (result.$1 != null) {
        return ResponseSuccess(response: result.$1!);
      }
      return result.$2!;
    } on DioException catch (e) {
      return _handleDioError(e);
    }
  }

  /// Maps a response status code to a tuple of (Response?, ResponseFail?).
  ///
  /// - If the status code is 500, returns a tuple of (null, ResponseFail) with type "500" and error message "SERVER NOT RESPONDING".
  /// - If the status code is 404, returns a tuple of (null, ResponseFail) with type "404" and error message "404 Not Found".
  /// - Otherwise, returns a tuple of (Response, null) with the given response.
  Future<(Response? res, ResponseFail? fail)> responseStatus(
      Response response) async {
    switch (response.statusCode) {
      case 500:
        return (
          null,
          ResponseFail(type: '500', message: Exception("SERVER NOT RESPONDING"))
        );
      case 404:
        return (
          null,
          ResponseFail(type: '404', message: Exception("404 Not Found"))
        );
      default:
        return (response, null);
    }
  }

  /// Maps a DioException to a ResponseFail.
  ///
  /// - If the error type is DioExceptionType.connectionTimeout, DioExceptionType.sendTimeout, or DioExceptionType.receiveTimeout, returns a ResponseFail with type "TIMEOUT" and error message "CONNECTION_TIMEOUT".
  /// - If the error type is DioExceptionType.badResponse, returns a ResponseFail with type "404" and error message "404 Not Found" if the response status code is 404, and a ResponseFail with type "STR" and error message "STR_SERVER_NOT_RESPONDING" otherwise.
  /// - If the error type is DioExceptionType.cancel, returns a ResponseFail with type "CANCELLED" and error message "REQUEST_CANCELLED".
  /// - If the error type is DioExceptionType.connectionError, returns a ResponseFail with type "INTERNET_ISSUE" and error message "INTERNET_ISSUE".
  /// - Otherwise, returns a ResponseFail with type "STR" and error message "STR_UNEXPECTED_ERROR".
  ResponseFail _handleDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return ResponseFail(
            message: Exception("CONNECTION_TIMEOUT"), type: "TIMEOUT");
      case DioExceptionType.badResponse:
        if (e.response?.statusCode == 404) {
          return ResponseFail(message: Exception("404 Not Found"), type: "404");
        } else {
          return ResponseFail(
              message: Exception("STR_SERVER_NOT_RESPONDING"), type: "STR");
        }
      case DioExceptionType.cancel:
        return ResponseFail(
            message: Exception("REQUEST_CANCELLED"), type: "CANCELLED");

      case DioExceptionType.connectionError:
        return ResponseFail(
            message: Exception("INTERNET_ISSUE"), type: "INTERNET_ISSUE");

      case DioExceptionType.unknown:
      default:
        return ResponseFail(
            message: Exception("STR_UNEXPECTED_ERROR"), type: "STR");
    }
  }
}
