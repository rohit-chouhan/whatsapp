import 'package:whatsapp/utils/request.dart';

class ReplyService {
  final String accessToken;
  final String fromNumberId;
  final Request request;

  ReplyService(this.accessToken, this.fromNumberId, this.request);

  Future<Request> reply(String phoneNumber, String messageId, Map<String, dynamic> reply) async {
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };

    final Map<String, dynamic> body = {
      "messaging_product": "whatsapp",
      "recipient_type": "individual",
      "to": phoneNumber,
      "context": {"message_id": messageId}
    };

    final Map<String, dynamic> mergedMap = {
      ...body,
      ...reply,
    };

    await request.post('$fromNumberId/messages', headers, mergedMap);
    return request;
  }
}
