import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:whatsapp/utils/exception.dart';
import 'package:whatsapp/utils/request.dart';
import 'package:whatsapp/utils/response/whatsapp_success_response.dart';

class StatusService {
  final String accessToken;
  final String fromNumberId;
  final Request request;

  StatusService(this.accessToken, this.fromNumberId, this.request);

  /// Get message status by message ID
  /// [messageId] The message ID to get status for
  ///
  /// return Request The response object containing the HTTP response code, error message, and message status
  // Future<Request> getMessageStatus(String messageId) async {
  //   final Map<String, String> headers = {
  //     'Authorization': 'Bearer $accessToken',
  //   };

  //   await request.get('$fromNumberId/messages/$messageId', headers);
  //   return request;
  // }

  /// Mark message as read
  /// [messageId] The message ID to mark as read
  ///
  /// return Request The response object containing the HTTP response code, error message, and message ID if the
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

  /// Mark message as delivered
  /// [messageId] The message ID to mark as delivered
  ///
  /// return Request The response object containing the HTTP response code, error message, and message ID if the
  // Future<Request> markAsDelivered(String messageId) async {
  //   final Map<String, String> headers = {
  //     'Content-Type': 'application/json',
  //     'Authorization': 'Bearer $accessToken',
  //   };

  //   final Map<String, dynamic> body = {
  //     "messaging_product": "whatsapp",
  //     "status": "delivered",
  //     "message_id": messageId,
  //   };

  //   await request.post('$fromNumberId/messages', headers, body);
  //   return request;
  // }

  /// New Method for Typing Indicators
  /// Send typing indicators
  /// [messageId] The message ID to send typing indicators for
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
