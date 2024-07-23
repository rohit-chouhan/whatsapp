import 'package:whatsapp/utils/request.dart';

class LocationService {
  final String accessToken;
  final String fromNumberId;
  final Request request;

  LocationService(this.accessToken, this.fromNumberId, this.request);

  Future<Request> sendLocation(String phoneNumber, double latitude,
      double longitude, String? name, String? address) async {
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };

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

    await request.post('$fromNumberId/messages', headers, body);
    return request;
  }

  Future<Request> sendLocationRequest(String phoneNumber, String text) async {
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };

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

    await request.post('$fromNumberId/messages', headers, body);
    return request;
  }
}
