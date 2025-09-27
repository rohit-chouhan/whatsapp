import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:whatsapp/src/utils/exception.dart';
import 'package:whatsapp/src/utils/request.dart';
import 'package:whatsapp/src/utils/response/whatsapp_response.dart';

class PhoneService {
  final String accessToken;
  final String fromNumberId;
  final Request request;

  PhoneService(this.accessToken, this.fromNumberId, this.request);

  Future<WhatsAppResponse> requestCode(
      String? codeMethod, String? language) async {
    final Map<String, String> headers = {
      'Authorization': 'Bearer $accessToken',
    };

    codeMethod ??= 'SMS';
    language ??= 'en';

    final Map<String, String> body = {
      'code_method': codeMethod,
      'language': language,
    };

    var url = '$fromNumberId/request_code';
    try {
      final http.Response response =
          await request.postFormWithResponse(url, headers, body);

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

  Future<WhatsAppResponse> verifyCode(int code) async {
    final Map<String, String> headers = {
      'Authorization': 'Bearer $accessToken',
    };

    final Map<String, String> body = {
      'code': code.toString(),
    };

    var url = '$fromNumberId/verify_code';
    try {
      final http.Response response =
          await request.postFormWithResponse(url, headers, body);

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
