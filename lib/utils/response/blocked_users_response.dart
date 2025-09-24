class BlockedUsersResponse {
  final List<String> _users;
  final String _cursorBefore;
  final String _cursorAfter;

  BlockedUsersResponse({
    required List<String> users,
    required String cursorBefore,
    required String cursorAfter,
  })  : _users = users,
        _cursorBefore = cursorBefore,
        _cursorAfter = cursorAfter;

  // Factory constructor to create an instance from JSON
  factory BlockedUsersResponse.fromJson(Map<String, dynamic> json) {
    final List<dynamic>? usersJson = json['data'];
    final List<String> users =
        usersJson?.map((item) => item['wa_id'].toString()).toList() ?? [];

    final String cursorBefore = json['paging']?['cursors']?['before'] ?? '';
    final String cursorAfter = json['paging']?['cursors']?['after'] ?? '';

    return BlockedUsersResponse(
      users: users,
      cursorBefore: cursorBefore,
      cursorAfter: cursorAfter,
    );
  }

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
