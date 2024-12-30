import 'package:dio/dio.dart';

/// Abstract sealed class representing a network response.
sealed class NetworkResponse {
  /// Returns a value of type [T] based on whether the response was successful or not.
  ///
  /// If the response was successful, the [onSuccess] function is called with the
  /// [ResponseSuccess] object as argument, and its return value is returned.
  ///
  /// If the response failed, the [onFail] function is called with the
  /// [ResponseFail] object as argument, and its return value is returned.
  T match<T>({
    required T Function(ResponseSuccess success) onSuccess,
    required T Function(ResponseFail fail) onFail,
  }) {
    return switch (this) {
      ResponseSuccess success => onSuccess(success),
      ResponseFail fail => onFail(fail),
    };
  }
}

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
