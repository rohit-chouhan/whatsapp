import 'package:whatsapp/utils/request.dart';

class RegistrationService {
  final String accessToken;
  final String fromNumberId;
  final Request request;

  RegistrationService(this.accessToken, this.fromNumberId, this.request);

  Future<Request> register(
      int pin, bool? enableLocalStorage, String? dataLocalizationRegion) async {
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };

    final Map<String, dynamic> body = {
      "messaging_product": "whatsapp",
      "pin": pin,
    };

    if (enableLocalStorage != null) {
      body["data_localization_region"] = dataLocalizationRegion;
    }

    await request.post('$fromNumberId/register', headers, body);
    return request;
  }

  Future<Request> deRegister() async {
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };

    await request.post('$fromNumberId/deregister', headers, {});
    return request;
  }

  Future<Request> twoStepVerification(int pin) async {
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };

    final Map<String, dynamic> body = {
      "pin": pin,
    };

    await request.post(fromNumberId, headers, body);
    return request;
  }
}
