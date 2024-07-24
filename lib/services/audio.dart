import 'package:whatsapp/utils/request.dart';

class AudioService {
  final String accessToken;
  final String fromNumberId;
  final Request request;

  AudioService(this.accessToken, this.fromNumberId, this.request);

  Future<Request> sendAudioById(String phoneNumber, String mediaId) async {
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };

    final Map<String, dynamic> body = {
      "messaging_product": "whatsapp",
      "recipient_type": "individual",
      "to": phoneNumber,
      "type": "audio",
      "audio": {"id": mediaId}
    };

    await request.post('$fromNumberId/messages', headers, body);
    return request;
  }

  Future<Request> sendAudioByUrl(String phoneNumber, String url) async {
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };

    final Map<String, dynamic> body = {
      "messaging_product": "whatsapp",
      "recipient_type": "individual",
      "to": phoneNumber,
      "type": "audio",
      "audio": {"link": url}
    };

    await request.post('$fromNumberId/messages', headers, body);
    return request;
  }
}
