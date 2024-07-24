import 'package:whatsapp/utils/request.dart';

class BusinessService {
  final String accessToken;
  final String fromNumberId;
  final Request request;

  BusinessService(this.accessToken, this.fromNumberId, this.request);

  Future<Request> getBusinessProfile(List<String>? scope) async {
    final Map<String, String> headers = {
      'Authorization': 'Bearer $accessToken',
    };

    String fields =
        'about,address,description,email,profile_picture_url,websites,vertical';
    if (scope != null) {
      fields = scope.join(',');
    }
    await request.get(
        '$fromNumberId/whatsapp_business_profile?fields=$fields', headers);
    return request;
  }

  Future<Request> updateBusinessProfile(
    String? about,
    String? address,
    String? description,
    String? industry,
    String? email,
    List<String>? websites,
    String? profilePictureHandle,
  ) async {
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };

    final Map<String, dynamic> body = {
      "messaging_product": "whatsapp",
    };

    if (about != null) {
      body['about'] = about;
    }

    if (description != null) {
      body['description'] = description;
    }

    if (industry != null) {
      body['vertical'] = industry;
    }

    if (email != null) {
      body['email'] = email;
    }

    if (websites != null) {
      body['websites'] = websites;
    }

    if (profilePictureHandle != null) {
      body['profile_picture_handle'] = profilePictureHandle;
    }

    await request.post(
        '$fromNumberId/whatsapp_business_profile', headers, body);
    return request;
  }
}
