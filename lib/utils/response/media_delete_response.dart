class MediaDeleteResponse {
  final bool _success;
  final Map<String, dynamic> _fullResponse;

  /// Creates a [WhatsAppResponse] instance.
  ///
  /// This constructor is used to initialize the response object with the
  MediaDeleteResponse({
    required bool success,
    required Map<String, dynamic> fullResponse,
  })  : _success = success,
        _fullResponse = fullResponse;

  /// Factory constructor to create a [MediaUploadResponse] from a JSON map.
  ///
  /// It parses the JSON received from the WhatsApp API, extracting the
  /// contact and message IDs.
  factory MediaDeleteResponse.fromJson(Map<String, dynamic> json) {
    final bool success = json['success'];

    final Map<String, dynamic> fullResponse = json;

    return MediaDeleteResponse(success: success, fullResponse: fullResponse);
  }

  /// Gets the complete, raw JSON response from the API.
  ///
  /// This can be useful for debugging or accessing other data not
  /// directly exposed by this class's properties.
  Map<String, dynamic> getFullResponse() {
    return _fullResponse;
  }

  /// Checks if the media was uploaded successfully .
  ///
  /// return `True` if media uploaded successfully.
  bool isDeleted() {
    return (_success == true);
  }

  /// Retrieves a descriptive error message if the operation failed.
  ///
  /// It parses the `error` field from the full response to return a
  /// human-readable message, or a generic message if no error is found.
  String getErrorMessage() {
    if (isDeleted()) {
      return '';
    }

    final errorsJson = _fullResponse['error'];
    if (errorsJson != null && errorsJson is Map) {
      final message = errorsJson['message'] as String? ?? 'Unknown error';
      return message;
    }

    // Return a generic error message if no specific error is found.
    return 'Unknown error occurred.';
  }

  /// Gets the numeric error code from a failed operation.
  ///
  /// It returns the `code` field from the `error` object in the API response,
  /// or 0 if the operation was successful.
  int? getErrorCode() {
    if (isDeleted()) {
      return 0;
    }

    final errorsJson = _fullResponse['error'];
    if (errorsJson != null && errorsJson is Map) {
      final code = errorsJson['code'] as int?;
      return code;
    }

    // Return a generic error code if no specific error is found.
    return 0;
  }

  /// Gets the type of error from a failed operation.
  ///
  /// It returns the `type` field from the `error` object in the API response,
  /// or an empty string if the operation was successful.
  String? getErrorType() {
    if (isDeleted()) {
      return '';
    }

    final errorsJson = _fullResponse['error'];
    if (errorsJson != null && errorsJson is Map) {
      final type = errorsJson['type'] as String?;
      return type;
    }

    // Return a generic error type if no specific error is found.
    return 'Unknown error type.';
  }
}
