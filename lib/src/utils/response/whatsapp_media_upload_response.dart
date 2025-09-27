import 'whatsapp_base_response.dart';

class WhatsAppMediaUploadResponse extends WhatsAppBaseResponse {
  final String _mediaId;

  /// Creates a [WhatsAppMediaUploadResponse] instance.
  ///
  /// This constructor is used to initialize the response object with the
  /// media ID and the complete API response.
  WhatsAppMediaUploadResponse({
    required String mediaId,
    required Map<String, dynamic> fullResponse,
  })  : _mediaId = mediaId,
        super(fullResponse);

  /// Factory constructor to create a [WhatsAppMediaUploadResponse] from a JSON map.
  ///
  /// It parses the JSON received from the WhatsApp API, extracting the
  /// media ID.
  factory WhatsAppMediaUploadResponse.fromJson(Map<String, dynamic> json) {
    final String mediaId = json['id'] ?? '';

    final Map<String, dynamic> fullResponse = json;

    return WhatsAppMediaUploadResponse(
        mediaId: mediaId, fullResponse: fullResponse);
  }

  /// Gets the WhatsApp ID of the uploaded image.
  ///
  /// This ID is retrieved from the upload media API response.
  String getMediaId() {
    return _mediaId;
  }

  /// Checks if the media was uploaded successfully.
  ///
  /// Returns `true` if media uploaded successfully.
  @override
  bool isSuccess() {
    return _mediaId.isNotEmpty;
  }

  /// Checks if the media was uploaded successfully.
  ///
  /// Returns `true` if media uploaded successfully.
  /// Deprecated: Use isSuccess() instead.
  @Deprecated('Use isSuccess() instead.')
  bool isUploaded() {
    return isSuccess();
  }
}
