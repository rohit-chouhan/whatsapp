import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:whatsapp/src/utils/exception.dart';
import 'package:whatsapp/src/utils/request.dart';
import 'package:whatsapp/src/utils/response/whatsapp_business_account_response.dart';
import 'package:whatsapp/src/utils/response/whatsapp_success_response.dart';

class BusinessService {
  final String accessToken;
  final String fromNumberId;
  final Request request;

  BusinessService(this.accessToken, this.fromNumberId, this.request);

  /// Gets the business profile details.
  ///
  /// [scope] The scope of the business details (e.g. `["name", "email"]`) (optional).
  ///
  /// Returns a [WhatsAppBusinessAccountResponse] containing the business profile details.
  Future<WhatsAppBusinessAccountResponse> getBusinessProfile(
      List<String>? scope) async {
    final Map<String, String> headers = {
      'Authorization': 'Bearer $accessToken',
    };

    String fields =
        'about,address,description,email,profile_picture_url,websites,vertical';
    if (scope != null) {
      fields = scope.join(',');
    }

    var url = '$fromNumberId/whatsapp_business_profile?fields=$fields';
    try {
      final http.Response response =
          await request.getWithResponse(url, headers);

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseBody = jsonDecode(response.body);
        final WhatsAppBusinessAccountResponse parsedResponse =
            WhatsAppBusinessAccountResponse.fromJson(responseBody);
        return parsedResponse;
      } else {
        // Throw a more specific exception using the factory constructor
        throw WhatsAppException.fromResponse(response);
      }
    } on FormatException catch (e) {
      // Handle JSON decoding errors specifically
      throw JsonFormatException('Failed to parse JSON response: $e');
    } on http.ClientException catch (e) {
      // Handle network-related errors (e.g., no internet, timeout)
      throw NetworkException('Network error: $e');
    } on WhatsAppException {
      // Re-throw WhatsApp-specific exceptions.
      rethrow;
    } catch (e) {
      // Handle any other unexpected exceptions.
      throw WhatsAppException('An unexpected error occurred: $e');
    }
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

    var url = '$fromNumberId/whatsapp_business_profile';
    try {
      final http.Response response =
          await request.postWithResponse(url, headers, body);

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseBody = jsonDecode(response.body);
        final WhatsAppSuccessResponse parsedResponse =
            WhatsAppSuccessResponse.fromJson(responseBody);
        return parsedResponse;
      } else {
        // Throw a more specific exception using the factory constructor
        throw WhatsAppException.fromResponse(response);
      }
    } on FormatException catch (e) {
      // Handle JSON decoding errors specifically
      throw JsonFormatException('Failed to parse JSON response: $e');
    } on http.ClientException catch (e) {
      // Handle network-related errors (e.g., no internet, timeout)
      throw NetworkException('Network error: $e');
    } on WhatsAppException {
      // Re-throw WhatsApp-specific exceptions.
      rethrow;
    } catch (e) {
      // Handle any other unexpected exceptions.
      throw WhatsAppException('An unexpected error occurred: $e');
    }
  }
}
