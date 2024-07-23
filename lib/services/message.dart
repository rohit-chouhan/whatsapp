import 'package:whatsapp/utils/request.dart';

class MessageService {
  final String accessToken;
  final String fromNumberId;
  final Request request;

  MessageService(this.accessToken, this.fromNumberId, this.request);

  Future<Request> markAsRead(String phoneNumber, String messageId) async {
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };

    final Map<String, dynamic> body = {
      'messaging_product': "whatsapp",
      'status': "read",
      'message_id': messageId
    };

    await request.post('$fromNumberId/messages', headers, body);
    return request;
  }
}
