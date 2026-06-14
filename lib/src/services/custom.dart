import 'package:whatsapp/src/services/base_service.dart';
import 'package:whatsapp/src/utils/response/whatsapp_response.dart';

class CustomService extends BaseService {
  CustomService(super.accessToken, super.fromNumberId, super.request);

  Future<WhatsAppResponse> sendCustomRequest(
      String path, Map<String, dynamic> payload) async {
    final Map<String, dynamic> body = payload;

    var url = '$fromNumberId$path';
    
    return executeApiCall(
      () => request.postWithResponse(url, headers, body),
      (json) => WhatsAppResponse.fromJson(json),
    );
  }
}
