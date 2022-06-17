library whatsapp;

import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Whatsapp {
  static String? authorization;
  static int? fromNumber;

  //setup configure, provide [accessToken], and [from_number] which is your Phone Number ID
  setup({accessToken, fromNumberId}) {
    authorization = accessToken;
    fromNumber = fromNumberId;
  }

  /// generate link for whatsapp short link, [to] is the phone number with country code without +, [message] is the text to send, [compress] is optional, if true, the link will be compressed
  short({to, message, compress}) {
    if (compress == true) {
      return 'https://wa.me/$to?text=$message';
    } else {
      return 'https://api.whatsapp.com/send?phone=$to&text=$message';
    }
  }

  /// send message for type template, [to] is number, [templateName] is template name of whatsapp api
  Future<bool> messagesTemplate({to, templateName}) async {
    var url = 'https://graph.facebook.com/v13.0/$fromNumber/messages';

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

    var response = await http.post(Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $authorization"
        },
        body: body);
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  /// send text message, [to] is number, [message] is message which you want to send, [previewUrl] for preview url true, false
  Future<bool> messagesText({to, message, previewUrl}) async {
    var url = 'https://graph.facebook.com/v13.0/$fromNumber/messages';

    Map data = {
      "messaging_product": "whatsapp",
      "recipient_type": "individual",
      "to": "$to",
      "type": "text",
      "text": {"previewUrl": previewUrl, "body": "$message"}
    };

    var body = json.encode(data);

    var response = await http.post(Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $authorization"
        },
        body: body);
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  /// send text message, [to] is number, [mediaType] is type of media such as image, document, audio, image, video, or sticker, [link] is full link of media file
  Future<bool> messagesMedia({to, mediaType, mediaId}) async {
    var url = 'https://graph.facebook.com/v13.0/$fromNumber/messages';

    Map data = {
      "messaging_product": "whatsapp",
      "recipient_type": "individual",
      "to": "$to",
      "type": "$mediaType",
      "image": {"id": "$mediaId"}
    };

    var body = json.encode(data);

    var response = await http.post(Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $authorization"
        },
        body: body);
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  /// send text message, [to] is number, [longitude] and [latitude] of map, [name] for name of location, and [address] is static address for location
  Future<bool> messagesLocation(
      {to, longitude, latitude, name, address}) async {
    var url = 'https://graph.facebook.com/v13.0/$fromNumber/messages';

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

    var response = await http.post(Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $authorization"
        },
        body: body);
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
  //end class
}
