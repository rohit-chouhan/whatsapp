import 'package:whatsapp/utils/request.dart';

class CatalogService {
  final String accessToken;
  final String fromNumberId;
  final Request request;

  CatalogService(this.accessToken, this.fromNumberId, this.request);

  /// Send a catalog message to the specified phone number
  /// [phoneNumber] The phone number with country code to which the catalog message will be sent
  /// [catalogId] The catalog ID for the catalog message
  /// [productRetailerId] The product retailer ID for the catalog message
  /// [headerText] The header text for the catalog message (optional)
  /// [bodyText] The body text for the catalog message (optional)
  /// [footerText] The footer text for the catalog message (optional)
  ///
  /// return Request The response object containing the HTTP response code, error message, and message ID if the
  Future<Request> sendCatalogMessage({
    required String phoneNumber,
    required String catalogId,
    required String productRetailerId,
    String? headerText,
    String? bodyText,
    String? footerText,
  }) async {
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };

    final Map<String, dynamic> body = {
      "messaging_product": "whatsapp",
      "recipient_type": "individual",
      "to": phoneNumber,
      "type": "interactive",
      "interactive": {
        "type": "catalog_message",
        "header": headerText != null
            ? {
                "type": "text",
                "text": headerText,
              }
            : null,
        "body": bodyText != null
            ? {
                "text": bodyText,
              }
            : null,
        "footer": footerText != null
            ? {
                "text": footerText,
              }
            : null,
        "action": {
          "name": "catalog_message",
          "parameters": {
            "catalog_id": catalogId,
            "product_retailer_id": productRetailerId,
          }
        }
      }
    };

    // Remove null values
    if (body["interactive"]["header"] == null) {
      body["interactive"].remove("header");
    }
    if (body["interactive"]["body"] == null) {
      body["interactive"].remove("body");
    }
    if (body["interactive"]["footer"] == null) {
      body["interactive"].remove("footer");
    }

    await request.post('$fromNumberId/messages', headers, body);
    return request;
  }

  /// Send a product message to the specified phone number
  /// [phoneNumber] The phone number with country code to which the product message will be sent
  /// [catalogId] The catalog ID for the product message
  /// [productRetailerId] The product retailer ID for the product message
  ///
  /// return Request The response object containing the HTTP response code, error message, and message ID if the
  Future<Request> sendProductMessage({
    required String phoneNumber,
    required String catalogId,
    required String productRetailerId,
  }) async {
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };

    final Map<String, dynamic> body = {
      "messaging_product": "whatsapp",
      "recipient_type": "individual",
      "to": phoneNumber,
      "type": "product",
      "product": {
        "catalog_id": catalogId,
        "product_retailer_id": productRetailerId,
      }
    };

    await request.post('$fromNumberId/messages', headers, body);
    return request;
  }
}
