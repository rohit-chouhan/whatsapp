import 'package:whatsapp/utils/request.dart';

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
}
