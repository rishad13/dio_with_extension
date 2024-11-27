import 'dart:developer';
import 'package:dio/dio.dart';

var dioObserver = InterceptorsWrapper(
  onRequest: (options, handler) {
    log('REQUEST[${options.method}] => PATH: ${options.path} => REQUEST HEADERS: ${options.headers}');
    if (options.data != null) {
      log('REQUEST BODY: ${options.data}');
    }
    return handler.next(options);
  },
  onResponse: (response, handler) {
    log('RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path} => RESPONSE: ${response.data}');
    return handler.next(response);
  },
  onError: (DioException e, handler) {
    log('ERROR[${e.response?.statusCode}] => PATH: ${e.requestOptions.path}',
        error: e.error, stackTrace: e.stackTrace);
    return handler.next(e);
  },
);
