import 'dart:convert';

import 'package:whatsapp/utils/exception.dart';
import 'package:whatsapp/utils/request.dart';
import 'package:whatsapp/utils/response/blocked_users_response.dart';
import 'package:http/http.dart' as http;

class AccountService {
  final String accessToken;
  final String fromNumberId;
  final Request request;

  AccountService(this.accessToken, this.fromNumberId, this.request);

  Future<Request> accountMigrationRegister(
      digitPin, password, backupData) async {
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };

    final Map<String, dynamic> body = {
      "messaging_product": "whatsapp",
      "pin": digitPin,
      "backup": {"password": password, "data": backupData}
    };

    await request.post('$fromNumberId/register', headers, body);
    return request;
  }

  Future<Request> blockUsers(List<String>? users) async {
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };
    var blockUsers = users
        ?.map((user) => {
              "user": user,
            })
        .toList();
    final Map<String, dynamic> body = {
      "messaging_product": "whatsapp",
      "block_users": blockUsers
    };

    await request.post('$fromNumberId/block_users', headers, body);
    return request;
  }

  Future<Request> unblockUsers(List<String>? users) async {
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };
    var blockUsers = users
        ?.map((user) => {
              "user": user,
            })
        .toList();
    final Map<String, dynamic> body = {
      "messaging_product": "whatsapp",
      "block_users": blockUsers
    };

    await request.delete('$fromNumberId/block_users', headers, body);
    return request;
  }

  Future<BlockedUsersResponse> getBlockedUsers(
      int? limit, String? before, String? after) async {
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };

    var url = '$fromNumberId/block_users';

    List<String> queryParams = [];

    if (limit != 0) {
      queryParams.add('limit=$limit');
    }
    if (before != null && before.isNotEmpty) {
      queryParams.add('before=$before');
    }
    if (after != null && after.isNotEmpty) {
      queryParams.add('after=$after');
    }

    if (queryParams.isNotEmpty) {
      url = '$url?${queryParams.join('&')}';
    }

    try {
      final http.Response response =
          await request.getWithResponse(url, headers);

      if (response.statusCode == 200) {
        // Here's where you parse the data explicitly
        final Map<String, dynamic> responseBody = jsonDecode(response.body);
        final BlockedUsersResponse parsedResponse =
            BlockedUsersResponse.fromJson(responseBody);
        return parsedResponse;
      } else {
        throw WhatsAppException(
            'Failed to fetch blocked users: ${response.statusCode}');
      }
    } catch (e) {
      // Handle network or parsing errors
      throw WhatsAppException('An error occurred: $e');
    }
  }
}
