import 'package:whatsapp/utils/request.dart';

class ContactService {
  final String accessToken;
  final String fromNumberId;
  final Request request;

  ContactService(this.accessToken, this.fromNumberId, this.request);

  Future<Request> sendContactDetails(
    String phoneNumber,
    String? dateOfBirth,
    List<Map<dynamic, dynamic>>? addresses,
    List<Map<dynamic, dynamic>>? emails,
    Map<dynamic, dynamic> person,
    Map<dynamic, dynamic>? organization,
    List<Map<dynamic, dynamic>> phones,
    List<Map<dynamic, dynamic>>? urls,
  ) async {
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };

    final Map<String, dynamic> body = {
      "messaging_product": "whatsapp",
      "to": phoneNumber,
      "type": "contacts",
      "contacts": [
        {
          "name": person,
          "phones": phones,
        }
      ]
    };

    if (addresses != null) {
      body['contacts'][0]['addresses'] = addresses;
    }

    if (dateOfBirth != null) {
      body['contacts'][0]['birthday'] = dateOfBirth;
    }

    if (emails != null) {
      body['contacts'][0]['emails'] = emails;
    }

    if (organization != null) {
      body['contacts'][0]['org'] = organization;
    }

    if (urls != null) {
      body['contacts'][0]['urls'] = urls;
    }

    await request.post('$fromNumberId/messages', headers, body);
    return request;
  }
}
