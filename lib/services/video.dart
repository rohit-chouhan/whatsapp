import 'package:whatsapp/services/base_service.dart';
import 'package:whatsapp/utils/response/whatsapp_response.dart';

class VideoService extends BaseService {
  VideoService(super.accessToken, super.fromNumberId, super.request);

  Future<WhatsAppResponse> sendVideoById(
      String phoneNumber, String mediaId, String? caption) async {
    final videoContent = {'id': mediaId};
    if (caption != null) {
      videoContent['caption'] = caption;
    }

    final body = createMessageBody('video', phoneNumber, videoContent);

    return executeApiCall(
      () => request.postWithResponse('$fromNumberId/messages', headers, body),
      (json) => WhatsAppResponse.fromJson(json),
    );
  }

  Future<WhatsAppResponse> sendVideoByUrl(
      String phoneNumber, String link, String? caption) async {
    final videoContent = {'link': link};
    if (caption != null) {
      videoContent['caption'] = caption;
    }

    final body = createMessageBody('video', phoneNumber, videoContent);

    return executeApiCall(
      () => request.postWithResponse('$fromNumberId/messages', headers, body),
      (json) => WhatsAppResponse.fromJson(json),
    );
  }
}
