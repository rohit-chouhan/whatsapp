import 'package:whatsapp/src/services/base_service.dart';
import 'package:whatsapp/src/utils/response/whatsapp_media_delete_response.dart';
import 'package:whatsapp/src/utils/response/whatsapp_media_get_response.dart';
import 'package:whatsapp/src/utils/response/whatsapp_media_upload_response.dart';

class MediaService extends BaseService {
  MediaService(super.accessToken, super.fromNumberId, super.request);

  Future<WhatsAppMediaUploadResponse> uploadMediaFile(
      dynamic file, String fileType) async {
    return executeApiCall(
      () => request.uploadMediaFile(
          accessToken: accessToken,
          phoneNumberId: fromNumberId,
          file: file,
          fileType: fileType),
      (json) => WhatsAppMediaUploadResponse.fromJson(json),
    );
  }

  Future<WhatsAppMediaUploadResponse> uploadMediaFileByUrl(
      String fileUrl, String? fileType) async {
    return executeApiCall(
      () => request.uploadMediaFileByUrlWithResponse(
          accessToken: accessToken,
          phoneNumberId: fromNumberId,
          fileUrl: fileUrl,
          fileType: fileType!),
      (json) => WhatsAppMediaUploadResponse.fromJson(json),
    );
  }

  Future<WhatsAppMediaGetResponse> getMedia(String mediaId) async {
    return executeApiCall(
      () => request.getMediaWithResponse(accessToken, mediaId),
      (json) => WhatsAppMediaGetResponse.fromJson(json),
    );
  }

  Future<WhatsAppMediaDeleteResponse> deleteMedia(String mediaId) async {
    return executeApiCall(
      () => request.deleteMediaWithResponse(accessToken, mediaId),
      (json) => WhatsAppMediaDeleteResponse.fromJson(json),
    );
  }
}
