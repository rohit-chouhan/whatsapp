import 'package:whatsapp/src/services/base_service.dart';
import '../utils/response/responses.dart';

/// A service for managing WhatsApp account-related operations such as
/// registration, blocking, and unblocking users.
class AccountService extends BaseService {
  /// Creates an instance of [AccountService].
  ///
  /// [accessToken] The access token for authentication.
  /// [fromNumberId] The sender phone number ID.
  /// [request] The request utility instance.
  AccountService(super.accessToken, super.fromNumberId, super.request);

  /// Registers the number for use with Cloud API after performing backup.
  ///
  /// [digitPin] The digits PIN for the number.
  /// [password] The password for the number.
  /// [backupData] The backup data for the number.
  ///
  /// Returns a [WhatsAppSuccessResponse] indicating whether the registration was successful.
  Future<WhatsAppSuccessResponse> accountMigrationRegister(
      String digitPin, String password, String backupData) async {
    final Map<String, dynamic> body = {
      "messaging_product": "whatsapp",
      "pin": digitPin,
      "backup": {"password": password, "data": backupData}
    };

    var url = '$fromNumberId/register';
    
    return executeApiCall(
      () => request.postWithResponse(url, headers, body),
      (json) => WhatsAppSuccessResponse.fromJson(json),
    );
  }

  /// Blocks users by their phone numbers.
  ///
  /// [users] List of phone numbers with country code to be blocked.
  ///
  /// Returns a [WhatsAppBlockedUsersResponse] containing the result of the block operation.
  Future<WhatsAppBlockedUsersResponse> blockUsers(List<String>? users) async {
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

    return executeApiCall(
      () => request.postWithResponse(url, headers, body),
      (json) => WhatsAppBlockedUsersResponse.fromJson(json),
    );
  }

  /// Unblocks users by their phone numbers.
  ///
  /// [users] List of phone numbers with country code to be unblocked.
  ///
  /// Returns a [WhatsAppBlockedUsersResponse] containing the result of the unblock operation.
  Future<WhatsAppBlockedUsersResponse> unblockUsers(List<String>? users) async {
    var unblockUsers = users
        ?.map((user) => {
              "user": user,
            })
        .toList();
    final Map<String, dynamic> body = {
      "messaging_product": "whatsapp",
      "block_users": unblockUsers
    };

    var url = '$fromNumberId/block_users';

    return executeApiCall(
      () => request.deleteWithResponse(url, headers, body),
      (json) => WhatsAppBlockedUsersResponse.fromJson(json),
    );
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

    return executeApiCall(
      () => request.getWithResponse(url, headers),
      (json) => WhatsAppGetBlockedUsersResponse.fromJson(json),
    );
  }
}
