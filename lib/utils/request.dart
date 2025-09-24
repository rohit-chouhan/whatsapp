import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class Request {
  String? response;
  String? error;
  String? errorMessage;
  int? httpCode;
  String? messageId;
  String? phoneNumber;
  String? mediaId;
  String? mediaUrl;
  String? mediaMimeType;
  String? mediaSha256;
  String? mediaFileSize;
  String url = 'https://graph.facebook.com/v23.0/';

  // Clear previous state before making new requests
  void _clearState() {
    response = null;
    error = null;
    errorMessage = null;
    httpCode = null;
    messageId = null;
    phoneNumber = null;
    mediaId = null;
    mediaUrl = null;
    mediaMimeType = null;
    mediaSha256 = null;
    mediaFileSize = null;
  }

  // Common response parsing logic
  void _parseResponse(String responseBody, int statusCode) {
    response = responseBody;
    httpCode = statusCode;

    if (responseBody.isNotEmpty) {
      try {
        final Map<String, dynamic> jsonResponse = jsonDecode(responseBody);
        errorMessage = jsonResponse['error']?['message'];

        // Parse message data if available
        if (jsonResponse['messages'] is List &&
            jsonResponse['messages'].isNotEmpty) {
          messageId = jsonResponse['messages'][0]?['id'];
        }

        // Parse contact data if available
        if (jsonResponse['contacts'] is List &&
            jsonResponse['contacts'].isNotEmpty) {
          phoneNumber = jsonResponse['contacts'][0]?['input'];
        }

        // Parse input data if available (for GET requests)
        phoneNumber ??= jsonResponse['input']?[0]?['to'];

        // Parse media data if available
        mediaId ??= jsonResponse['id'];
        mediaUrl ??= jsonResponse['url'];
        mediaMimeType ??= jsonResponse['mime_type'];
        mediaSha256 ??= jsonResponse['sha256'];
        mediaFileSize ??= jsonResponse['file_size']?.toString();
      } catch (e) {
        // If JSON parsing fails but we have a response, set a generic error message
        errorMessage = 'Failed to parse response: $e';
      }
    }

    // Set error for HTTP error codes
    if (statusCode >= 400) {
      error = 'HTTP Error';
    }
  }

  Future<void> post(String endpoint, Map<String, String> headers,
      Map<String, dynamic>? body) async {
    _clearState();
    final Uri uri = Uri.parse('$url$endpoint');

    try {
      final http.Response res;

      if (body != null && body.isNotEmpty) {
        res = await http.post(
          uri,
          headers: headers,
          body: jsonEncode(body),
        );
      } else {
        res = await http.post(uri, headers: headers);
      }

      _parseResponse(res.body, res.statusCode);
    } catch (e) {
      error = e.toString();
      errorMessage = 'Request failed: $e';
    }
  }

  Future<http.Response> postWithResponse(
    String endpoint,
    Map<String, String> headers,
    Map<String, dynamic>? body,
  ) async {
    _clearState();
    final Uri uri = Uri.parse('$url$endpoint');

    try {
      late final http.Response response;

      if (body != null && body.isNotEmpty) {
        response = await http.post(
          uri,
          headers: headers,
          body: jsonEncode(body),
        );
      } else {
        response = await http.post(uri, headers: headers);
      }

      // Update state variables
      _parseResponse(response.body, response.statusCode);

      return response;
    } catch (e) {
      error = e.toString();
      errorMessage = 'Request failed: $e';
      rethrow; // Optional: rethrow so the caller can also handle the error
    }
  }

  Future<void> postForm(String endpoint, Map<String, String> headers,
      Map<String, String> body) async {
    _clearState();
    final Uri uri = Uri.parse('$url$endpoint');

    try {
      final http.MultipartRequest request = http.MultipartRequest('POST', uri)
        ..headers.addAll(headers)
        ..fields.addAll(body);

      final http.StreamedResponse streamedResponse = await request.send();
      final http.Response res =
          await http.Response.fromStream(streamedResponse);

      _parseResponse(res.body, res.statusCode);
    } catch (e) {
      error = e.toString();
      errorMessage = 'Multipart request failed: $e';
    }
  }

  Future<void> get(String endpoint, Map<String, String> headers) async {
    _clearState();
    final Uri uri = Uri.parse('$url$endpoint');

    try {
      final http.Response res = await http.get(uri, headers: headers);
      _parseResponse(res.body, res.statusCode);
    } catch (e) {
      error = e.toString();
      errorMessage = 'GET request failed: $e';
    }
  }

  // The new method for fetching data
  // In your Request class

  Future<http.Response> getWithResponse(
      String endpoint, Map<String, String> headers) async {
    _clearState();
    final Uri uri = Uri.parse('$url$endpoint');

    final response = await http.get(uri, headers: headers);

    // Call _parseResponse here to populate the state variables
    _parseResponse(response.body, response.statusCode);

    return response;
  }

  Future<void> delete(String endpoint, Map<String, String> headers,
      Map<String, dynamic>? body) async {
    _clearState();
    final Uri uri = Uri.parse('$url$endpoint');

    try {
      final http.Response res;

      if (body != null && body.isNotEmpty) {
        res = await http.delete(
          uri,
          headers: headers,
          body: jsonEncode(body),
        );
      } else {
        res = await http.delete(uri, headers: headers);
      }

      _parseResponse(res.body, res.statusCode);
    } catch (e) {
      error = e.toString();
      errorMessage = 'DELETE request failed: $e';
    }
  }

  Future<void> uploadMediaFile({
    required String phoneNumberId,
    required String accessToken,
    required File file,
    required String fileType,
  }) async {
    _clearState();

    try {
      final uri =
          Uri.parse('https://graph.facebook.com/v23.0/$phoneNumberId/media');
      final request = http.MultipartRequest('POST', uri);

      request.headers.addAll({"Authorization": "Bearer $accessToken"});
      request.fields['messaging_product'] = 'whatsapp';

      request.files.add(await http.MultipartFile.fromPath(
        'file',
        file.path,
        contentType: MediaType.parse(fileType),
      ));

      final streamedResponse = await request.send();
      final res = await http.Response.fromStream(streamedResponse);

      _parseResponse(res.body, res.statusCode);
    } catch (e) {
      error = 'Exception uploading media: $e';
      errorMessage = 'Media upload failed: $e';
    }
  }

  Future<void> uploadMediaFileByUrl({
    required String phoneNumberId,
    required String accessToken,
    required String fileUrl,
    required String fileType,
  }) async {
    _clearState();

    try {
      // Download the file from the public URL
      final fileResponse = await http.get(Uri.parse(fileUrl));
      if (fileResponse.statusCode != 200) {
        error = 'Failed to download file: ${fileResponse.statusCode}';
        errorMessage = 'File download failed from URL';
        return;
      }

      final Uint8List fileBytes = fileResponse.bodyBytes;
      final String filename = _getFilenameFromUrl(fileUrl, fileType);

      final uri =
          Uri.parse('https://graph.facebook.com/v23.0/$phoneNumberId/media');
      final request = http.MultipartRequest('POST', uri);

      request.headers.addAll({"Authorization": "Bearer $accessToken"});
      request.fields['type'] = fileType;
      request.fields['messaging_product'] = 'whatsapp';

      final String mimeType = _getMimeTypeFromFileType(fileType, filename);

      request.files.add(http.MultipartFile.fromBytes(
        'file',
        fileBytes,
        filename: filename,
        contentType: MediaType.parse(mimeType),
      ));

      final streamedResponse = await request.send();
      final res = await http.Response.fromStream(streamedResponse);

      _parseResponse(res.body, res.statusCode);

      // Additional validation for successful upload
      if (res.statusCode < 400 && (mediaId == null || mediaId!.isEmpty)) {
        errorMessage = 'No media ID returned in response';
      }
    } catch (e) {
      error = 'Exception uploading media: $e';
      errorMessage = 'Media upload by URL failed: $e';
    }
  }

  Future<http.Response> uploadMediaFileByUrlWithResponse({
    required String phoneNumberId,
    required String accessToken,
    required String fileUrl,
    required String fileType,
  }) async {
    _clearState();

    try {
      // Download the file from the public URL
      final fileResponse = await http.get(Uri.parse(fileUrl));
      if (fileResponse.statusCode != 200) {
        error = 'Failed to download file: ${fileResponse.statusCode}';
        errorMessage = 'File download failed from URL';
        return http.Response('File download failed', fileResponse.statusCode);
      }

      final Uint8List fileBytes = fileResponse.bodyBytes;
      final String filename = _getFilenameFromUrl(fileUrl, fileType);

      final uri =
          Uri.parse('https://graph.facebook.com/v23.0/$phoneNumberId/media');
      final request = http.MultipartRequest('POST', uri);

      request.headers.addAll({"Authorization": "Bearer $accessToken"});
      request.fields['type'] = fileType;
      request.fields['messaging_product'] = 'whatsapp';

      final String mimeType = _getMimeTypeFromFileType(fileType, filename);

      request.files.add(http.MultipartFile.fromBytes(
        'file',
        fileBytes,
        filename: filename,
        contentType: MediaType.parse(mimeType),
      ));

      final streamedResponse = await request.send();
      final res = await http.Response.fromStream(streamedResponse);

      _parseResponse(res.body, res.statusCode);

      // Additional validation for successful upload
      if (res.statusCode < 400 && (mediaId == null || mediaId!.isEmpty)) {
        errorMessage = 'No media ID returned in response';
      }

      return res;
    } catch (e) {
      error = 'Exception uploading media: $e';
      errorMessage = 'Media upload by URL failed: $e';
      return http.Response('Exception: $e', 500);
    }
  }

  Future<void> getMedia(String accessToken, String mediaId) async {
    _clearState();
    final Uri uri = Uri.parse('$url$mediaId');

    try {
      final http.Response res = await http.get(
        uri,
        headers: {'Authorization': 'Bearer $accessToken'},
      );

      _parseResponse(res.body, res.statusCode);
    } catch (e) {
      error = e.toString();
      errorMessage = 'Get media request failed: $e';
    }
  }

  Future<http.Response> getMediaWithResponse(
    String accessToken,
    String mediaId,
  ) async {
    _clearState();
    final Uri uri = Uri.parse('$url$mediaId');

    try {
      final http.Response res = await http.get(
        uri,
        headers: {'Authorization': 'Bearer $accessToken'},
      );

      _parseResponse(res.body, res.statusCode);

      return res;
    } catch (e) {
      error = e.toString();
      errorMessage = 'Get media request failed: $e';
      return http.Response('Exception: $e', 500);
    }
  }

  Future<void> deleteMedia(String accessToken, String mediaId) async {
    _clearState();
    final Uri uri = Uri.parse('$url$mediaId');

    try {
      final http.Response res = await http.delete(
        uri,
        headers: {'Authorization': 'Bearer $accessToken'},
      );

      _parseResponse(res.body, res.statusCode);
    } catch (e) {
      error = e.toString();
      errorMessage = 'Delete media request failed: $e';
    }
  }

  Future<http.Response> deleteMediaWithResponse(
    String accessToken,
    String mediaId,
  ) async {
    _clearState();
    final Uri uri = Uri.parse('$url$mediaId');

    try {
      final http.Response res = await http.delete(
        uri,
        headers: {'Authorization': 'Bearer $accessToken'},
      );

      _parseResponse(res.body, res.statusCode);

      return res;
    } catch (e) {
      error = e.toString();
      errorMessage = 'Delete media request failed: $e';
      return http.Response('Exception: $e', 500);
    }
  }

  /// Method to set custom version of the Facebook Graph API.
  /// [version] The version of the Facebook Graph API to use ex. v19.0
  void setVersion(String version) {
    url = 'https://graph.facebook.com/$version/';
  }

  /// Check if the request was successful. Returns true if the HTTP status code is between 200-299
  bool isSuccess() {
    return httpCode != null && httpCode! >= 200 && httpCode! < 300;
  }

  /// Get the HTTP status code. Returns null if the request has not been made yet.
  int? getHttpCode() {
    return httpCode;
  }

  /// Get the error message. Returns null if the request has not been made yet or if there was no error
  String? getError() {
    return error;
  }

  /// Get the error message. Returns null if the request has not been made yet or if there was no error
  String? getErrorMessage() {
    return errorMessage;
  }

  /// Get the message ID. Returns null if the request has not been made yet or if there was no message ID
  String? getMessageId() {
    return messageId;
  }

  /// Get the phone number. Returns null if the request has not been made yet or if there was no phone number
  String? getPhoneNumber() {
    return phoneNumber;
  }

  /// Get the response as a Map. Returns null if the request has not been made yet.
  Map<String, dynamic>? getResponse() {
    if (response == null || response!.isEmpty) return null;

    try {
      return jsonDecode(response!);
    } catch (e) {
      return null;
    }
  }

  /// Get uploaded media ID. Returns null if the request has not been made yet or if there was no media ID
  String? getMediaId() {
    return mediaId;
  }

  /// Get uploaded media URL. Returns null if the request has not been made yet or if there was no media URL
  String? getMediaUrl() {
    return mediaUrl;
  }

  /// Get uploaded media MIME type. Returns null if the request has not been made yet or if there was no MIME type
  String? getMediaMimeType() {
    return mediaMimeType;
  }

  /// Get uploaded media SHA-256 hash. Returns null if the request has not been made yet or if there was no hash
  String? getMediaSha256() {
    return mediaSha256;
  }

  /// Get uploaded media file size. Returns null if the request has not been made yet or if there was no file size
  String? getMediaFileSize() {
    return mediaFileSize;
  }

  // Helper function to extract filename from URL
  String _getFilenameFromUrl(String fileUrl, String fileType) {
    try {
      final Uri uri = Uri.parse(fileUrl);
      String filename =
          uri.pathSegments.isNotEmpty ? uri.pathSegments.last : '';

      // If no filename from URL or no extension, generate one
      if (filename.isEmpty || !filename.contains('.')) {
        final String extension = _getFileExtensionFromMimeType(fileType);
        filename = 'upload$extension';
      }

      return filename;
    } catch (e) {
      // Fallback if URL parsing fails
      final String extension = _getFileExtensionFromMimeType(fileType);
      return 'upload$extension';
    }
  }

  // Helper function to get MIME type
  String _getMimeTypeFromFileType(String fileType, String filename) {
    // If fileType is already a valid MIME type, use it
    if (fileType.contains('/')) {
      return fileType;
    }

    // Try to determine from filename extension
    if (filename.contains('.')) {
      final String extension = filename.toLowerCase().split('.').last;
      final String mimeFromExtension = _getMimeTypeFromExtension(extension);
      if (mimeFromExtension.isNotEmpty) {
        return mimeFromExtension;
      }
    }

    // Fallback mapping based on common fileType values
    switch (fileType.toLowerCase()) {
      case 'image':
        return 'image/jpeg';
      case 'video':
        return 'video/mp4';
      case 'audio':
        return 'audio/mpeg';
      case 'document':
        return 'application/pdf';
      default:
        return 'application/octet-stream';
    }
  }

  // Helper function to get MIME type from file extension
  String _getMimeTypeFromExtension(String extension) {
    switch (extension.toLowerCase()) {
      // Images
      case 'jpg':
      case 'jpeg':
        return 'image/jpeg';
      case 'png':
        return 'image/png';
      case 'gif':
        return 'image/gif';
      case 'webp':
        return 'image/webp';
      case 'bmp':
        return 'image/bmp';
      case 'svg':
        return 'image/svg+xml';

      // Videos
      case 'mp4':
        return 'video/mp4';
      case 'avi':
        return 'video/x-msvideo';
      case 'mov':
        return 'video/quicktime';
      case 'wmv':
        return 'video/x-ms-wmv';
      case 'webm':
        return 'video/webm';

      // Audio
      case 'mp3':
        return 'audio/mpeg';
      case 'wav':
        return 'audio/wav';
      case 'ogg':
        return 'audio/ogg';
      case 'aac':
        return 'audio/aac';

      // Documents
      case 'pdf':
        return 'application/pdf';
      case 'doc':
        return 'application/msword';
      case 'docx':
        return 'application/vnd.openxmlformats-officedocument.wordprocessingml.document';
      case 'xls':
        return 'application/vnd.ms-excel';
      case 'xlsx':
        return 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet';
      case 'ppt':
        return 'application/vnd.ms-powerpoint';
      case 'pptx':
        return 'application/vnd.openxmlformats-officedocument.presentationml.presentation';
      case 'txt':
        return 'text/plain';

      default:
        return '';
    }
  }

  // Helper function to get file extension from MIME type
  String _getFileExtensionFromMimeType(String mimeType) {
    switch (mimeType.toLowerCase()) {
      case 'image':
      case 'image/jpeg':
        return '.jpg';
      case 'image/png':
        return '.png';
      case 'image/gif':
        return '.gif';
      case 'image/webp':
        return '.webp';
      case 'video':
      case 'video/mp4':
        return '.mp4';
      case 'video/quicktime':
        return '.mov';
      case 'audio':
      case 'audio/mpeg':
        return '.mp3';
      case 'audio/wav':
        return '.wav';
      case 'document':
      case 'application/pdf':
        return '.pdf';
      case 'text/plain':
        return '.txt';
      default:
        return '.bin';
    }
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
