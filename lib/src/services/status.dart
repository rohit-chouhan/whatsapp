import 'package:whatsapp/src/services/base_service.dart';
import 'package:whatsapp/src/utils/response/whatsapp_success_response.dart';

class StatusService extends BaseService {
  StatusService(super.accessToken, super.fromNumberId, super.request);

  Future<WhatsAppSuccessResponse> markAsRead(String messageId) async {
    final Map<String, dynamic> body = {
      "messaging_product": "whatsapp",
      "status": "read",
      "message_id": messageId,
    };

    var url = '$fromNumberId/messages';
    
    return executeApiCall(
      () => request.postWithResponse(url, headers, body),
      (json) => WhatsAppSuccessResponse.fromJson(json),
    );
  }

  Future<WhatsAppSuccessResponse> sendTypingIndicator(String messageId) async {
    final Map<String, dynamic> body = {
      "messaging_product": "whatsapp",
      "status": "read",
      "message_id": messageId,
      "typing_indicator": {"type": "text"}
    };

    var url = '$fromNumberId/messages';
    
    return executeApiCall(
      () => request.postWithResponse(url, headers, body),
      (json) => WhatsAppSuccessResponse.fromJson(json),
    );
  }
}
