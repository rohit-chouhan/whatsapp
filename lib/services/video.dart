import 'package:whatsapp/utils/request.dart';

class VideoService {
  final String accessToken;
  final String fromNumberId;
  final Request request;

  VideoService(this.accessToken, this.fromNumberId, this.request);

  Future<Request> sendVideoById(
      String phoneNumber, String mediaId, String? caption) async {
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };

    final Map<String, dynamic> body = {
      "messaging_product": "whatsapp",
      "recipient_type": "individual",
      "to": phoneNumber,
      "type": "video",
      "video": {"id": mediaId}
    };

    if (caption != null) {
      body['video']['caption'] = caption;
    }

    await request.post('$fromNumberId/messages', headers, body);
    return request;
  }

  Future<Request> sendVideoByUrl(
      String phoneNumber, String url, String? caption) async {
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };

    final Map<String, dynamic> body = {
      "messaging_product": "whatsapp",
      "recipient_type": "individual",
      "to": phoneNumber,
      "type": "video",
      "video": {"link": url}
    };

    if (caption != null) {
      body['video']['caption'] = caption;
    }

    await request.post('$fromNumberId/messages', headers, body);
    return request;
  }
}
