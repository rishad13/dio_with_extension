class AppException implements Exception {
  final String _message;
  final String _prefix;
  AppException(this._message, this._prefix);

  @override
  /// Converts the exception to a human-readable string.
  ///
  /// The resulting string is in the format of "$_prefix $_message".
  ///
  /// This is primarily used for debugging purposes, and should not be used
  /// directly in production code.
  String toString() {
    return '$_prefix $_message';
  }
}