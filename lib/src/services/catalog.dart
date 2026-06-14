import 'package:whatsapp/src/services/base_service.dart';
import 'package:whatsapp/src/utils/response/whatsapp_response.dart';

class CatalogService extends BaseService {
  CatalogService(super.accessToken, super.fromNumberId, super.request);

  /// Send a catalog message to the specified phone number
  /// [phoneNumber] The phone number with country code to which the catalog message will be sent
  /// [productRetailerId] The product retailer ID for the catalog message
  /// [headerText] The header text for the catalog message (optional)
  /// [bodyText] The body text for the catalog message (optional)
  /// [footerText] The footer text for the catalog message (optional)
  ///
  /// return Request The response object containing the HTTP response code, error message, and message ID if the
  Future<WhatsAppResponse> sendCatalogMessage({
    required String phoneNumber,
    required String productRetailerId,
    String? headerText,
    String? bodyText,
    String? footerText,
  }) async {
    final Map<String, dynamic> body = {
      "messaging_product": "whatsapp",
      "recipient_type": "individual",
      "to": phoneNumber,
      "type": "interactive",
      "interactive": {
        "type": "catalog_message",
        "action": {
          "name": "catalog_message",
          "parameters": {
            "thumbnail_product_retailer_id": productRetailerId,
          }
        }
      }
    };

    if (bodyText != null) {
      body["interactive"]["body"] = {"text": bodyText};
    }
    if (footerText != null) {
      body["interactive"]["footer"] = {"text": footerText};
    }

    var url = '$fromNumberId/messages';
    
    return executeApiCall(
      () => request.postWithResponse(url, headers, body),
      (json) => WhatsAppResponse.fromJson(json),
    );
  }

  /// Send a product message to the specified phone number
  /// [phoneNumber] The phone number with country code to which the product message will be sent
  /// [catalogId] The catalog ID for the product message
  /// [productRetailerId] The product retailer ID for the product message
  ///
  /// return Request The response object containing the HTTP response code, error message, and message ID if the
  Future<WhatsAppResponse> sendProductMessage({
    required String phoneNumber,
    required String catalogId,
    required String productRetailerId,
    String? bodyText,
    String? footerText,
  }) async {
    final Map<String, dynamic> body = {
      "messaging_product": "whatsapp",
      "recipient_type": "individual",
      "to": phoneNumber,
      "type": "interactive",
      "interactive": {
        "type": "product",
        "action": {
          "catalog_id": catalogId,
          "product_retailer_id": productRetailerId
        }
      }
    };

    if (bodyText != null) {
      body["interactive"]["body"] = {"text": bodyText};
    }
    if (footerText != null) {
      body["interactive"]["footer"] = {"text": footerText};
    }

    var url = '$fromNumberId/messages';
    
    return executeApiCall(
      () => request.postWithResponse(url, headers, body),
      (json) => WhatsAppResponse.fromJson(json),
    );
  }
}
