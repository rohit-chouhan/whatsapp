import 'package:whatsapp/services/base_service.dart';
import 'package:whatsapp/utils/response/whatsapp_response.dart';

/// A service for sending audio messages via WhatsApp Cloud API.
class AudioService extends BaseService {
  /// Creates an instance of [AudioService].
  AudioService(super.accessToken, super.fromNumberId, super.request);

  /// Sends an audio message using a media ID.
  ///
  /// [phoneNumber] The recipient's phone number.
  /// [audioId] The ID of the uploaded audio media.
  ///
  /// Returns a [WhatsAppResponse] with the message details.
  Future<WhatsAppResponse> sendAudioById(
      String phoneNumber, String audioId) async {
    final body = createMessageBody('audio', phoneNumber, {'id': audioId});

    return executeApiCall(
      () => request.postWithResponse('$fromNumberId/messages', headers, body),
      (json) => WhatsAppResponse.fromJson(json),
    );
  }

  /// Sends an audio message using a direct URL.
  ///
  /// [phoneNumber] The recipient's phone number.
  /// [link] The direct URL of the audio file.
  ///
  /// Returns a [WhatsAppResponse] with the message details.
  Future<WhatsAppResponse> sendAudioByUrl(
      String phoneNumber, String link) async {
    final body = createMessageBody('audio', phoneNumber, {'link': link});

    return executeApiCall(
      () => request.postWithResponse('$fromNumberId/messages', headers, body),
      (json) => WhatsAppResponse.fromJson(json),
    );
  }
}
