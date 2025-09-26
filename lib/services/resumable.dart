import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:whatsapp/utils/exception.dart';
import 'package:whatsapp/utils/request.dart';
import 'package:whatsapp/utils/response/whatsapp_resumable_upload_response.dart';

/// Service to handle resumable uploads to WhatsApp.
/// This service provides methods to create a resumable upload session.
class ResumableService {
  final String accessToken;
  final String fromNumberId;
  final Request request;

  ResumableService(this.accessToken, this.fromNumberId, this.request);

  Future<WhatsAppResumableUploadResponse> createResumableUploadSession(
      {required int fileLength, required fileType, String? fileName}) async {
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };

    var url = 'app/uploads?file_length=$fileLength&file_type=$fileType';
    if (fileName != null && fileName.isNotEmpty) {
      url += '&file_name=$fileName';
    }
    try {
      final http.Response response =
          await request.postWithResponse(url, headers, {});

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseBody = jsonDecode(response.body);
        final WhatsAppResumableUploadResponse parsedResponse =
            WhatsAppResumableUploadResponse.fromJson(responseBody);
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

  Future<WhatsAppResumableUploadResponse> getResumableUploadSession(
      {required String uploadId}) async {
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };

    var path = uploadId;
    final http.Response response = await request.getWithResponse(path, headers);
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseBody = jsonDecode(response.body);
      final WhatsAppResumableUploadResponse parsedResponse =
          WhatsAppResumableUploadResponse.fromJson(responseBody);
      return parsedResponse;
    } else {
      // Throw a more specific exception using the factory constructor
      throw WhatsAppException.fromResponse(response);
    }
  }

  Future<WhatsAppResumableUploadResponse> uploadResumableFile(
      {required String uploadId,
      dynamic file,
      required String fileType}) async {
    var path = uploadId;
    final http.Response response = await request.uploadBinaryFile(
        path: path,
        accessToken: accessToken,
        file: file,
        fileType: fileType,
        fileUrl: '');
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseBody = jsonDecode(response.body);
      final WhatsAppResumableUploadResponse parsedResponse =
          WhatsAppResumableUploadResponse.fromJson(responseBody);
      return parsedResponse;
    } else {
      // Throw a more specific exception using the factory constructor
      throw WhatsAppException.fromResponse(response);
    }
  }

  Future<WhatsAppResumableUploadResponse> uploadResumableFileByUrl(
      {required String uploadId,
      required String fileUrl,
      required String fileType}) async {
    var path = uploadId;
    final http.Response response = await request.uploadBinaryFile(
        path: path,
        accessToken: accessToken,
        fileType: fileType,
        fileUrl: fileUrl);
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseBody = jsonDecode(response.body);
      final WhatsAppResumableUploadResponse parsedResponse =
          WhatsAppResumableUploadResponse.fromJson(responseBody);
      return parsedResponse;
    } else {
      // Throw a more specific exception using the factory constructor
      throw WhatsAppException.fromResponse(response);
    }
  }

//createUploadResumableFile create and upload file in one step with proper execution handing
  Future<WhatsAppResumableUploadResponse> createUploadResumableFile(
      {required int fileLength,
      dynamic file,
      String fileUrl = '',
      required String fileType,
      String? fileName}) async {
    var session = await createResumableUploadSession(
        fileLength: fileLength, fileType: fileType, fileName: fileName);
    var uploadId = session.getId();
    if (uploadId.isEmpty) {
      throw WhatsAppException('Failed to create upload session');
    }
    if (fileUrl.isNotEmpty) {
      return await uploadResumableFileByUrl(
          uploadId: uploadId, fileUrl: fileUrl, fileType: fileType);
    } else {
      return await uploadResumableFile(
          uploadId: uploadId, file: file, fileType: fileType);
    }
  }
}
