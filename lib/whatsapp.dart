library whatsapp;

import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Whatsapp {
  static String? authorization;
  static int? fromNumber;

  //setup configure, provide [access_token], and [from_number] which is your Phone Number ID
  setup({access_token, fromNumberId}) {
    authorization = access_token;
    fromNumber = fromNumberId;
  }

  /// generate link for whatsapp short link, [phone_number] is the phone number with country code without +, [message] is the text to send, [compress] is optional, if true, the link will be compressed
  short({phone_number, message, compress}) {
    if (compress == true) {
      return 'https://wa.me/${phone_number}?text=${message}';
    } else {
      return 'https://api.whatsapp.com/send?phone=${phone_number}&text=${message}';
    }
  }

  /// send message for type template, [to] is number, [template_name] is template name of whatsapp api
  Future<bool> messagesTemplate({to, template_name}) async {
    var url = 'https://graph.facebook.com/v13.0/$fromNumber/messages';

    Map data = {
      "messaging_product": "whatsapp",
      "to": "$to",
      "type": "template",
      "template": {
        "name": "$template_name",
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
        print(response.body);
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  /// send text message, [to] is number, [message] is message which you want to send, [preview_url] for preview url true, false
  Future<bool> messagesText({to, message, preview_url}) async {
    var url = 'https://graph.facebook.com/v13.0/$fromNumber/messages';

    Map data = {
      "messaging_product": "whatsapp",
      "recipient_type": "individual",
      "to": "$to",
      "type": "text",
      "text": {"preview_url": preview_url, "body": "$message"}
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

  /// send text message, [to] is number, [media_type] is type of media such as image, document, audio, image, video, or sticker, [link] is full link of media file
  Future<bool> messagesMedia({to, media_type, media_id}) async {
    var url = 'https://graph.facebook.com/v13.0/$fromNumber/messages';

    Map data = {
      "messaging_product": "whatsapp",
      "recipient_type": "individual",
      "to": "$to",
      "type": "$media_type",
      "image": {"id": "$media_id"}
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
