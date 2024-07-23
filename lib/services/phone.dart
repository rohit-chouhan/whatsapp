import 'package:whatsapp/utils/request.dart';

class PhoneService {
  final String accessToken;
  final String fromNumberId;
  final Request request;

  PhoneService(this.accessToken, this.fromNumberId, this.request);

  Future<Request> requestCode(String? codeMethod, String? language) async {
    final Map<String, String> headers = {
      'Authorization': 'Bearer $accessToken',
    };

    codeMethod ??= 'SMS';
    language ??= 'en';

    final Map<String, String> body = {
      'code_method': codeMethod,
      'language': language,
    };

    await request.postForm('$fromNumberId/request_code', headers, body);
    return request;
  }

  Future<Request> verifyCode(int code) async {
    final Map<String, String> headers = {
      'Authorization': 'Bearer $accessToken',
    };

    final Map<String, String> body = {
      'code': code.toString(),
    };

    await request.postForm('$fromNumberId/verify_code', headers, body);
    return request;
  }
}
