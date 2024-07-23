import 'package:whatsapp/utils/request.dart';

class TemplateService {
  final String accessToken;
  final String fromNumberId;
  final Request request;

  TemplateService(this.accessToken, this.fromNumberId, this.request);

  Future<Request> sendTemplate(String phoneNumber, String template,
      String language, List<Map<String, dynamic>>? placeholder) async {
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };

    final Map<String, dynamic> body = {
      'messaging_product': 'whatsapp',
      'to': phoneNumber,
      'type': 'template',
      'template': {
        'name': template,
        'language': {'code': language},
        'components': []
      },
    };

    if (placeholder != null && placeholder.isNotEmpty) {
      body['template']['components'] = [
        {
          'type': 'body',
          'parameters': placeholder,
        }
      ];
    }

    await request.post('$fromNumberId/messages', headers, body);
    return request;
  }
}
