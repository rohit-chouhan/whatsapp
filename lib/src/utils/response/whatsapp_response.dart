import 'whatsapp_base_response.dart';

class WhatsAppResponse extends WhatsAppBaseResponse {
  final String _contactId;
  final String _messageId;

  /// Creates a [WhatsAppResponse] instance.
  ///
  /// This constructor is used to initialize the response object with the
  /// contact and message IDs, as well as the complete API response.
  WhatsAppResponse({
    required String contactId,
    required String messageId,
    required Map<String, dynamic> fullResponse,
  })  : _contactId = contactId,
        _messageId = messageId,
        super(fullResponse);

  /// Factory constructor to create a [WhatsAppResponse] from a JSON map.
  ///
  /// It parses the JSON received from the WhatsApp API, extracting the
  /// contact and message IDs.
  factory WhatsAppResponse.fromJson(Map<String, dynamic> json) {
    final List<dynamic>? contactsJson = json['contacts'];
    final String contactId = contactsJson != null && contactsJson.isNotEmpty
        ? contactsJson[0]['wa_id'].toString()
        : '';

    final List<dynamic>? messagesJson = json['messages'];
    final String messageId = messagesJson != null && messagesJson.isNotEmpty
        ? messagesJson[0]['id'].toString()
        : '';

    final Map<String, dynamic> fullResponse = json;

    return WhatsAppResponse(
      contactId: contactId,
      messageId: messageId,
      fullResponse: fullResponse,
    );
  }

  /// Gets the WhatsApp ID of the recipient contact.
  ///
  /// This ID is retrieved from the `contacts` array in the API response.
  String getContactId() {
    return _contactId;
  }

  /// Gets the unique ID of the sent message.
  ///
  /// This ID is retrieved from the `messages` array in the API response.
  String getMessageId() {
    return _messageId;
  }

  /// Checks if the message was successfully sent.
  ///
  /// Success is determined by the presence of both a contact ID and a message ID.
  @override
  bool isSuccess() {
    return _messageId.isNotEmpty && _contactId.isNotEmpty;
  }
}
