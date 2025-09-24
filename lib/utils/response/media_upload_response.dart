class MediaUploadResponse {
  final String _mediaId;
  final Map<String, dynamic> _fullResponse;

  /// Creates a [WhatsAppResponse] instance.
  ///
  /// This constructor is used to initialize the response object with the
  /// contact and message IDs, as well as the complete API response.
  MediaUploadResponse({
    required String mediaId,
    required Map<String, dynamic> fullResponse,
  })  : _mediaId = mediaId,
        _fullResponse = fullResponse;

  /// Factory constructor to create a [MediaUploadResponse] from a JSON map.
  ///
  /// It parses the JSON received from the WhatsApp API, extracting the
  /// contact and message IDs.
  factory MediaUploadResponse.fromJson(Map<String, dynamic> json) {
    final String mediaId = json['id'];

    final Map<String, dynamic> fullResponse = json;

    return MediaUploadResponse(mediaId: mediaId, fullResponse: fullResponse);
  }

  /// Gets the WhatsApp ID of the uploaded image.
  ///
  /// This ID is retrieved from the upload media API response.
  String getMediaId() {
    return _mediaId;
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
  bool isUploaded() {
    return _mediaId.isNotEmpty;
  }

  /// Retrieves a descriptive error message if the operation failed.
  ///
  /// It parses the `error` field from the full response to return a
  /// human-readable message, or a generic message if no error is found.
  String getErrorMessage() {
    if (isUploaded()) {
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
    if (isUploaded()) {
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
    if (isUploaded()) {
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
