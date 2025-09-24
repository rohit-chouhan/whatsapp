import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:whatsapp/utils/exception.dart';
import 'package:whatsapp/utils/request.dart';
import 'package:whatsapp/utils/response/media_delete_response.dart';
import 'package:whatsapp/utils/response/media_get_response.dart';
import 'package:whatsapp/utils/response/media_upload_response.dart';

class MediaService {
  final String accessToken;
  final String fromNumberId;
  final Request request;

  MediaService(this.accessToken, this.fromNumberId, this.request);

  Future<Request> uploadMediaFile(File file, String fileType) async {
    await request.uploadMediaFile(
        accessToken: accessToken,
        phoneNumberId: fromNumberId,
        file: file,
        fileType: fileType);
    return request;
  }

  Future<MediaUploadResponse> uploadMediaFileByUrl(
      String fileUrl, String fileType) async {
    try {
      final http.Response response =
          await request.uploadMediaFileByUrlWithResponse(
              accessToken: accessToken,
              phoneNumberId: fromNumberId,
              fileUrl: fileUrl,
              fileType: fileType);

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseBody = jsonDecode(response.body);
        final MediaUploadResponse parsedResponse =
            MediaUploadResponse.fromJson(responseBody);
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

  Future<MediaGetResponse> getMedia(String mediaId) async {
    try {
      final http.Response response =
          await request.getMediaWithResponse(accessToken, mediaId);

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseBody = jsonDecode(response.body);
        final MediaGetResponse parsedResponse =
            MediaGetResponse.fromJson(responseBody);
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

  Future<MediaDeleteResponse> deleteMedia(String mediaId) async {
    try {
      final http.Response response =
          await request.deleteMediaWithResponse(accessToken, mediaId);

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseBody = jsonDecode(response.body);
        final MediaDeleteResponse parsedResponse =
            MediaDeleteResponse.fromJson(responseBody);
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
