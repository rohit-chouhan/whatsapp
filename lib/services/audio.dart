import 'package:whatsapp/services/base_service.dart';
import 'package:whatsapp/utils/response/whatsapp_response.dart';

class AudioService extends BaseService {
  AudioService(super.accessToken, super.fromNumberId, super.request);

  Future<WhatsAppResponse> sendAudioById(String phoneNumber, String mediaId) async {
    final body = createMessageBody('audio', phoneNumber, {'id': mediaId});

    return executeApiCall(
      () => request.postWithResponse('$fromNumberId/messages', headers, body),
      (json) => WhatsAppResponse.fromJson(json),
    );
  }

  Future<WhatsAppResponse> sendAudioByUrl(String phoneNumber, String link) async {
    final body = createMessageBody('audio', phoneNumber, {'link': link});

    return executeApiCall(
      () => request.postWithResponse('$fromNumberId/messages', headers, body),
      (json) => WhatsAppResponse.fromJson(json),
    );
  }
}
