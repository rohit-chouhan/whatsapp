import 'package:whatsapp/utils/request.dart';

class CustomService {
  final String accessToken;
  final String fromNumberId;
  final Request request;

  CustomService(this.accessToken, this.fromNumberId, this.request);

  Future<Request> sendCustomRequest(
      String path, Map<String, dynamic> payload) async {
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };

    final Map<String, dynamic> body = payload;

    await request.post('$fromNumberId$path', headers, body);
    return request;
  }
}
