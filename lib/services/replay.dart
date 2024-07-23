import 'package:whatsapp/utils/request.dart';

class ReplayService {
  final String accessToken;
  final String fromNumberId;
  final Request request;

  ReplayService(this.accessToken, this.fromNumberId, this.request);

  Future<Request> replay(String phoneNumber, String messageId, replay) async {
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

    var append = replay;

    final Map<String, dynamic> mergedMap = {
      ...body,
      ...append,
    };

    await request.post('$fromNumberId/messages', headers, mergedMap);
    return request;
  }
}
