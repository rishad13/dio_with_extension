import '../../exception/exception.dart';

class FetchDataException extends AppException {
  FetchDataException([String? message]) : super(message!, "NetworkApiService");
}
