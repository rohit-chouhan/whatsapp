import 'package:whatsapp/src/services/base_service.dart';
import 'package:whatsapp/src/utils/response/whatsapp_response.dart';

class PhoneService extends BaseService {
  PhoneService(super.accessToken, super.fromNumberId, super.request);

  Map<String, String> get _formHeaders => {
        'Authorization': 'Bearer $accessToken',
      };

  Future<WhatsAppResponse> requestCode(
      String? codeMethod, String? language) async {
    codeMethod ??= 'SMS';
    language ??= 'en';

    final Map<String, String> body = {
      'code_method': codeMethod,
      'language': language,
    };

    var url = '$fromNumberId/request_code';
    
    return executeApiCall(
      () => request.postFormWithResponse(url, _formHeaders, body),
      (json) => WhatsAppResponse.fromJson(json),
    );
  }

  Future<WhatsAppResponse> verifyCode(int code) async {
    final Map<String, String> body = {
      'code': code.toString(),
    };

    var url = '$fromNumberId/verify_code';
    
    return executeApiCall(
      () => request.postFormWithResponse(url, _formHeaders, body),
      (json) => WhatsAppResponse.fromJson(json),
    );
  }
}
