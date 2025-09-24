class WhatsAppResponse {
  final String _contactId;
  final String _messageId;
  final Map<String, dynamic> _fullResponse;

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
        _fullResponse = fullResponse;

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

  /// Gets the complete, raw JSON response from the API.
  ///
  /// This can be useful for debugging or accessing other data not
  /// directly exposed by this class's properties.
  Map<String, dynamic> getFullResponse() {
    return _fullResponse;
  }

  /// Checks if the message was successfully sent.
  ///
  /// Success is determined by the presence of both a contact ID and a message ID.
  bool isSuccess() {
    return _messageId.isNotEmpty && _contactId.isNotEmpty;
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
