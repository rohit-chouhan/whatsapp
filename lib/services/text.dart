import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:whatsapp/utils/exception.dart';
import 'package:whatsapp/utils/request.dart';
import 'package:whatsapp/utils/response/whatsapp_response.dart';

class TextService {
  final String accessToken;
  final String fromNumberId;
  final Request request;

  TextService(this.accessToken, this.fromNumberId, this.request);

  String getLink(
    String phoneNumber,
    String? message,
    bool? shortLink,
    List<String>? bold,
    List<String>? italic,
    List<String>? strikethrough,
    List<String>? monospace,
  ) {
    // Helper function to apply formatting on text based on symbol parameter
    String applyFormatting(String text, String symbol) {
      return '$symbol$text$symbol';
    }

    // Apply formatting based on parameters
    var body = message ?? '';

    if (bold != null) {
      for (var word in bold) {
        body = body.replaceAll(word, applyFormatting(word, '*'));
      }
    }

    if (italic != null) {
      for (var word in italic) {
        body = body.replaceAll(word, applyFormatting(word, '_'));
      }
    }

    if (strikethrough != null) {
      for (var word in strikethrough) {
        body = body.replaceAll(word, applyFormatting(word, '~'));
      }
    }

    if (monospace != null) {
      for (var word in monospace) {
        body = body.replaceAll(word, applyFormatting(word, '```'));
      }
    }

    // Remove '+' from phone number
    phoneNumber = phoneNumber.replaceAll("+", "");

    // Generate the appropriate link
    if (shortLink != null && shortLink) {
      return 'https://wa.me/$phoneNumber?text=${Uri.encodeComponent(body)}';
    } else {
      return 'https://api.whatsapp.com/send?phone=$phoneNumber&text=${Uri.encodeComponent(body)}';
    }
  }

  Future<WhatsAppResponse> sendMessage(
      String phoneNumber, String text, bool previewUrl) async {
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };

    final Map<String, dynamic> body = {
      'messaging_product': 'whatsapp',
      'recipient_type': 'individual',
      'to': phoneNumber,
      'type': 'text',
      'text': {
        'preview_url': previewUrl,
        'body': text,
      },
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
}
