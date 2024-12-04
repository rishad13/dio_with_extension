import 'package:dio/dio.dart';

/// Abstract sealed class representing a network response.
sealed class NetworkResponse {}

/// A subclass representing a successful network response.
class ResponseSuccess extends NetworkResponse {
  final Response<dynamic> response;

  ResponseSuccess({required this.response});
}

/// A subclass representing a failed network response.
class ResponseFail extends NetworkResponse {
  final String type;
  final Exception message;

  ResponseFail({required this.type, required this.message});
}

/// Extension methods for handling network responses.
extension NetworkResponseExtensions on NetworkResponse {
  /// Maps the current `NetworkResponse` to a specific handler.
  T when<T>({
    required T Function(ResponseSuccess success) onSuccess,
    required T Function(ResponseFail fail) onFail,
  }) {
    if (this is ResponseSuccess) {
      return onSuccess(this as ResponseSuccess);
    } else if (this is ResponseFail) {
      return onFail(this as ResponseFail);
    } else {
      throw Exception('Unhandled network response type');
    }
  }
}
