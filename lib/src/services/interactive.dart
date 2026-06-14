import 'package:whatsapp/src/services/base_service.dart';
import 'package:whatsapp/src/utils/response/whatsapp_response.dart';

class InteractiveService extends BaseService {
  InteractiveService(super.accessToken, super.fromNumberId, super.request);

  Future<WhatsAppResponse> sendInteractiveReplyButtons(
      String phoneNumber,
      Map<String, dynamic> headerInteractive,
      String bodyText,
      String footerText,
      List<Map<String, dynamic>> interactiveReplyButtons) async {
    final Map<String, dynamic> body = {
      "messaging_product": "whatsapp",
      "recipient_type": "individual",
      "to": phoneNumber,
      "type": "interactive",
      "interactive": {
        "type": "button",
        "header": headerInteractive,
        "body": {"text": bodyText},
        "footer": {"text": footerText},
        "action": {"buttons": interactiveReplyButtons}
      }
    };

    var url = '$fromNumberId/messages';
    
    return executeApiCall(
      () => request.postWithResponse(url, headers, body),
      (json) => WhatsAppResponse.fromJson(json),
    );
  }

  Future<WhatsAppResponse> sendInteractiveLists(
      String phoneNumber,
      String? headerText,
      String bodyText,
      String? footerText,
      String buttonText,
      List<Map<String, dynamic>> sections) async {
    final Map<String, dynamic> body = {
      "messaging_product": "whatsapp",
      "recipient_type": "individual",
      "to": phoneNumber,
      "type": "interactive",
      "interactive": {
        "type": "list",
        "body": {"text": bodyText},
        "action": {
          "sections": sections,
          "button": buttonText,
        }
      }
    };

    if (headerText != null) {
      body['interactive']['header'] = {"type": "text", "text": headerText};
    }

    if (footerText != null) {
      body['interactive']['footer'] = {"text": footerText};
    }

    var url = '$fromNumberId/messages';
    
    return executeApiCall(
      () => request.postWithResponse(url, headers, body),
      (json) => WhatsAppResponse.fromJson(json),
    );
  }

  Future<WhatsAppResponse> sendCallToActionButton(
      String phoneNumber,
      String? headerText,
      String bodyText,
      String? footerText,
      String buttonText,
      String buttonUrl) async {
    final Map<String, dynamic> body = {
      "messaging_product": "whatsapp",
      "recipient_type": "individual",
      "to": phoneNumber,
      "type": "interactive",
      "interactive": {
        "type": "cta_url",
        "body": {"text": bodyText},
        "action": {
          "name": "cta_url",
          "parameters": {"display_text": buttonText, "url": buttonUrl}
        }
      }
    };

    if (headerText != null) {
      body['interactive']['header'] = {"type": "text", "text": headerText};
    }

    if (footerText != null) {
      body['interactive']['footer'] = {"text": footerText};
    }

    var url = '$fromNumberId/messages';
    
    return executeApiCall(
      () => request.postWithResponse(url, headers, body),
      (json) => WhatsAppResponse.fromJson(json),
    );
  }
}
