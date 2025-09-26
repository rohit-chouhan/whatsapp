import 'dart:convert';

import 'package:whatsapp/utils/exception.dart';
import 'package:whatsapp/utils/request.dart';
import 'package:whatsapp/utils/response/whatsapp_blocked_users_response.dart';
import 'package:whatsapp/utils/response/whatsapp_get_blocked_users_response.dart';
import 'package:http/http.dart' as http;
import 'package:whatsapp/utils/response/whatsapp_success_response.dart';

/// A service for managing WhatsApp account-related operations such as
/// registration, blocking, and unblocking users.
class AccountService {
  /// The access token for WhatsApp Cloud API authentication.
  final String accessToken;

  /// The phone number ID used as the sender in API requests.
  final String fromNumberId;

  /// The request utility for making HTTP calls.
  final Request request;

  /// Creates an instance of [AccountService].
  ///
  /// [accessToken] The access token for authentication.
  /// [fromNumberId] The sender phone number ID.
  /// [request] The request utility instance.
  AccountService(this.accessToken, this.fromNumberId, this.request);

  /// Registers the number for use with Cloud API after performing backup.
  ///
  /// [digitPin] The digits PIN for the number.
  /// [password] The password for the number.
  /// [backupData] The backup data for the number.
  ///
  /// Returns a [WhatsAppSuccessResponse] indicating whether the registration was successful.
  Future<WhatsAppSuccessResponse> accountMigrationRegister(
      String digitPin, String password, String backupData) async {
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };

    final Map<String, dynamic> body = {
      "messaging_product": "whatsapp",
      "pin": digitPin,
      "backup": {"password": password, "data": backupData}
    };

    var url = '$fromNumberId/register';
    try {
      final http.Response response =
          await request.postWithResponse(url, headers, body);

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseBody = jsonDecode(response.body);
        final WhatsAppSuccessResponse parsedResponse =
            WhatsAppSuccessResponse.fromJson(responseBody);
        return parsedResponse;
      } else {
        // Throw a more specific exception using the factory constructor
        throw WhatsAppException.fromResponse(response);
      }
    } on FormatException catch (e) {
      // Handle JSON decoding errors specifically
      throw JsonFormatException('Failed to parse JSON response: $e');
    } on http.ClientException catch (e) {
      // Handle network-related errors (e.g., no internet, timeout)
      throw NetworkException('Network error: $e');
    } on WhatsAppException {
      // Re-throw WhatsApp-specific exceptions.
      rethrow;
    } catch (e) {
      // Handle any other unexpected exceptions.
      throw WhatsAppException('An unexpected error occurred: $e');
    }
  }

  /// Blocks users by their phone numbers.
  ///
  /// [users] List of phone numbers with country code to be blocked.
  ///
  /// Returns a [WhatsAppBlockedUsersResponse] containing the result of the block operation.
  Future<WhatsAppBlockedUsersResponse> blockUsers(List<String>? users) async {
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

    var url = '$fromNumberId/block_users';
    try {
      final http.Response response =
          await request.postWithResponse(url, headers, body);

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseBody = jsonDecode(response.body);
        final WhatsAppBlockedUsersResponse parsedResponse =
            WhatsAppBlockedUsersResponse.fromJson(responseBody);
        return parsedResponse;
      } else {
        // Throw a more specific exception using the factory constructor
        throw WhatsAppException.fromResponse(response);
      }
    } on FormatException catch (e) {
      // Handle JSON decoding errors specifically
      throw JsonFormatException('Failed to parse JSON response: $e');
    } on http.ClientException catch (e) {
      // Handle network-related errors (e.g., no internet, timeout)
      throw NetworkException('Network error: $e');
    } on WhatsAppException {
      // Re-throw WhatsApp-specific exceptions.
      rethrow;
    } catch (e) {
      // Handle any other unexpected exceptions.
      throw WhatsAppException('An unexpected error occurred: $e');
    }
  }

  /// Unblocks users by their phone numbers.
  ///
  /// [users] List of phone numbers with country code to be unblocked.
  ///
  /// Returns a [WhatsAppBlockedUsersResponse] containing the result of the unblock operation.
  Future<WhatsAppBlockedUsersResponse> unblockUsers(List<String>? users) async {
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };
    var unblockUsers = users
        ?.map((user) => {
              "user": user,
            })
        .toList();
    final Map<String, dynamic> body = {
      "messaging_product": "whatsapp",
      "unblock_users": unblockUsers
    };
    print('DEBUG: unblockUsers payload: $body');

    var url = '$fromNumberId/block_users';
    try {
      final http.Response response =
          await request.deleteWithResponse(url, headers, body);

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseBody = jsonDecode(response.body);
        final WhatsAppBlockedUsersResponse parsedResponse =
            WhatsAppBlockedUsersResponse.fromJson(responseBody);
        return parsedResponse;
      } else {
        // Throw a more specific exception using the factory constructor
        throw WhatsAppException.fromResponse(response);
      }
    } on FormatException catch (e) {
      // Handle JSON decoding errors specifically
      throw JsonFormatException('Failed to parse JSON response: $e');
    } on http.ClientException catch (e) {
      // Handle network-related errors (e.g., no internet, timeout)
      throw NetworkException('Network error: $e');
    } on WhatsAppException {
      // Re-throw WhatsApp-specific exceptions.
      rethrow;
    } catch (e) {
      // Handle any other unexpected exceptions.
      throw WhatsAppException('An unexpected error occurred: $e');
    }
  }

  /// Gets the list of blocked users.
  ///
  /// [limit] The maximum number of blocked users to return (optional).
  /// [before] A cursor for pagination to get the previous page of results (optional).
  /// [after] A cursor for pagination to get the next page of results (optional).
  ///
  /// Returns a [WhatsAppGetBlockedUsersResponse] containing the list of blocked users and pagination cursors.
  Future<WhatsAppGetBlockedUsersResponse> getBlockedUsers(
      int? limit, String? before, String? after) async {
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };

    var url = '$fromNumberId/block_users';

    List<String> queryParams = [];

    if (limit != null && limit != 0) {
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
        final WhatsAppGetBlockedUsersResponse parsedResponse =
            WhatsAppGetBlockedUsersResponse.fromJson(responseBody);
        return parsedResponse;
      } else {
        throw WhatsAppException.fromResponse(response);
      }
    } on FormatException catch (e) {
      // Handle JSON decoding errors specifically
      throw JsonFormatException('Failed to parse JSON response: $e');
    } on http.ClientException catch (e) {
      // Handle network-related errors (e.g., no internet, timeout)
      throw NetworkException('Network error: $e');
    } on WhatsAppException {
      // Re-throw WhatsApp-specific exceptions.
      rethrow;
    } catch (e) {
      // Handle any other unexpected exceptions.
      throw WhatsAppException('An unexpected error occurred: $e');
    }
  }
}
