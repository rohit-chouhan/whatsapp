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
  factory WhatsAppException.fromResponse(Map<String, dynamic> response) {
    final error = response['error'];
    if (error != null) {
      return WhatsAppException(
        error['message'] ?? 'Unknown error',
        statusCode: response['status_code'],
        errorCode: error['code']?.toString(),
        errorType: error['type'],
        details: error,
      );
    }
    return WhatsAppException('Unknown error occurred');
  }
}

class WhatsAppAuthenticationException extends WhatsAppException {
  WhatsAppAuthenticationException(String message) : super(message, errorType: 'authentication');
}

class WhatsAppRateLimitException extends WhatsAppException {
  WhatsAppRateLimitException(String message) : super(message, errorType: 'rate_limit');
}

class WhatsAppValidationException extends WhatsAppException {
  WhatsAppValidationException(String message, {Map<String, dynamic>? details}) 
      : super(message, errorType: 'validation', details: details);
}