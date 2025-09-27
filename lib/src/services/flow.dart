import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:whatsapp/src/utils/exception.dart';
import 'package:whatsapp/src/utils/request.dart';
import 'package:whatsapp/src/utils/response/whatsapp_response.dart';

class FlowService {
  final String accessToken;
  final String fromNumberId;
  final Request request;

  FlowService(this.accessToken, this.fromNumberId, this.request);

  /// Send a Flow message to the specified phone number
  /// [phoneNumber] The phone number with country code to which the flow message will be sent
  /// [flowToken] The flow token for the flow message
  /// [flowId] The flow ID for the flow message
  /// [flowCta] The call-to-action text for the flow message
  /// [flowActionPayload] The payload for the flow action
  /// [headerText] The header text for the flow message (optional)
  /// [bodyText] The body text for the flow message (optional)
  /// [footerText] The footer text for the flow message (optional)
  ///
  /// return Request The response object containing the HTTP response code, error message, and message ID if the
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
        "type": "flow",
        "header": headerText != null
            ? {
                "type": "text",
                "text": headerText,
              }
            : null,
        "body": bodyText != null
            ? {
                "text": bodyText,
              }
            : null,
        "footer": footerText != null
            ? {
                "text": footerText,
              }
            : null,
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

    // Remove null values
    if (body["interactive"]["header"] == null) {
      body["interactive"].remove("header");
    }
    if (body["interactive"]["body"] == null) {
      body["interactive"].remove("body");
    }
    if (body["interactive"]["footer"] == null) {
      body["interactive"].remove("footer");
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
