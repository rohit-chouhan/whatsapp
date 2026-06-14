import 'package:whatsapp/src/services/base_service.dart';
import 'package:whatsapp/src/utils/response/whatsapp_business_account_response.dart';
import 'package:whatsapp/src/utils/response/whatsapp_success_response.dart';

class BusinessService extends BaseService {
  BusinessService(super.accessToken, super.fromNumberId, super.request);

  /// Gets the business profile details.
  ///
  /// [scope] The scope of the business details (e.g. `["name", "email"]`) (optional).
  ///
  /// Returns a [WhatsAppBusinessAccountResponse] containing the business profile details.
  Future<WhatsAppBusinessAccountResponse> getBusinessProfile(
      List<String>? scope) async {
    String fields =
        'about,address,description,email,profile_picture_url,websites,vertical';
    if (scope != null) {
      fields = scope.join(',');
    }

    var url = '$fromNumberId/whatsapp_business_profile?fields=$fields';
    
    return executeApiCall(
      () => request.getWithResponse(url, headers),
      (json) => WhatsAppBusinessAccountResponse.fromJson(json),
    );
  }

  /// Updates the business profile details.
  ///
  /// [about] The about section of the business profile (optional).
  /// [address] The address section of the business profile (optional).
  /// [description] The description section of the business profile (optional).
  /// [industry] The industry of the business profile (optional).
  /// [email] The email section of the business profile (optional).
  /// [websites] The websites section of the business profile (optional).
  /// [profilePictureHandle] The profile picture handle of the business profile (optional).
  ///
  /// Returns a [WhatsAppSuccessResponse] indicating whether the business profile was updated successfully.
  Future<WhatsAppSuccessResponse> updateBusinessProfile(
    String? about,
    String? address,
    String? description,
    String? industry,
    String? email,
    List<String>? websites,
    String? profilePictureHandle,
  ) async {
    final Map<String, dynamic> body = {
      "messaging_product": "whatsapp",
    };

    if (about != null) body['about'] = about;
    if (address != null) body['address'] = address;
    if (description != null) body['description'] = description;
    if (industry != null) body['vertical'] = industry;
    if (email != null) body['email'] = email;
    if (websites != null) body['websites'] = websites;
    if (profilePictureHandle != null) {
      body['profile_picture_handle'] = profilePictureHandle;
    }

    var url = '$fromNumberId/whatsapp_business_profile';

    return executeApiCall(
      () => request.postWithResponse(url, headers, body),
      (json) => WhatsAppSuccessResponse.fromJson(json),
    );
  }
}
