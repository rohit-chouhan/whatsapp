import 'package:whatsapp/utils/request.dart';

class StickerService {
  final String accessToken;
  final String fromNumberId;
  final Request request;

  StickerService(this.accessToken, this.fromNumberId, this.request);

  Future<Request> sendSticker(String phoneNumber, String mediaId) async {
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };

    final Map<String, dynamic> body = {
      "messaging_product": "whatsapp",
      "recipient_type": "individual",
      "to": phoneNumber,
      "type": "sticker",
      "sticker": {"id": mediaId}
    };

    await request.post('$fromNumberId/messages', headers, body);
    return request;
  }
}
