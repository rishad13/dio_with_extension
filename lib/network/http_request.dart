import 'dart:async';
import '../extensions/records.dart';
import 'package:dio/dio.dart';

import '../observers/dio_observer.dart';
import 'parts_and_exceptions/base_api_services.dart';


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
  /// @param url The URL to make the request to.
  /// @param headers The headers to be sent with the request.
  /// @param cancelToken The [CancelToken] to be used to cancel the request. If not provided, a new [CancelToken] is created.
  /// @return A [NetworkResponse] object with either a successful response or a failed response.
  Future<NetworkResponse> getAPIResponse(String url,
      Map<String, dynamic> headers, CancelToken? cancelToken) async {
    final networkResponse = ().init;
    try {
      Map<String, dynamic> requestHeaders = headers.isNotEmpty ? headers : {};
      final response = await _dio.get(
        url,
        cancelToken: cancelToken,
        options: Options(headers: requestHeaders),
      );
      final result = await responseStatus(response);
      if (result.$1 != null) {
        return networkResponse.setSuccess((response: result.$1!));
      }
      return networkResponse.setFail(result.$2!);
    } on DioException catch (e) {
      return networkResponse.setFail(_handleDioError(e));
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
    final networkResponse = ().init;

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
        return networkResponse.setSuccess((response: result.$1!));
      }
      return networkResponse.setFail(result.$2!);
    } on DioException catch (e) {
      return networkResponse.setFail(_handleDioError(e));
    }
  }

  @override
  /// Makes a POST request to the specified [url] with [data] and [headers] and returns a [NetworkResponse] object with either a successful response or a failed response.
  ///
  /// If the request is successful, the response is mapped to a tuple of (Response, null) and the successful response is returned. If the request fails, the error is mapped to a tuple of (null, ResponseFail) and the failed response is returned.
  ///
  /// The [CancelToken] can be used to cancel the request at any point of time.
  ///
  /// @param url The URL to make the request to.
  /// @param data The data to be sent with the request. This can be a [Map<String, dynamic>], a [String], or a [FormData].
  /// @param headers The headers to be sent with the request.
  /// @param cancelToken The [CancelToken] to be used to cancel the request. If not provided, a new [CancelToken] is created.
  Future<NetworkResponse> postAPIResponse(String url, FormData data,
  /// @return A [NetworkResponse] object with either a successful response or a failed response.
      Map<String, dynamic> headers, CancelToken? cancelToken) async {
    final networkResponse = ().init;

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
        return networkResponse.setSuccess((response: result.$1!));
      }
      return networkResponse.setFail(result.$2!);
    } on DioException catch (e) {
      return networkResponse.setFail(_handleDioError(e));
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
    final networkResponse = ().init;

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
        return networkResponse.setSuccess((response: result.$1!));
      }
      return networkResponse.setFail(result.$2!);
    } on DioException catch (e) {
      return networkResponse.setFail(_handleDioError(e));
    }
  }

  /// Maps a Dio response to a tuple of (Response, ResponseFail) depending on the status code.
  ///
  /// - If the status code is 500, returns a null response and a ResponseFail with type '500' and error message "SERVER NOT RESPONDING".
  /// - If the status code is 404, returns a null response and a ResponseFail with type '404' and error message "404 Not Found".
  /// - Otherwise, returns the response and null.
  Future<(Response? res, ResponseFail? fail)> responseStatus(
      Response response) async {
    switch (response.statusCode) {
      case 500:
        return (
          null,
          (type: '500', message: Exception("SERVER NOT RESPONDING"))
        );
      case 404:
        return (null, (type: '404', message: Exception("404 Not Found")));
      default:
        return (response, null);
    }
  }

  /// Handles Dio exceptions and maps them to a `ResponseFail` object with appropriate error messages and types.
  ///
  /// This method takes a `DioException` and returns a `ResponseFail` object
  /// containing an error message and a type based on the type of Dio exception.
  ///
  /// The mapping is as follows:
  /// - `DioExceptionType.connectionTimeout`, `DioExceptionType.sendTimeout`, `DioExceptionType.receiveTimeout`:
  ///   Returns a timeout error with the message "CONNECTION_TIMEOUT" and type "TIMEOUT".
  /// - `DioExceptionType.badResponse`:
  ///   If the status code is 404, returns a not found error with the message "404 Not Found" and type "404".
  ///   Otherwise, returns a server not responding error with the message "STR_SERVER_NOT_RESPONDING" and type "STR".
  /// - `DioExceptionType.cancel`:
  ///   Returns a request cancelled error with the message "REQUEST_CANCELLED" and type "CANCELLED".
  /// - `DioExceptionType.connectionError`:
  ///   Returns an internet issue error with the message "INTERNET_ISSUE" and type "INTERNET_ISSUE".
  /// - `DioExceptionType.unknown` and any other types:
  ///   Returns an unexpected error with the message "STR_UNEXPECTED_ERROR" and type "STR".
  ///
  /// @param e The `DioException` to handle.
  /// @return A `ResponseFail` object containing the error message and type.
  ResponseFail _handleDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return (message: Exception("CONNECTION_TIMEOUT"), type: "TIMEOUT");
      case DioExceptionType.badResponse:
        if (e.response?.statusCode == 404) {
          return (message: Exception("404 Not Found"), type: "404");
        } else {
          return (message: Exception("STR_SERVER_NOT_RESPONDING"), type: "STR");
        }
      case DioExceptionType.cancel:
        return (message: Exception("REQUEST_CANCELLED"), type: "CANCELLED");

      case DioExceptionType.connectionError:
        return (message: Exception("INTERNET_ISSUE"), type: "INTERNET_ISSUE");

      case DioExceptionType.unknown:
      default:
        return (message: Exception("STR_UNEXPECTED_ERROR"), type: "STR");
    }
  }
}