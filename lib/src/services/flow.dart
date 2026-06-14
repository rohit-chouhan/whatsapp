import 'package:whatsapp/src/services/base_service.dart';
import 'package:whatsapp/src/utils/response/whatsapp_response.dart';

class FlowService extends BaseService {
  FlowService(super.accessToken, super.fromNumberId, super.request);

  /// Send a Flow message to the specified phone number
  Future<WhatsAppResponse> sendFlowMessage({
    required String phoneNumber,
    required String flowToken,
    required String flowId,
    required String flowCta,
    required Map<String, dynamic> flowActionPayload,
    String? headerText,
    String? bodyText,
    String? footerText,
  }) async {
    final Map<String, dynamic> body = {
      "messaging_product": "whatsapp",
      "recipient_type": "individual",
      "to": phoneNumber,
      "type": "interactive",
      "interactive": {
        "type": "flow",
        "action": {
          "name": "flow",
          "parameters": {
            "flow_message_version": "3",
            "flow_token": flowToken,
            "flow_id": flowId,
            "flow_cta": flowCta,
            "flow_action_payload": flowActionPayload,
          }
        }
      }
    };

    if (headerText != null) {
      body["interactive"]["header"] = {
        "type": "text",
        "text": headerText,
      };
    }
    if (bodyText != null) {
      body["interactive"]["body"] = {
        "text": bodyText,
      };
    }
    if (footerText != null) {
      body["interactive"]["footer"] = {
        "text": footerText,
      };
    }

    var url = '$fromNumberId/messages';
    
    return executeApiCall(
      () => request.postWithResponse(url, headers, body),
      (json) => WhatsAppResponse.fromJson(json),
    );
  }
}
