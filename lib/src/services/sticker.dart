import 'package:whatsapp/src/services/base_service.dart';
import 'package:whatsapp/src/utils/response/whatsapp_response.dart';

class StickerService extends BaseService {
  StickerService(super.accessToken, super.fromNumberId, super.request);

  Future<WhatsAppResponse> sendStickerById(
      String phoneNumber, String mediaId) async {
    final stickerContent = {'id': mediaId};

    final body = createMessageBody('sticker', phoneNumber, stickerContent);

    return executeApiCall(
      () => request.postWithResponse('$fromNumberId/messages', headers, body),
      (json) => WhatsAppResponse.fromJson(json),
    );
  }

  Future<WhatsAppResponse> sendStickerByUrl(
      String phoneNumber, String link) async {
    final stickerContent = {'link': link};
    final body = createMessageBody('sticker', phoneNumber, stickerContent);

    return executeApiCall(
      () => request.postWithResponse('$fromNumberId/messages', headers, body),
      (json) => WhatsAppResponse.fromJson(json),
    );
  }
}
