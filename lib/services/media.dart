import 'dart:io';

import 'package:whatsapp/utils/request.dart';

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

  Future<Request> uploadMediaFileByUrl(String fileUrl, String fileType) async {
    await request.uploadMediaFileByUrl(
        accessToken: accessToken,
        phoneNumberId: fromNumberId,
        fileUrl: fileUrl,
        fileType: fileType);
    return request;
  }

  Future<Request> getMedia(String mediaId) async {
    await request.getMedia(accessToken, mediaId);
    return request;
  }

  Future<Request> deleteMedia(String mediaId) async {
    await request.deleteMedia(accessToken, mediaId);
    return request;
  }
}
