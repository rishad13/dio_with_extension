import 'package:dio/dio.dart';
import '../../extensions/records.dart';

abstract class BaseApiServices {
  /// Sends a GET request to the specified URL with the given headers and token.
  ///
  /// The [cancelToken] parameter can be used to cancel the request if needed.
  /// If a token is found in the shared preferences, it is added to the request headers as an
  /// 'Authorization' header with the value 'Bearer <token>'.
  /// The response is handled by the [responseStatus] method.
  /// If the response is successful, the method returns a [NetworkResponse] with the response
  /// data. If the response fails, the method returns a [NetworkResponse] with the error data.
  Future<NetworkResponse> getAPIResponse(
      String url, Map<String, dynamic> headers, CancelToken? cancelToken);

  /// Sends a POST request to the specified [url] with the given [data] and [headers].
  ///
  /// The [cancelToken] parameter can be used to cancel the request if needed.
  /// If a token is found in the shared preferences, it is added to the request headers as an
  /// 'Authorization' header with the value 'Bearer <token>'.
  /// The response is handled by the [responseStatus] method.
  /// If the response is successful, the method returns a [NetworkResponse] with the response
  /// data. If the response fails, the method returns a [NetworkResponse] with the error data.
  Future<NetworkResponse> postAPIResponse(String url, FormData data,
      Map<String, dynamic> headers, CancelToken? cancelToken);

  /// Sends a PUT request to the specified URL with the given data and headers.
  ///
  /// The [cancelToken] parameter can be used to cancel the request if needed.
  /// If a token is found in the shared preferences, it is added to the request headers as an
  /// 'Authorization' header with the value 'Bearer <token>'.
  /// The response is handled by the [responseStatus] method.
  /// If the response is successful, the method returns a [NetworkResponse] with the response
  /// data. If the response fails, the method returns a [NetworkResponse] with the error data.
  Future<NetworkResponse> putAPIResponse(String url, FormData data,
      Map<String, dynamic> headers, CancelToken? cancelToken);

  /// Sends a DELETE request to the specified [url] with the given [data] and [headers].
  ///
  /// This method uses the Dio package to send a DELETE request to the provided [url].
  /// The [data] parameter contains any data to be sent in the request body.
  /// The [headers] parameter contains any additional headers to be included in the request.
  /// The [cancelToken] parameter can be used to cancel the request if needed.
  /// If a token is found in the shared preferences, it is added to the request headers as an
  /// 'Authorization' header with the value 'Bearer <token>'.
  /// The response is handled by the [responseStatus] method.
  /// If the response is successful, the method returns a [NetworkResponse] with the response
  /// data. If the response fails, the method returns a [NetworkResponse] with the error data.
  Future<NetworkResponse> delateAPIResponse(String url, FormData data,
      Map<String, dynamic> headers, CancelToken? cancelToken);
}
