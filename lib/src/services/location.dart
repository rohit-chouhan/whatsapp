import 'package:whatsapp/src/services/base_service.dart';
import 'package:whatsapp/src/utils/response/whatsapp_response.dart';

class LocationService extends BaseService {
  LocationService(super.accessToken, super.fromNumberId, super.request);

  Future<WhatsAppResponse> sendLocation(String phoneNumber, double latitude,
      double longitude, String? name, String? address) async {
    final Map<String, dynamic> body = {
      "messaging_product": "whatsapp",
      "recipient_type": "individual",
      "to": phoneNumber,
      "type": "location",
      "location": {
        "latitude": latitude.toString(),
        "longitude": longitude.toString(),
      }
    };

    if (name != null) {
      body["location"]["name"] = name;
    }

    if (address != null) {
      body["location"]["address"] = address;
    }

    var url = '$fromNumberId/messages';
    
    return executeApiCall(
      () => request.postWithResponse(url, headers, body),
      (json) => WhatsAppResponse.fromJson(json),
    );
  }

  Future<WhatsAppResponse> sendLocationRequest(
      String phoneNumber, String text) async {
    final Map<String, dynamic> body = {
      "messaging_product": "whatsapp",
      "recipient_type": "individual",
      "type": "interactive",
      "to": phoneNumber,
      "interactive": {
        "type": "location_request_message",
        "body": {"text": text},
        "action": {"name": "send_location"}
      }
    };

    var url = '$fromNumberId/messages';
    
    return executeApiCall(
      () => request.postWithResponse(url, headers, body),
      (json) => WhatsAppResponse.fromJson(json),
    );
  }
}
