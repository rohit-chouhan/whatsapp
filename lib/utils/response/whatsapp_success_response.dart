import 'whatsapp_base_response.dart';

class WhatsAppSuccessResponse extends WhatsAppBaseResponse {
  final bool _success;

  /// Creates a [WhatsAppSuccessResponse] instance.
  ///
  /// This constructor is used to initialize the response object with the
  /// success status and the complete API response.
  WhatsAppSuccessResponse({
    required bool success,
    required Map<String, dynamic> fullResponse,
  })  : _success = success,
        super(fullResponse);

  /// Factory constructor to create a [WhatsAppSuccessResponse] from a JSON map.
  ///
  /// It parses the JSON received from the WhatsApp API, extracting the
  /// success status.
  factory WhatsAppSuccessResponse.fromJson(Map<String, dynamic> json) {
    final bool success = json['success'] ?? false;

    final Map<String, dynamic> fullResponse = json;

    return WhatsAppSuccessResponse(
        success: success, fullResponse: fullResponse);
  }

  /// Checks if the operation was successful.
  ///
  /// Returns `true` if the operation was successful.
  @override
  bool isSuccess() {
    return _success == true;
  }
}
