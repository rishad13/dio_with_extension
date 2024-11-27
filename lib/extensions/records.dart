/// This file contains extension methods for handling network responses using the Dio package.
///
/// The following typedefs are defined:
/// - `ResponseSuccess`: Represents a successful response with a `Response<dynamic>` object.
/// - `ResponseFail`: Represents a failed response with a `String` type and an `Exception` message.
/// - `NetworkResponse`: Represents a network response that can either be successful or failed.
///
/// The following extensions are defined:
///
/// - `InitNetworkExtensions`:
///   - `init`: A getter that initializes a `NetworkResponse` with both `success` and `fail` set to `null`.
///
/// - `NetworkExtensions`:
///   - `setSuccess(ResponseSuccess value)`: Sets the `success` field of the `NetworkResponse` and returns the updated response.
///   - `setFail(ResponseFail value)`: Sets the `fail` field of the `NetworkResponse` and returns the updated response.
library;
import 'package:dio/dio.dart';

typedef ResponseSuccess = ({Response<dynamic> response});
typedef ResponseFail = ({String type, Exception message});
typedef NetworkResponse = ({ResponseSuccess? success, ResponseFail? fail});

extension InitNetworkExtensions on () {
  NetworkResponse get init => (fail: null, success: null);
}

extension NetworkExtensions on NetworkResponse {
/// Sets the `success` field of the `NetworkResponse` with the given [value] and 
/// retains the current `fail` field. Returns the updated `NetworkResponse`.
/// 
/// @param value The successful response to be set in the `NetworkResponse`.
/// @return An updated `NetworkResponse` with the new `success` value.
  NetworkResponse setSuccess(ResponseSuccess value) {
    return (success: value, fail: this.fail);
  }


  /// Sets the `fail` field of the `NetworkResponse` with the given [value] and
  /// retains the current `success` field. Returns the updated `NetworkResponse`.
  ///
  /// @param value The failed response to be set in the `NetworkResponse`.
  /// @return An updated `NetworkResponse` with the new `fail` value.
  NetworkResponse setFail(ResponseFail value) {
    return (success: this.success, fail: value);
  }
}