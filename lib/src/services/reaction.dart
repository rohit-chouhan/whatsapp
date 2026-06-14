import 'package:whatsapp/src/services/base_service.dart';
import 'package:whatsapp/src/utils/response/whatsapp_response.dart';

class ReactionService extends BaseService {
  ReactionService(super.accessToken, super.fromNumberId, super.request);

  Future<WhatsAppResponse> sendReaction(
      String phoneNumber, String messageId, String emoji) async {
    final Map<String, dynamic> body = {
      "messaging_product": "whatsapp",
      "recipient_type": "individual",
      "to": phoneNumber,
      "type": "reaction",
      "reaction": {"message_id": messageId, "emoji": emoji}
    };

    var url = '$fromNumberId/messages';
    
    return executeApiCall(
      () => request.postWithResponse(url, headers, body),
      (json) => WhatsAppResponse.fromJson(json),
    );
  }
}
