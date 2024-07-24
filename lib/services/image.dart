import 'package:whatsapp/utils/request.dart';

class ImageService {
  final String accessToken;
  final String fromNumberId;
  final Request request;

  ImageService(this.accessToken, this.fromNumberId, this.request);

  Future<Request> sendImageById(
      String phoneNumber, String mediaId, String? caption) async {
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };

    final Map<String, dynamic> body = {
      "messaging_product": "whatsapp",
      "recipient_type": "individual",
      "to": phoneNumber,
      "type": "image",
      "image": {"id": mediaId}
    };

    if (caption != null) {
      body['image']['caption'] = caption;
    }

    await request.post('$fromNumberId/messages', headers, body);
    return request;
  }

  Future<Request> sendImageByUrl(
      String phoneNumber, String url, String? caption) async {
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };

    final Map<String, dynamic> body = {
      "messaging_product": "whatsapp",
      "recipient_type": "individual",
      "to": phoneNumber,
      "type": "image",
      "image": {"link": url}
    };

    if (caption != null) {
      body['image']['caption'] = caption;
    }

    await request.post('$fromNumberId/messages', headers, body);
    return request;
  }
}
