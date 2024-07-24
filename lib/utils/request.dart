import 'dart:convert';
import 'dart:io';
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
  String url = 'https://graph.facebook.com/v19.0/';

  Future<void> post(String endpoint, Map<String, String> headers,
      Map<String, dynamic>? body) async {
    final Uri uri = Uri.parse('$url$endpoint');

    try {
      final http.Response res = await (body!.isNotEmpty
          ? http.post(
              uri,
              headers: headers,
              body: jsonEncode(body),
            )
          : http.post(
              uri,
              headers: headers,
            ));

      response = res.body;
      httpCode = res.statusCode;

      final Map<String, dynamic> jsonResponse = jsonDecode(response!);

      errorMessage = jsonResponse['error']?['message'];
      messageId = jsonResponse['messages']?[0]?['id'];
      phoneNumber = jsonResponse['contacts']?[0]?['input'];

      if (res.statusCode >= 400) {
        error = res.reasonPhrase;
      }
    } catch (e) {
      error = e.toString();
      // throw ('An error occurred: $error');
    }
  }

  Future<void> postForm(String endpoint, Map<String, String> headers,
      Map<String, String> body) async {
    final Uri uri = Uri.parse('$url$endpoint');

    try {
      final http.MultipartRequest request = http.MultipartRequest('POST', uri)
        ..headers.addAll(headers)
        ..fields.addAll(body);

      final http.StreamedResponse streamedResponse = await request.send();
      final http.Response res =
          await http.Response.fromStream(streamedResponse);

      response = res.body;
      httpCode = res.statusCode;

      final Map<String, dynamic> jsonResponse = jsonDecode(response!);

      errorMessage = jsonResponse['error']?['message'];

      if (res.statusCode >= 400) {
        error = res.reasonPhrase;
      }
    } catch (e) {
      error = e.toString();
    }
  }

  Future<void> get(String endpoint, Map<String, String> headers) async {
    final Uri uri = Uri.parse('$url$endpoint');

    try {
      final http.Response res = await http.get(
        uri,
        headers: headers,
      );

      response = res.body;
      httpCode = res.statusCode;

      final Map<String, dynamic> jsonResponse = jsonDecode(response!);

      errorMessage = jsonResponse['error']?['message'];
      messageId = jsonResponse['messages']?[0]?['id'];
      phoneNumber = jsonResponse['input']?[0]?['to'];

      if (res.statusCode >= 400) {
        error = res.reasonPhrase;
      }
    } catch (e) {
      error = e.toString();
    }
  }

  Future<void> uploadMediaFile({
    required String phoneNumberId,
    required String accessToken,
    required File file,
    required String fileType,
  }) async {
    try {
      var uri =
          Uri.parse('https://graph.facebook.com/v20.0/$phoneNumberId/media');

      var request = http.MultipartRequest('POST', uri);
      request.headers.addAll({"Authorization": "Bearer $accessToken"});
      request.fields['messaging_product'] = 'whatsapp';
      request.files.add(await http.MultipartFile.fromPath(
        'file',
        file.path,
        contentType: MediaType.parse(fileType),
      ));

      var resp = await request.send();
      var res = await http.Response.fromStream(resp);

      httpCode = res.statusCode;
      response = res.body;

      if (res.statusCode >= 400) {
        // Handle error status codes
        var jsonResponse = jsonDecode(res.body);
        errorMessage = jsonResponse['error']?['message'] ?? 'Unknown error';
      } else {
        // Handle successful response
        var jsonResponse = jsonDecode(res.body);
        mediaId = jsonResponse['id'] ?? '';
      }
    } catch (e) {
      // Handle exceptions
      error = 'Exception uploading media: $e';
    }
  }

  Future<void> getMedia(String accessToken, String mediaId) async {
    final Uri uri = Uri.parse('$url$mediaId');

    try {
      final http.Response res = await http.get(
        uri,
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      );

      response = res.body;
      httpCode = res.statusCode;

      final Map<String, dynamic> jsonResponse = jsonDecode(response!);

      errorMessage = jsonResponse['error']?['message'];
      mediaFileSize = jsonResponse['file_size']?.toString() ?? '';
      mediaMimeType = jsonResponse['mime_type'] ?? '';
      mediaSha256 = jsonResponse['sha256'] ?? '';
      mediaUrl = jsonResponse['url'] ?? '';
      mediaId = jsonResponse['id'] ?? '';

      if (res.statusCode >= 400) {
        error = res.reasonPhrase;
      }
    } catch (e) {
      error = e.toString();
    }
  }

  Future<void> deleteMedia(String accessToken, String mediaId) async {
    final Uri uri = Uri.parse('$url$mediaId');

    try {
      final http.Response res = await http.delete(
        uri,
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      );

      response = res.body;
      httpCode = res.statusCode;

      final Map<String, dynamic> jsonResponse = jsonDecode(response!);

      errorMessage = jsonResponse['error']?['message'];

      if (res.statusCode >= 400) {
        error = res.reasonPhrase;
      }
    } catch (e) {
      error = e.toString();
    }
  }

  /// Method to set custom version of the Facebook Graph API.
  /// [version] The version of the Facebook Graph API to use ex. v19.0
  void setVersion(String version) {
    url = 'https://graph.facebook.com/$version/';
  }

  /// Check if the request was successful. Returns true if the HTTP status code is between 200
  bool isSuccess() {
    return httpCode != null && httpCode! >= 200 && httpCode! < 300;
  }

  /// Get the HTTP status code. Returns null if the request has not been made yet.
  int? getHttpCode() {
    return httpCode;
  }

  /// Get the error message. Returns null if the request has not been made yet or if there was
  String? getError() {
    return error;
  }

  /// Get the error message. Returns null if the request has not been made yet or if there was
  String? getErrorMessage() {
    return errorMessage;
  }

  /// Get the message ID. Returns null if the request has not been made yet or if there was
  String? getMessageId() {
    return messageId;
  }

  /// Get the phone number. Returns null if the request has not been made yet or if there was
  String? getPhoneNumber() {
    return phoneNumber;
  }

  /// Get the response as a Map. Returns null if the request has not been made yet.
  Map<String, dynamic>? getResponse() {
    return response != null ? jsonDecode(response!) : null;
  }

  /// Get Uploaded media ID. Returns null if the request has not been made yet or if there was
  String? getMediaId() {
    return mediaId;
  }

  /// Get Uploaded media URL. Returns null if the request has not been made yet or if there was
  String? getMediaUrl() {
    return mediaUrl;
  }

  /// Get Uploaded media MIME type. Returns null if the request has not been made yet or if there was
  String? getMediaMimeType() {
    return mediaMimeType;
  }

  /// Get Uploaded media SHA-256 hash. Returns null if the request has not been made yet or if there was
  String? getMediaSha256() {
    return mediaSha256;
  }

  /// Get Uploaded media file size. Returns null if the request has not been made yet or if there was
  String? getMediaFileSize() {
    return mediaFileSize;
  }
}
