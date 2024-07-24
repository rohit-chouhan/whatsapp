import 'package:whatsapp/utils/request.dart';

class DocumentService {
  final String accessToken;
  final String fromNumberId;
  final Request request;

  DocumentService(this.accessToken, this.fromNumberId, this.request);

  Future<Request> sendDocumentById(String phoneNumber, String mediaId,
      String? caption, String? fileName) async {
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };

    final Map<String, dynamic> body = {
      "messaging_product": "whatsapp",
      "recipient_type": "individual",
      "to": phoneNumber,
      "type": "document",
      "document": {"id": mediaId}
    };

    if (caption != null) {
      body['document']['caption'] = caption;
    }

    if (fileName != null) {
      body['document']['filename'] = fileName;
    }

    await request.post('$fromNumberId/messages', headers, body);
    return request;
  }

  Future<Request> sendDocumentByUrl(
      String phoneNumber, String url, String? caption, String? fileName) async {
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };

    final Map<String, dynamic> body = {
      "messaging_product": "whatsapp",
      "recipient_type": "individual",
      "to": phoneNumber,
      "type": "document",
      "document": {"link": url}
    };

    if (caption != null) {
      body['document']['caption'] = caption;
    }

    if (fileName != null) {
      body['document']['filename'] = fileName;
    }

    await request.post('$fromNumberId/messages', headers, body);
    return request;
  }
}
