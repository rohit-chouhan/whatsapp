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
