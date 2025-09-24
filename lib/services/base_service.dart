import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:whatsapp/utils/exception.dart';
import 'package:whatsapp/utils/request.dart';

/// Base class for all WhatsApp service classes providing common functionality.
abstract class BaseService {
  final String accessToken;
  final String fromNumberId;
  final Request request;

  BaseService(this.accessToken, this.fromNumberId, this.request);

  /// Common headers for WhatsApp API requests.
  Map<String, String> get headers => {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      };

  /// Common error handling for API responses.
  T handleResponse<T>(
    http.Response response,
    T Function(Map<String, dynamic>) successParser,
  ) {
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseBody = jsonDecode(response.body);
      return successParser(responseBody);
    } else {
      throw WhatsAppException.fromResponse(response);
    }
  }

  /// Common exception handling wrapper for API calls.
  Future<T> executeApiCall<T>(
    Future<http.Response> Function() apiCall,
    T Function(Map<String, dynamic>) successParser,
  ) async {
    try {
      final response = await apiCall();
      return handleResponse(response, successParser);
    } on FormatException catch (e) {
      throw JsonFormatException('Failed to parse JSON response: $e');
    } on http.ClientException catch (e) {
      throw NetworkException('Network error: $e');
    } on WhatsAppException {
      rethrow;
    } catch (e) {
      throw WhatsAppException('An unexpected error occurred: $e');
    }
  }

  /// Helper method to create message body with common fields.
  Map<String, dynamic> createMessageBody(
    String type,
    String phoneNumber,
    Map<String, dynamic> content,
  ) {
    return {
      'messaging_product': 'whatsapp',
      'recipient_type': 'individual',
      'to': phoneNumber,
      'type': type,
      type: content,
    };
  }
}