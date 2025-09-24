class MediaGetResponse {
  final String _id;
  final String _url;
  final String _mimeType;
  final String _sha256;
  final int _fileSize;
  final Map<String, dynamic> _fullResponse;

  /// Creates a [WhatsAppResponse] instance.
  ///
  /// This constructor is used to initialize the response object with the
  MediaGetResponse({
    required String id,
    required String url,
    required String mimeType,
    required String sha256,
    required int fileSize,
    required Map<String, dynamic> fullResponse,
  })  : _id = id,
        _url = url,
        _mimeType = mimeType,
        _sha256 = sha256,
        _fileSize = fileSize,
        _fullResponse = fullResponse;

  /// Factory constructor to create a [MediaUploadResponse] from a JSON map.
  ///
  /// It parses the JSON received from the WhatsApp API, extracting the
  /// contact and message IDs.
  factory MediaGetResponse.fromJson(Map<String, dynamic> json) {
    final String id = json['id'];
    final String url = json['url'];
    final String mimeType = json['mime_type'];
    final String sha256 = json['sha256'];
    final int fileSize = json['file_size'];

    final Map<String, dynamic> fullResponse = json;

    return MediaGetResponse(
        id: id,
        url: url,
        mimeType: mimeType,
        sha256: sha256,
        fileSize: fileSize,
        fullResponse: fullResponse);
  }

  /// Gets the WhatsApp ID of the uploaded image.
  ///
  /// This ID is retrieved from the upload media API response.
  String getMediaId() {
    return _id;
  }

  /// Get ful url of image
  String getMediaUrl() {
    return _url;
  }

  String getMediaMimeType() {
    return _mimeType;
  }

  String getMediaSha256() {
    return _sha256;
  }

  int getMediaFileSize() {
    return _fileSize;
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
  bool isSuccess() {
    return _id.isNotEmpty;
  }

  /// Retrieves a descriptive error message if the operation failed.
  ///
  /// It parses the `error` field from the full response to return a
  /// human-readable message, or a generic message if no error is found.
  String getErrorMessage() {
    if (isSuccess()) {
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
    if (isSuccess()) {
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
    if (isSuccess()) {
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
