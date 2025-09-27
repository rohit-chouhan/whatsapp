import 'whatsapp_base_response.dart';

class WhatsAppMediaDeleteResponse extends WhatsAppBaseResponse {
  final bool _success;

  /// Creates a [WhatsAppMediaDeleteResponse] instance.
  ///
  /// This constructor is used to initialize the response object with the
  /// success status and the complete API response.
  WhatsAppMediaDeleteResponse({
    required bool success,
    required Map<String, dynamic> fullResponse,
  })  : _success = success,
        super(fullResponse);

  /// Factory constructor to create a [WhatsAppMediaDeleteResponse] from a JSON map.
  ///
  /// It parses the JSON received from the WhatsApp API, extracting the
  /// success status.
  factory WhatsAppMediaDeleteResponse.fromJson(Map<String, dynamic> json) {
    final bool success = json['success'] ?? false;

    final Map<String, dynamic> fullResponse = json;

    return WhatsAppMediaDeleteResponse(
        success: success, fullResponse: fullResponse);
  }

  /// Checks if the media was deleted successfully.
  ///
  /// Returns `true` if media deleted successfully.
  @override
  bool isSuccess() {
    return _success == true;
  }

  /// Checks if the media was deleted successfully.
  ///
  /// Returns `true` if media deleted successfully.
  /// Deprecated: Use isSuccess() instead.
  @Deprecated('Use isSuccess() instead.')
  bool isDeleted() {
    return isSuccess();
  }
}
