import 'package:whatsapp/utils/request.dart';

class InteractiveService {
  final String accessToken;
  final String fromNumberId;
  final Request request;

  InteractiveService(this.accessToken, this.fromNumberId, this.request);

  Future<Request> sendInteractiveReplayButtons(
      String phoneNumber,
      Map<String, dynamic> headerInteractive,
      String bodyText,
      String footerText,
      List<Map<String, dynamic>> interactiveReplyButtons) async {
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };

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

    await request.post('$fromNumberId/messages', headers, body);
    return request;
  }

  Future<Request> sendInteractiveLists(
      String phoneNumber,
      String? headerText,
      String bodyText,
      String? footerText,
      String buttonText,
      List<Map<String, dynamic>> sections) async {
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };

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

    await request.post('$fromNumberId/messages', headers, body);
    return request;
  }

  Future<Request> sendCallToActionButton(
      String phoneNumber,
      String? headerText,
      String bodyText,
      String? footerText,
      String buttonText,
      String buttonUrl) async {
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };

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

    await request.post('$fromNumberId/messages', headers, body);
    return request;
  }
}
