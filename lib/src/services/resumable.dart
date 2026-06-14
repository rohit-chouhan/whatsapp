import 'package:whatsapp/src/services/base_service.dart';
import 'package:whatsapp/src/utils/response/whatsapp_resumable_upload_response.dart';
import 'package:whatsapp/src/utils/exception.dart';

class ResumableService extends BaseService {
  ResumableService(super.accessToken, super.fromNumberId, super.request);

  Future<WhatsAppResumableUploadResponse> createResumableUploadSession(
      {required int fileLength, required fileType, String? fileName}) async {
    var url = 'app/uploads?file_length=$fileLength&file_type=$fileType';
    if (fileName != null && fileName.isNotEmpty) {
      url += '&file_name=$fileName';
    }
    
    return executeApiCall(
      () => request.postWithResponse(url, headers, {}),
      (json) => WhatsAppResumableUploadResponse.fromJson(json),
    );
  }

  Future<WhatsAppResumableUploadResponse> getResumableUploadSession(
      {required String uploadId}) async {
    return executeApiCall(
      () => request.getWithResponse(uploadId, headers),
      (json) => WhatsAppResumableUploadResponse.fromJson(json),
    );
  }

  Future<WhatsAppResumableUploadResponse> uploadResumableFile(
      {required String uploadId,
      dynamic file,
      required String fileType}) async {
    return executeApiCall(
      () => request.uploadBinaryFile(
          path: uploadId,
          accessToken: accessToken,
          file: file,
          fileType: fileType,
          fileUrl: ''),
      (json) => WhatsAppResumableUploadResponse.fromJson(json),
    );
  }

  Future<WhatsAppResumableUploadResponse> uploadResumableFileByUrl(
      {required String uploadId,
      required String fileUrl,
      required String fileType}) async {
    return executeApiCall(
      () => request.uploadBinaryFile(
          path: uploadId,
          accessToken: accessToken,
          fileType: fileType,
          fileUrl: fileUrl),
      (json) => WhatsAppResumableUploadResponse.fromJson(json),
    );
  }

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
