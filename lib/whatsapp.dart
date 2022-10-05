library whatsapp;

import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class WhatsApp {
  String? _accessToken;
  int? _fromNumberId;
  Map<String, String>? _headers;

  /// Configure the WhatsApp API with access token and from number id.
  /// [accessToken] is the access token of the WhatsApp API.
  /// [fromNumberId] is the from number id of the WhatsApp API.
  setup({accessToken, int? fromNumberId}) {
    _accessToken = accessToken;
    _fromNumberId = fromNumberId;
    _headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $_accessToken"
    };
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
  Future messagesTemplate({int? to, String? templateName}) async {
    var url = 'https://graph.facebook.com/v14.0/$_fromNumberId/messages';
    Uri uri = Uri.parse(url);

    Map data = {
      "messaging_product": "whatsapp",
      "to": to,
      "type": "template",
      "template": {
        "name": templateName,
        "language": {"code": "en_US"}
      }
    };

    var body = json.encode(data);

    var response = await http.post(uri, headers: _headers, body: body);
    try {
      return json.decode(response.body);
    } catch (e) {
      return response.body;
    }
  }

  /// Send the text message to the client.
  /// [to] is the phone number with country code but without the plus (+) sign.
  /// [message] is the message to be sent.
  /// [previewUrl] is used to preview the URL in the chat window.
  Future messagesText({
    int? to,
    String? message,
    bool? previewUrl,
  }) async {
    var url = 'https://graph.facebook.com/v14.0/$_fromNumberId/messages';
    Uri uri = Uri.parse(url);

    Map data = {
      "messaging_product": "whatsapp",
      "recipient_type": "individual",
      "to": to,
      "type": "text",
      "text": {"preview_url": previewUrl, "body": message}
    };

    var body = json.encode(data);

    var response = await http.post(uri, headers: _headers, body: body);
    try {
      return json.decode(response.body);
    } catch (e) {
      return response.body;
    }
  }

  /// Send the media files to the client.
  /// [to] is the phone number with country code but without the plus (+) sign.
  /// [mediaType] is the type of media such as image, document, audio, image, video, or sticker.
  /// [mediaId] use this edge to retrieve and delete media.
  Future messagesMedia({to, mediaType, mediaId}) async {
    var url = 'https://graph.facebook.com/v14.0/$_fromNumberId/messages';
    Uri uri = Uri.parse(url);
    Map data = {
      "messaging_product": "whatsapp",
      "recipient_type": "individual",
      "to": to,
      "type": mediaType,
      "$mediaType": {"id": mediaId}
    };

    var body = json.encode(data);

    var response = await http.post(uri, headers: _headers, body: body);
    try {
      return json.decode(response.body);
    } catch (e) {
      return response.body;
    }
  }

  /// Send the location to the client.
  /// [to] is the phone number with country code but without the plus (+) sign.
  /// [longitude] is the longitude of the location.
  /// [latitude] is the latitude of the location.
  /// [name] is the name of the location.
  /// [address] is the full address of the location.
  Future messagesLocation({to, longitude, latitude, name, address}) async {
    var url = 'https://graph.facebook.com/v14.0/$_fromNumberId/messages';
    Uri uri = Uri.parse(url);

    Map data = {
      "messaging_product": "whatsapp",
      "to": to,
      "type": "location",
      "location": {
        "longitude": longitude,
        "latitude": latitude,
        "name": name,
        "address": address
      }
    };

    var body = json.encode(data);

    var response = await http.post(uri, headers: _headers, body: body);
    try {
      return json.decode(response.body);
    } catch (e) {
      return response.body;
    }
  }

  /// Send image messages to the client.
  /// [to] is the phone number with country code but without the plus (+) sign.
  /// [imageLink] is the image to be sent.
  Future messagesImageByLink({to, imageLink}) async {
    var url = 'https://graph.facebook.com/v14.0/$_fromNumberId/messages';

    Map data = {
      "messaging_product": "whatsapp",
      "recipient_type": "individual",
      "to": to,
      "type": "image",
      "image": {"link": imageLink}
    };

    var body = json.encode(data);

    var response =
        await http.post(Uri.parse(url), headers: _headers, body: body);
    try {
      return json.decode(response.body);
    } catch (e) {
      return response.body;
    }
  }

  ///Send video messages to the client.
  ///[to] is the phone number with country code but without the plus (+) sign.
  /// [videoLink] is the video to be sent.
  /// [caption] is the caption of the video.
  Future messagesVideoByLink({to, videoLink, caption}) async {
    var url = 'https://graph.facebook.com/v14.0/$_fromNumberId/messages';

    Map data = {
      "messaging_product": "whatsapp",
      "recipient_type": "individual",
      "to": to,
      "type": "video",
      "video": {"link": videoLink, "caption": caption}
    };

    var body = json.encode(data);

    var response =
        await http.post(Uri.parse(url), headers: _headers, body: body);
    try {
      return json.decode(response.body);
    } catch (e) {
      return response.body;
    }
  }

  /// Emoji React to Any Message
  /// [to] is the phone number with country code but without the plus (+) sign.
  /// [messageId] is the message id.
  /// [emoji] is the emoji to be sent.
  Future messagesReaction({to, messageId, emoji}) async {
    var url = 'https://graph.facebook.com/v14.0/$_fromNumberId/messages';

    Map data = {
      "messaging_product": "whatsapp",
      "recipient_type": "individual",
      "to": to,
      "type": "reaction",
      "reaction": {"message_id": messageId, "emoji": emoji}
    };

    var body = json.encode(data);

    var response =
        await http.post(Uri.parse(url), headers: _headers, body: body);
    try {
      return json.decode(response.body);
    } catch (e) {
      return response.body;
    }
  }

  /// Reply to a message
  /// [to] is the phone number with country code but without the plus (+) sign.
  /// [messageId] is the message id.
  /// [message] is the message to be sent.
  /// [previewUrl] is used to preview the URL in the chat window.
  Future messagesReply({to, messageId, previewUrl, message}) async {
    var url = 'https://graph.facebook.com/v14.0/$_fromNumberId/messages';

    Map data = {
      "messaging_product": "whatsapp",
      "recipient_type": "individual",
      "to": to,
      "context": {"message_id": messageId},
      "type": "text",
      "text": {"preview_url": previewUrl, "body": message}
    };

    var body = json.encode(data);

    var response =
        await http.post(Uri.parse(url), headers: _headers, body: body);
    try {
      return json.decode(response.body);
    } catch (e) {
      return response.body;
    }
  }
}
