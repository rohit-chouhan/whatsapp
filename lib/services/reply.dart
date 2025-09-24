import 'package:whatsapp/services/base_service.dart';
import 'package:whatsapp/utils/response/whatsapp_response.dart';

class ReplyService extends BaseService {
  ReplyService(super.accessToken, super.fromNumberId, super.request);

  Future<WhatsAppResponse> reply(
      String phoneNumber, String messageId, Map<String, dynamic> reply) async {
    final Map<String, dynamic> body = {
      "messaging_product": "whatsapp",
      "recipient_type": "individual",
      "to": phoneNumber,
      "context": {"message_id": messageId},
      ...reply,
    };

    return executeApiCall(
      () => request.postWithResponse('$fromNumberId/messages', headers, body),
      (json) => WhatsAppResponse.fromJson(json),
    );
  }
}
