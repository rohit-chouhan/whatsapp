import 'package:whatsapp/src/services/base_service.dart';
import 'package:whatsapp/src/utils/response/whatsapp_response.dart';

class ContactService extends BaseService {
  ContactService(super.accessToken, super.fromNumberId, super.request);

  Future<WhatsAppResponse> sendContactDetails(
    String phoneNumber,
    String? dateOfBirth,
    List<Map<dynamic, dynamic>>? addresses,
    List<Map<dynamic, dynamic>>? emails,
    Map<dynamic, dynamic> person,
    Map<dynamic, dynamic>? organization,
    List<Map<dynamic, dynamic>> phones,
    List<Map<dynamic, dynamic>>? urls,
  ) async {
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
    var url = '$fromNumberId/messages';
    
    return executeApiCall(
      () => request.postWithResponse(url, headers, body),
      (json) => WhatsAppResponse.fromJson(json),
    );
  }
}
