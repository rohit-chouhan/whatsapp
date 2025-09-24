import 'package:whatsapp/services/base_service.dart';
import 'package:whatsapp/utils/response/whatsapp_response.dart';

class TextService extends BaseService {
  TextService(super.accessToken, super.fromNumberId, super.request);

  String getLink(
    String phoneNumber,
    String? message,
    bool? shortLink,
    List<String>? bold,
    List<String>? italic,
    List<String>? strikethrough,
    List<String>? monospace,
  ) {
    // Helper function to apply formatting
    String applyFormatting(String text, String symbol) => '$symbol$text$symbol';

    // Define formatting rules
    final formattingRules = {
      bold: '*',
      italic: '_',
      strikethrough: '~',
      monospace: '```',
    };

    // Apply formatting based on parameters
    var body = message ?? '';

    for (final entry in formattingRules.entries) {
      final words = entry.key;
      final symbol = entry.value;
      if (words != null) {
        for (final word in words) {
          body = body.replaceAll(word, applyFormatting(word, symbol));
        }
      }
    }

    // Clean phone number
    final cleanPhoneNumber = phoneNumber.replaceAll(RegExp(r'[^\d]'), '');

    // Generate the appropriate link
    final encodedBody = Uri.encodeComponent(body);
    return shortLink == true
        ? 'https://wa.me/$cleanPhoneNumber?text=$encodedBody'
        : 'https://api.whatsapp.com/send?phone=$cleanPhoneNumber&text=$encodedBody';
  }

  Future<WhatsAppResponse> sendMessage(
      String phoneNumber, String text, bool previewUrl) async {
    final body = createMessageBody('text', phoneNumber, {
      'preview_url': previewUrl,
      'body': text,
    });

    return executeApiCall(
      () => request.postWithResponse('$fromNumberId/messages', headers, body),
      (json) => WhatsAppResponse.fromJson(json),
    );
  }
}
