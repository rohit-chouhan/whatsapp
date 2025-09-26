import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:whatsapp/utils/exception.dart';
import 'package:whatsapp/utils/request.dart';
import 'package:whatsapp/utils/response/whatsapp_success_response.dart';

/// A service for managing message status operations such as marking as read
/// and sending typing indicators.
class StatusService {
  /// The access token for WhatsApp Cloud API authentication.
  final String accessToken;

  /// The phone number ID used as the sender in API requests.
  final String fromNumberId;

  /// The request utility for making HTTP calls.
  final Request request;

  /// Creates an instance of [StatusService].
  StatusService(this.accessToken, this.fromNumberId, this.request);

  /// Marks a message as read.
  ///
  /// [messageId] The message ID to mark as read.
  ///
  /// Returns a [WhatsAppSuccessResponse] indicating success.
  Future<WhatsAppSuccessResponse> markAsRead(String messageId) async {
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };

    final Map<String, dynamic> body = {
      "messaging_product": "whatsapp",
      "status": "read",
      "message_id": messageId,
    };

    var url = '$fromNumberId/messages';
    try {
      final http.Response response =
          await request.postWithResponse(url, headers, body);

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseBody = jsonDecode(response.body);
        final WhatsAppSuccessResponse parsedResponse =
            WhatsAppSuccessResponse.fromJson(responseBody);
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

  /// Sends a typing indicator for a message.
  ///
  /// [messageId] The message ID to send typing indicators for.
  ///
  /// Returns a [WhatsAppSuccessResponse] indicating success.
  Future<WhatsAppSuccessResponse> sendTypingIndicator(String messageId) async {
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };

    final Map<String, dynamic> body = {
      "messaging_product": "whatsapp",
      "status": "read",
      "message_id": messageId,
      "typing_indicator": {"type": "text"}
    };

    var url = '$fromNumberId/messages';
    try {
      final http.Response response =
          await request.postWithResponse(url, headers, body);

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseBody = jsonDecode(response.body);
        final WhatsAppSuccessResponse parsedResponse =
            WhatsAppSuccessResponse.fromJson(responseBody);
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
