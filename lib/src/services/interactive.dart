import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:whatsapp/src/utils/exception.dart';
import 'package:whatsapp/src/utils/request.dart';
import 'package:whatsapp/src/utils/response/whatsapp_response.dart';

class InteractiveService {
  final String accessToken;
  final String fromNumberId;
  final Request request;

  InteractiveService(this.accessToken, this.fromNumberId, this.request);

  Future<WhatsAppResponse> sendInteractiveReplyButtons(
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

    var url = '$fromNumberId/messages';
    try {
      final http.Response response =
          await request.postWithResponse(url, headers, body);

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseBody = jsonDecode(response.body);
        final WhatsAppResponse parsedResponse =
            WhatsAppResponse.fromJson(responseBody);
        return parsedResponse;
      } else {
        // Throw a more specific exception using the factory constructor
        throw WhatsAppException.fromResponse(response);
      }
    } on FormatException catch (e) {
      // Handle JSON decoding errors specifically
      throw JsonFormatException('Failed to parse JSON response: $e');
    } on http.ClientException catch (e) {
      // Handle network-related errors (e.g., no internet, timeout)
      throw NetworkException('Network error: $e');
    } on WhatsAppException {
      // Re-throw WhatsApp-specific exceptions.
      rethrow;
    } catch (e) {
      // Handle any other unexpected exceptions.
      throw WhatsAppException('An unexpected error occurred: $e');
    }
  }

  Future<WhatsAppResponse> sendInteractiveLists(
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

    var url = '$fromNumberId/messages';
    try {
      final http.Response response =
          await request.postWithResponse(url, headers, body);

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseBody = jsonDecode(response.body);
        final WhatsAppResponse parsedResponse =
            WhatsAppResponse.fromJson(responseBody);
        return parsedResponse;
      } else {
        // Throw a more specific exception using the factory constructor
        throw WhatsAppException.fromResponse(response);
      }
    } on FormatException catch (e) {
      // Handle JSON decoding errors specifically
      throw JsonFormatException('Failed to parse JSON response: $e');
    } on http.ClientException catch (e) {
      // Handle network-related errors (e.g., no internet, timeout)
      throw NetworkException('Network error: $e');
    } on WhatsAppException {
      // Re-throw WhatsApp-specific exceptions.
      rethrow;
    } catch (e) {
      // Handle any other unexpected exceptions.
      throw WhatsAppException('An unexpected error occurred: $e');
    }
  }

  Future<WhatsAppResponse> sendCallToActionButton(
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

    var url = '$fromNumberId/messages';
    try {
      final http.Response response =
          await request.postWithResponse(url, headers, body);

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseBody = jsonDecode(response.body);
        final WhatsAppResponse parsedResponse =
            WhatsAppResponse.fromJson(responseBody);
        return parsedResponse;
      } else {
        // Throw a more specific exception using the factory constructor
        throw WhatsAppException.fromResponse(response);
      }
    } on FormatException catch (e) {
      // Handle JSON decoding errors specifically
      throw JsonFormatException('Failed to parse JSON response: $e');
    } on http.ClientException catch (e) {
      // Handle network-related errors (e.g., no internet, timeout)
      throw NetworkException('Network error: $e');
    } on WhatsAppException {
      // Re-throw WhatsApp-specific exceptions.
      rethrow;
    } catch (e) {
      // Handle any other unexpected exceptions.
      throw WhatsAppException('An unexpected error occurred: $e');
    }
  }
}
