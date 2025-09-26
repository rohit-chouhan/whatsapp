import 'package:whatsapp/services/base_service.dart';
import 'package:whatsapp/utils/response/whatsapp_response.dart';

class DocumentService extends BaseService {
  DocumentService(super.accessToken, super.fromNumberId, super.request);

  Future<WhatsAppResponse> sendDocumentById(String phoneNumber,
      String documentId, String? caption, String? fileName) async {
    final Map<String, dynamic> documentContent = {'id': documentId};
    if (caption != null) {
      documentContent['caption'] = caption;
    }
    if (fileName != null) {
      documentContent['filename'] = fileName;
    }

    final body = createMessageBody('document', phoneNumber, documentContent);

    return executeApiCall(
      () => request.postWithResponse('$fromNumberId/messages', headers, body),
      (json) => WhatsAppResponse.fromJson(json),
    );
  }

  Future<WhatsAppResponse> sendDocumentByUrl(String phoneNumber, String link,
      String? caption, String? fileName) async {
    final Map<String, dynamic> documentContent = {'link': link};
    if (caption != null) {
      documentContent['caption'] = caption;
    }
    if (fileName != null) {
      documentContent['filename'] = fileName;
    }

    final body = createMessageBody('document', phoneNumber, documentContent);

    return executeApiCall(
      () => request.postWithResponse('$fromNumberId/messages', headers, body),
      (json) => WhatsAppResponse.fromJson(json),
    );
  }
}
