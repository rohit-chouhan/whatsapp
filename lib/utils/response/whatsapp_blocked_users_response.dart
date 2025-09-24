import 'whatsapp_base_response.dart';

class WhatsAppBlockedUsersResponse extends WhatsAppBaseResponse {
  /// Creates a [WhatsAppBlockedUsersResponse] instance.
  ///
  /// This constructor is used to initialize the response object with the
  /// complete API response.
  WhatsAppBlockedUsersResponse({
    required Map<String, dynamic> fullResponse,
  }) : super(fullResponse);

  /// Factory constructor to create a [WhatsAppBlockedUsersResponse] from a JSON map.
  ///
  /// It parses the JSON received from the WhatsApp API, extracting the
  /// blocked users information.
  factory WhatsAppBlockedUsersResponse.fromJson(Map<String, dynamic> json) {
    final Map<String, dynamic> fullResponse = json;

    return WhatsAppBlockedUsersResponse(fullResponse: fullResponse);
  }

  /// Checks if users were successfully blocked or unblocked.
  ///
  /// Returns `true` if at least one user was added to or removed from the blocked list.
  @override
  bool isSuccess() {
    final response = getFullResponse();
    if (response.containsKey('error')) return false;
    final blockUsers = response['block_users'];
    if (blockUsers == null) return false;
    final added = (blockUsers['added_users']?.length ?? 0) > 0;
    final removed = (blockUsers['removed_users']?.length ?? 0) > 0;
    return added || removed;
  }

  /// Checks if some users were blocked (partial success).
  ///
  /// Returns `true` if there are failed users, indicating partial success.
  bool isSomeSuccess() {
    return getFullResponse()['block_users']?['failed_users']?.length > 0 ??
        false;
  }
}
