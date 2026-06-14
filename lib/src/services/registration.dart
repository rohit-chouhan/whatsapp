import 'package:whatsapp/src/services/base_service.dart';
import 'package:whatsapp/src/utils/response/whatsapp_success_response.dart';

class RegistrationService extends BaseService {
  RegistrationService(super.accessToken, super.fromNumberId, super.request);

  Future<WhatsAppSuccessResponse> register(
      int pin, bool? enableLocalStorage, String? dataLocalizationRegion) async {
    final Map<String, dynamic> body = {
      "messaging_product": "whatsapp",
      "pin": pin,
    };

    if (enableLocalStorage != null) {
      body["data_localization_region"] = dataLocalizationRegion;
    }

    var url = '$fromNumberId/register';
    
    return executeApiCall(
      () => request.postWithResponse(url, headers, body),
      (json) => WhatsAppSuccessResponse.fromJson(json),
    );
  }

  Future<WhatsAppSuccessResponse> deRegister() async {
    var url = '$fromNumberId/deregister';
    
    return executeApiCall(
      () => request.postWithResponse(url, headers, {}),
      (json) => WhatsAppSuccessResponse.fromJson(json),
    );
  }

  Future<WhatsAppSuccessResponse> twoStepVerification(int pin) async {
    final Map<String, dynamic> body = {
      "pin": pin,
    };

    var url = fromNumberId;
    
    return executeApiCall(
      () => request.postWithResponse(url, headers, body),
      (json) => WhatsAppSuccessResponse.fromJson(json),
    );
  }
}
