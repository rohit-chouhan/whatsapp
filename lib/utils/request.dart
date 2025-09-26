import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

/// A utility class for making HTTP requests to the WhatsApp Cloud API.
/// Handles request execution, response parsing, and error management.
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

    // Reset error fields
    error = null;
    errorMessage = null;

    if (responseBody.isNotEmpty) {
      try {
        final Map<String, dynamic> jsonResponse = jsonDecode(responseBody);

        // Parse error information
        if (jsonResponse.containsKey('error')) {
          final errorData = jsonResponse['error'];
          if (errorData is Map) {
            error = errorData['type'] ?? 'API Error';
            errorMessage = errorData['message'] ?? 'Unknown API error';
          }
        }

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
        error = 'Parse Error';
        errorMessage = 'Failed to parse response: $e';
      }
    }

    // Set error for HTTP error codes if not already set
    if (statusCode >= 400 && error == null) {
      error = 'HTTP Error';
      errorMessage ??= 'HTTP $statusCode error';
    }
  }

  Future<http.Response> _performPost(String endpoint,
      Map<String, String> headers, Map<String, dynamic>? body) async {
    final Uri uri = Uri.parse('$url$endpoint');

    if (body != null && body.isNotEmpty) {
      return await http.post(
        uri,
        headers: headers,
        body: jsonEncode(body),
      );
    } else {
      return await http.post(uri, headers: headers);
    }
  }

  Future<http.Response> postWithResponse(
    String endpoint,
    Map<String, String> headers,
    Map<String, dynamic>? body,
  ) async {
    _clearState();

    try {
      final http.Response response =
          await _performPost(endpoint, headers, body);
      _parseResponse(response.body, response.statusCode);
      return response;
    } catch (e) {
      error = 'Network Error';
      errorMessage = 'POST request failed: $e';
      return http.Response('Exception: $e', 500);
    }
  }

  Future<http.Response> _performPostForm(String endpoint,
      Map<String, String> headers, Map<String, String> body) async {
    final Uri uri = Uri.parse('$url$endpoint');

    final http.MultipartRequest request = http.MultipartRequest('POST', uri)
      ..headers.addAll(headers)
      ..fields.addAll(body);

    final http.StreamedResponse streamedResponse = await request.send();
    return await http.Response.fromStream(streamedResponse);
  }

  Future<http.Response> postFormWithResponse(
    String endpoint,
    Map<String, String> headers,
    Map<String, String> body,
  ) async {
    _clearState();

    try {
      final http.Response res = await _performPostForm(endpoint, headers, body);
      _parseResponse(res.body, res.statusCode);
      return res;
    } catch (e) {
      error = 'Network Error';
      errorMessage = 'Multipart request failed: $e';
      return http.Response('Exception: $e', 500);
    }
  }

  Future<http.Response> _performGet(
      String endpoint, Map<String, String> headers) async {
    final Uri uri = Uri.parse('$url$endpoint');
    return await http.get(uri, headers: headers);
  }

  Future<http.Response> getWithResponse(
      String endpoint, Map<String, String> headers) async {
    _clearState();

    try {
      final response = await _performGet(endpoint, headers);
      _parseResponse(response.body, response.statusCode);
      return response;
    } catch (e) {
      error = 'Network Error';
      errorMessage = 'GET request failed: $e';
      return http.Response('Exception: $e', 500);
    }
  }

  Future<http.Response> _performDelete(String endpoint,
      Map<String, String> headers, Map<String, dynamic>? body) async {
    final Uri uri = Uri.parse('$url$endpoint');

    if (body != null && body.isNotEmpty) {
      return await http.delete(
        uri,
        headers: headers,
        body: jsonEncode(body),
      );
    } else {
      return await http.delete(uri, headers: headers);
    }
  }

  Future<http.Response> deleteWithResponse(
    String endpoint,
    Map<String, String> headers,
    Map<String, dynamic>? body,
  ) async {
    _clearState();

    try {
      final http.Response res = await _performDelete(endpoint, headers, body);
      _parseResponse(res.body, res.statusCode);
      return res;
    } catch (e) {
      error = 'Network Error';
      errorMessage = 'DELETE request failed: $e';
      return http.Response('Exception: $e', 500);
    }
  }

  Future<http.Response> uploadMediaFile({
    required String phoneNumberId,
    required String accessToken,
    required dynamic file,
    required String fileType,
  }) async {
    _clearState();

    try {
      final uri =
          Uri.parse('https://graph.facebook.com/v23.0/$phoneNumberId/media');
      final request = http.MultipartRequest('POST', uri);

      request.headers.addAll({"Authorization": "Bearer $accessToken"});
      request.fields['messaging_product'] = 'whatsapp';

      if (file is List<int>) {
        // Web or bytes: use fromBytes
        final filename = _getDefaultFilename(fileType);
        request.files.add(http.MultipartFile.fromBytes(
          'file',
          file,
          filename: filename,
          contentType: MediaType.parse(fileType),
        ));
      } else {
        // Assume File (native)
        request.files.add(await http.MultipartFile.fromPath(
          'file',
          file.path,
          contentType: MediaType.parse(fileType),
        ));
      }

      final streamedResponse = await request.send();
      final res = await http.Response.fromStream(streamedResponse);

      _parseResponse(res.body, res.statusCode);
      return res;
    } catch (e) {
      error = 'Exception uploading media: $e';
      errorMessage = 'Media upload failed: $e';
      return http.Response('Exception: $e', 500);
    }
  }

  Future<http.Response> _performUploadMediaByUrl({
    required String phoneNumberId,
    required String accessToken,
    required String fileUrl,
    required String fileType,
  }) async {
    // Download the file from the public URL
    final fileResponse = await http.get(Uri.parse(fileUrl));
    if (fileResponse.statusCode != 200) {
      throw Exception('Failed to download file: ${fileResponse.statusCode}');
    }

    final Uint8List fileBytes = fileResponse.bodyBytes;
    final String filename = _getFilenameFromUrl(fileUrl, fileType);

    final uri =
        Uri.parse('https://graph.facebook.com/v23.0/$phoneNumberId/media');
    final request = http.MultipartRequest('POST', uri);

    request.headers.addAll({"Authorization": "Bearer $accessToken"});
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

    return res;
  }

  Future<void> uploadMediaFileByUrl({
    required String phoneNumberId,
    required String accessToken,
    required String fileUrl,
    required String fileType,
  }) async {
    _clearState();

    try {
      final http.Response res = await _performUploadMediaByUrl(
        phoneNumberId: phoneNumberId,
        accessToken: accessToken,
        fileUrl: fileUrl,
        fileType: fileType,
      );
      _parseResponse(res.body, res.statusCode);

      // Additional validation for successful upload
      if (httpCode! < 400 && (mediaId == null || mediaId!.isEmpty)) {
        error = 'Upload Error';
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
      final http.Response res = await _performUploadMediaByUrl(
        phoneNumberId: phoneNumberId,
        accessToken: accessToken,
        fileUrl: fileUrl,
        fileType: fileType,
      );
      _parseResponse(res.body, res.statusCode);

      // Additional validation for successful upload
      if (httpCode! < 400 && (mediaId == null || mediaId!.isEmpty)) {
        error = 'Upload Error';
        errorMessage = 'No media ID returned in response';
      }

      return res;
    } catch (e) {
      error = 'Network Error';
      errorMessage = 'Media upload by URL failed: $e';
      return http.Response('Exception: $e', 500);
    }
  }

  Future<http.Response> _performGetMedia(
      String accessToken, String mediaId) async {
    final Uri uri = Uri.parse('$url$mediaId');
    return await http.get(
      uri,
      headers: {'Authorization': 'Bearer $accessToken'},
    );
  }

  Future<void> getMedia(String accessToken, String mediaId) async {
    _clearState();

    try {
      final http.Response res = await _performGetMedia(accessToken, mediaId);
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

    try {
      final http.Response res = await _performGetMedia(accessToken, mediaId);
      _parseResponse(res.body, res.statusCode);
      return res;
    } catch (e) {
      error = 'Network Error';
      errorMessage = 'Get media request failed: $e';
      return http.Response('Exception: $e', 500);
    }
  }

  Future<http.Response> _performDeleteMedia(
      String accessToken, String mediaId) async {
    final Uri uri = Uri.parse('$url$mediaId');
    return await http.delete(
      uri,
      headers: {'Authorization': 'Bearer $accessToken'},
    );
  }

  Future<void> deleteMedia(String accessToken, String mediaId) async {
    _clearState();

    try {
      final http.Response res = await _performDeleteMedia(accessToken, mediaId);
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

    try {
      final http.Response res = await _performDeleteMedia(accessToken, mediaId);
      _parseResponse(res.body, res.statusCode);
      return res;
    } catch (e) {
      error = 'Network Error';
      errorMessage = 'Delete media request failed: $e';
      return http.Response('Exception: $e', 500);
    }
  }

  /// Method to set custom version of the Facebook Graph API.
  /// [version] The version of the Facebook Graph API to use ex. v19.0
  void setVersion(String version) {
    url = 'https://graph.facebook.com/$version/';
  }

  /// Uploads a binary file in chunks to the specified URL.
  Future<http.Response> uploadBinaryFile(
      {required String path,
      required String accessToken,
      dynamic file,
      required String fileUrl,
      required String fileType}) async {
    try {
      Uint8List bytes;
      final uri = Uri.parse('$url$path');
      if (fileUrl.isEmpty) {
        bytes = await file.readAsBytes();
      } else {
        final fileResponse = await http.get(Uri.parse(fileUrl));
        if (fileResponse.statusCode != 200) {
          throw Exception(
              'Failed to download file: ${fileResponse.statusCode}');
        }
        bytes = fileResponse.bodyBytes;
      }

      final request = http.Request('POST', uri);

      // Add headers
      request.headers.addAll({
        "Authorization": "Bearer $accessToken",
        "file_offset": "0",
        "Content-Type": fileType,
      });

      // Add file bytes to body
      request.bodyBytes = bytes;

      // Send request
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      return response;
    } catch (e) {
      return http.Response('Exception: $e', 500);
    }
  }

  // Helper function to extract filename from URL
  String _getFilenameFromUrl(String fileUrl, String fileType) {
    try {
      final Uri uri = Uri.parse(fileUrl);
      String filename =
          uri.pathSegments.isNotEmpty ? uri.pathSegments.last : '';

      // If no filename or filename is just an extension, generate one
      if (filename.isEmpty ||
          filename.startsWith('.') ||
          !filename.contains('.') ||
          filename.split('.').length == 1) {
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
      case 'sticker':
        return 'image/webp';
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

  // Helper function to get default filename from MIME type
  String _getDefaultFilename(String mimeType) {
    final extension = _getFileExtensionFromMimeType(mimeType);
    return 'upload$extension';
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

  // Automatically determine the MIME type based on the file extension.
  String getAutoFileType(String filePath) {
    // Extract extension (without dot, and lowercase)
    final ext = filePath.split('.').last.toLowerCase();

    // Mapping of extensions to MIME types
    const mimeTypes = {
      // Audio
      'aac': 'audio/aac',
      'amr': 'audio/amr',
      'mp3': 'audio/mpeg',
      'm4a': 'audio/mp4',
      'ogg': 'audio/ogg',

      // Document
      'txt': 'text/plain',
      'xls': 'application/vnd.ms-excel',
      'xlsx':
          'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
      'doc': 'application/msword',
      'docx':
          'application/vnd.openxmlformats-officedocument.wordprocessingml.document',
      'ppt': 'application/vnd.ms-powerpoint',
      'pptx':
          'application/vnd.openxmlformats-officedocument.presentationml.presentation',
      'pdf': 'application/pdf',

      // Image
      'jpeg': 'image/jpeg',
      'jpg': 'image/jpeg',
      'png': 'image/png',

      // Sticker
      'webp': 'image/webp',

      // Video
      '3gp': 'video/3gp',
      'mp4': 'video/mp4',
    };

    return mimeTypes[ext] ?? 'application/octet-stream';
  }
}
