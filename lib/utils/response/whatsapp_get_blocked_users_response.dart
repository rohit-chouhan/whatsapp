import 'whatsapp_base_response.dart';

class WhatsAppGetBlockedUsersResponse extends WhatsAppBaseResponse {
  final List<String> _users;
  final String _cursorBefore;
  final String _cursorAfter;

  WhatsAppGetBlockedUsersResponse(
      {required List<String> users,
      required String cursorBefore,
      required String cursorAfter,
      required Map<String, dynamic> fullResponse})
      : _users = users,
        _cursorBefore = cursorBefore,
        _cursorAfter = cursorAfter,
        super(fullResponse);

  // Factory constructor to create an instance from JSON
  factory WhatsAppGetBlockedUsersResponse.fromJson(Map<String, dynamic> json) {
    final List<dynamic>? usersJson = json['data'];
    final List<String> users =
        usersJson?.map((item) => item['wa_id'].toString()).toList() ?? [];

    final String cursorBefore = json['paging']?['cursors']?['before'] ?? '';
    final String cursorAfter = json['paging']?['cursors']?['after'] ?? '';

    final Map<String, dynamic> fullResponse = json;

    return WhatsAppGetBlockedUsersResponse(
        users: users,
        cursorBefore: cursorBefore,
        cursorAfter: cursorAfter,
        fullResponse: fullResponse);
  }

  @override
  bool isSuccess() => getFullResponse()['error'] == null;

  // Public methods to access the private fields
  List<String> getUsersList() {
    return _users;
  }

  String getCursorBefore() {
    return _cursorBefore;
  }

  String getCursorAfter() {
    return _cursorAfter;
  }
}
