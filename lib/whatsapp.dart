library whatsapp;

import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class WhatsApp {
  String? _accessToken;
  int? _fromNumberId;

  /// Configure the WhatsApp API with access token and from number id.
  /// [accessToken] is the access token of the WhatsApp API.
  /// [fromNumberId] is the from number id of the WhatsApp API.
  setup({accessToken, int? fromNumberId}) {
    _accessToken = accessToken;
    _fromNumberId = fromNumberId;
  }

  /// Generate the short link of the WhatsApp.
  /// [to] is the phone number with country code but without the plus (+) sign.
  /// [message] is the message to be sent.
  /// [compress] is the compress of the WhatsApp's link.

  short({int? to, String? message, bool? compress}) {
    if (compress == true) {
      return 'https://wa.me/$to?text=$message';
    } else {
      return 'https://api.whatsapp.com/send?phone=$to&text=$message';
    }
  }

  /// Send the template to the client.
  /// [to] is the phone number with country code but without the plus (+) sign.
  /// [templateName] is the template name.
  Future<bool> messagesTemplate({int? to, String? templateName}) async {
    var url = 'https://graph.facebook.com/v13.0/$_fromNumberId/messages';
    Uri uri = Uri.parse(url);

    Map data = {
      "messaging_product": "whatsapp",
      "to": "$to",
      "type": "template",
      "template": {
        "name": "$templateName",
        "language": {"code": "en_US"}
      }
    };

    var body = json.encode(data);

    var response = await http.post(uri,
        headers: {
          "Content-Type": "application/json",
          "_accessToken": "Bearer $_accessToken"
        },
        body: body);
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  /// Send the text message to the client.
  /// [to] is the phone number with country code but without the plus (+) sign.
  /// [message] is the message to be sent.
  /// [previewUrl] is used to preview the URL in the chat window.
  Future<bool> messagesText({
    int? to,
    String? message,
    bool? previewUrl,
  }) async {
    var url = 'https://graph.facebook.com/v13.0/$_fromNumberId/messages';
    Uri uri = Uri.parse(url);

    Map data = {
      "messaging_product": "whatsapp",
      "recipient_type": "individual",
      "to": "$to",
      "type": "text",
      "text": {"previewUrl": previewUrl, "body": "$message"}
    };

    var body = json.encode(data);

    var response = await http.post(uri,
        headers: {
          "Content-Type": "application/json",
          "_accessToken": "Bearer $_accessToken"
        },
        body: body);
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  /// Send the media files to the client.
  /// [to] is the phone number with country code but without the plus (+) sign.
  /// [mediaType] is the type of media such as image, document, audio, image, video, or sticker.
  /// [mediaId] use this edge to retrieve and delete media.
  Future<bool> messagesMedia({to, mediaType, mediaId}) async {
    var url = 'https://graph.facebook.com/v13.0/$_fromNumberId/messages';
    Uri uri = Uri.parse(url);
    Map data = {
      "messaging_product": "whatsapp",
      "recipient_type": "individual",
      "to": "$to",
      "type": "$mediaType",
      "image": {"id": "$mediaId"}
    };

    var body = json.encode(data);

    var response = await http.post(uri,
        headers: {
          "Content-Type": "application/json",
          "_accessToken": "Bearer $_accessToken"
        },
        body: body);
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  /// Send the location to the client.
  /// [to] is the phone number with country code but without the plus (+) sign.
  /// [longitude] is the longitude of the location.
  /// [latitude] is the latitude of the location.
  /// [name] is the name of the location.
  /// [address] is the full address of the location.
  Future<bool> messagesLocation(
      {to, longitude, latitude, name, address}) async {
    var url = 'https://graph.facebook.com/v13.0/$_fromNumberId/messages';
    Uri uri = Uri.parse(url);

    Map data = {
      "messaging_product": "whatsapp",
      "to": "$to",
      "type": "location",
      "location": {
        "longitude": longitude,
        "latitude": latitude,
        "name": name,
        "address": address
      }
    };

    var body = json.encode(data);

    var response = await http.post(uri,
        headers: {
          "Content-Type": "application/json",
          "_accessToken": "Bearer $_accessToken"
        },
        body: body);
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
