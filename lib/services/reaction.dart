import 'package:whatsapp/utils/request.dart';

class ReactionService {
  final String accessToken;
  final String fromNumberId;
  final Request request;

  ReactionService(this.accessToken, this.fromNumberId, this.request);

  Future<Request> sendReaction(
      String phoneNumber, String messageId, String emoji) async {
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };

    final Map<String, dynamic> body = {
      "messaging_product": "whatsapp",
      "recipient_type": "individual",
      "to": phoneNumber,
      "type": "reaction",
      "reaction": {"message_id": messageId, "emoji": emoji}
    };

    await request.post('$fromNumberId/messages', headers, body);
    return request;
  }
}
