import 'package:whatsapp/services/base_service.dart';
import 'package:whatsapp/utils/response/whatsapp_response.dart';

class ImageService extends BaseService {
  ImageService(super.accessToken, super.fromNumberId, super.request);

  Future<WhatsAppResponse> sendImageById(
      String phoneNumber, String mediaId, String? caption) async {
    final imageContent = {'id': mediaId};
    if (caption != null) {
      imageContent['caption'] = caption;
    }

    final body = createMessageBody('image', phoneNumber, imageContent);

    return executeApiCall(
      () => request.postWithResponse('$fromNumberId/messages', headers, body),
      (json) => WhatsAppResponse.fromJson(json),
    );
  }

  Future<WhatsAppResponse> sendImageByUrl(
      String phoneNumber, String link, String? caption) async {
    final imageContent = {'link': link};
    if (caption != null) {
      imageContent['caption'] = caption;
    }

    final body = createMessageBody('image', phoneNumber, imageContent);

    return executeApiCall(
      () => request.postWithResponse('$fromNumberId/messages', headers, body),
      (json) => WhatsAppResponse.fromJson(json),
    );
  }
}
