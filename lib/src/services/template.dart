import 'package:whatsapp/src/services/base_service.dart';
import 'package:whatsapp/src/utils/response/whatsapp_response.dart';

class TemplateService extends BaseService {
  TemplateService(super.accessToken, super.fromNumberId, super.request);

  Future<WhatsAppResponse> sendTemplate(String phoneNumber, String template,
      String language, List<Map<String, dynamic>>? placeholder) async {
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

    var url = '$fromNumberId/messages';
    
    return executeApiCall(
      () => request.postWithResponse(url, headers, body),
      (json) => WhatsAppResponse.fromJson(json),
    );
  }
}
