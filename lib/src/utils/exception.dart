import 'dart:convert';

import 'package:http/http.dart' as http;

class NetworkException implements Exception {
  final String message;
  NetworkException(this.message);
}

class JsonFormatException implements Exception {
  final String message;
  JsonFormatException(this.message);
}

class HttpException implements Exception {
  final String message;
  HttpException(this.message);
}

class WhatsAppException implements Exception {
  final String message;
  final int? statusCode;
  final String? errorCode;
  final String? errorType;
  final Map<String, dynamic>? details;

  WhatsAppException(
    this.message, {
    this.statusCode,
    this.errorCode,
    this.errorType,
    this.details,
  });

  @override
  String toString() {
    String result = 'WhatsAppException: $message';
    if (statusCode != null) result += ' (Status: $statusCode)';
    if (errorCode != null) result += ' (Error Code: $errorCode)';
    if (errorType != null) result += ' (Error Type: $errorType)';
    if (details != null) result += ' (Details: $details)';
    return result;
  }

  /// Create a WhatsAppException from API response
  factory WhatsAppException.fromResponse(http.Response response) {
    try {
      final Map<String, dynamic> decodedBody = jsonDecode(response.body);
      final error = decodedBody['error'];

      if (error != null) {
        final message = error['message'] as String? ?? 'Unknown error';
        final code = error['code']; // Remove the `as int?` cast
        final type = error['type'] as String?;

        // Explicitly check for the type of `code` before converting.
        String? errorCodeString;
        if (code is int) {
          errorCodeString = code.toString();
        } else if (code is String) {
          errorCodeString = code;
        }

        return WhatsAppException(
          message,
          statusCode: response.statusCode,
          errorCode: errorCodeString, // This is now a nullable String.
          errorType: type,
          details: error,
        );
      }
    } on FormatException {
      return WhatsAppException(
        'Server returned a non-JSON error response.',
        statusCode: response.statusCode,
      );
    } catch (e) {
      return WhatsAppException(
        'An error occurred while parsing the WhatsApp API response: $e',
        statusCode: response.statusCode,
      );
    }

    return WhatsAppException(
      'Server returned an unknown error.',
      statusCode: response.statusCode,
    );
  }
}

class WhatsAppAuthenticationException extends WhatsAppException {
  WhatsAppAuthenticationException(super.message)
      : super(errorType: 'authentication');
}

class WhatsAppRateLimitException extends WhatsAppException {
  WhatsAppRateLimitException(super.message) : super(errorType: 'rate_limit');
}

class WhatsAppValidationException extends WhatsAppException {
  WhatsAppValidationException(super.message, {super.details})
      : super(errorType: 'validation');
}
