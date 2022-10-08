library whatsapp;

import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io';

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
  /// [mediaType] is the type of media such as image, document, sticker, audio or video
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

  /// Send media messages to the client.
  /// [to] is the phone number with country code but without the plus (+) sign.
  /// [mediaType] is type of media such as image, document, sticker, audio or video
  /// [mediaLink] is media to be sent.
  /// [caption] is caption of media
  Future messagesMediaByLink({to, mediaType, mediaLink, caption}) async {
    var url = 'https://graph.facebook.com/v14.0/$_fromNumberId/messages';

    Map data = {
      "messaging_product": "whatsapp",
      "recipient_type": "individual",
      "to": to,
      "type": mediaType,
      "$mediaType": {"caption": caption, "link": mediaLink}
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

  /// Reply to a media by ID
  /// [to] is the phone number with country code but without the plus (+) sign.
  /// [messageId] is the message id.
  /// [mediaType] is type of media such as image, document, sticker, audio or video
  /// [mediaId] is id of media to be replay.
  Future messagesReplyMedia({to, messageId, mediaType, mediaId}) async {
    var url = 'https://graph.facebook.com/v14.0/$_fromNumberId/messages';

    Map data = {
      "messaging_product": "whatsapp",
      "recipient_type": "individual",
      "to": to,
      "context": {"message_id": messageId},
      "type": mediaType,
      "$mediaType": {"id": mediaId}
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

  /// Reply to a media by URL
  /// [to] is the phone number with country code but without the plus (+) sign.
  /// [messageId] is the message id.
  /// [mediaType] is type of media such as image, document, sticker, audio or video
  /// [mediaLink] is link of media to be sent.
  /// [caption] is caption of media to be sent.
  Future messagesReplyMediaUrl(
      {to, messageId, mediaType, mediaLink, caption}) async {
    var url = 'https://graph.facebook.com/v14.0/$_fromNumberId/messages';

    Map data = {
      "messaging_product": "whatsapp",
      "recipient_type": "individual",
      "to": to,
      "context": {"message_id": messageId},
      "type": mediaType,
      "$mediaType": {"link": mediaLink, "caption": caption}
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

  /// Register a phone number
  /// [pin] is 6-digit pin for register number.
  Future registerNumber({pin}) async {
    var url = 'https://graph.facebook.com/v14.0/$_fromNumberId/register';

    Map data = {"messaging_product": "whatsapp", "pin": pin};

    var body = json.encode(data);

    var response =
        await http.post(Uri.parse(url), headers: _headers, body: body);
    try {
      return json.decode(response.body);
    } catch (e) {
      return response.body;
    }
  }

  /// Set Two Step Verification Code
  /// [pin] is 6-digit pin for two step verification.
  Future setTwoStepVerification({pin}) async {
    var url = 'https://graph.facebook.com/v14.0/$_fromNumberId/register';

    Map data = {"pin": pin};

    var body = json.encode(data);

    var response =
        await http.post(Uri.parse(url), headers: _headers, body: body);
    try {
      return json.decode(response.body);
    } catch (e) {
      return response.body;
    }
  }

  /// Deregister a phone number
  /// [pin] is 6-digit pin for deregister number.
  Future deregisterNumber({pin}) async {
    var url = 'https://graph.facebook.com/v14.0/$_fromNumberId/deregister';

    Map data = {"pin": pin};

    var body = json.encode(data);

    var response =
        await http.post(Uri.parse(url), headers: _headers, body: body);
    try {
      return json.decode(response.body);
    } catch (e) {
      return response.body;
    }
  }

  /// Get Shared WhatsApp Business Account Id
  /// [inputToken] is token generated after embedding the signup flow
  Future getWhatsAppBusinessAccounts({inputToken}) async {
    var url =
        'https://graph.facebook.com/v14.0/debug_token?input_token=$inputToken';

    var response = await http.get(Uri.parse(url), headers: _headers);
    try {
      return json.decode(response.body);
    } catch (e) {
      return response.body;
    }
  }

  /// Get Shared WhatsApp Business Accounts Lists (WABAs)
  /// [accountId] is Business manager account Id
  Future getWhatsAppBusinessAccountsList({accountId}) async {
    var parseAccountId = accountId.toString();
    var url =
        'https://graph.facebook.com/v14.0/$parseAccountId/client_whatsapp_business_accounts';

    var response = await http.get(Uri.parse(url), headers: _headers);
    try {
      return json.decode(response.body);
    } catch (e) {
      return response.body;
    }
  }

  /// Send message with action buttons for choice
  /// [to] is the phone number with country code but without the plus (+) sign.
  /// [bodyText] is the main body text of message
  /// [buttons] is list of action buttons with id and text
  messagesButton({to, bodyText, buttons}) async {
    var url = 'https://graph.facebook.com/v14.0/$_fromNumberId/messages';

    var buttonsList = [];
    for (var i = 0; i < buttons.length; i++) {
      buttonsList.add({
        "type": "reply",
        "reply": {"id": buttons[i]["id"], "title": buttons[i]["text"]}
      });
    }

    Map data = {
      "messaging_product": "whatsapp",
      "recipient_type": "individual",
      "to": to,
      "type": "interactive",
      "interactive": {
        "type": "button",
        "body": {"text": bodyText},
        "action": {"buttons": buttonsList}
      }
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

  ///Upload Media to WhatsApp Business
  ///[mediaFile] is the file object to be send
  ///[mediaName] is the name of file
  uploadMedia({required mediaFile, mediaType, mediaName}) async {
    var uri =
        Uri.parse('https://graph.facebook.com/v14.0/$_fromNumberId/media');

    var request = http.MultipartRequest('POST', uri);
    request.headers.addAll(_headers!);
    request.fields['messaging_product'] = 'whatsapp';
    request.files.add(http.MultipartFile.fromBytes(
        'file', File(mediaFile.path).readAsBytesSync(),
        filename: mediaName, contentType: mediaType));

    var response = await request.send();
    final respStr = await response.stream.bytesToString();
    try {
      return json.decode(respStr);
    } catch (e) {
      return respStr;
    }
  }

  /// Retrive URL of media
  /// [mediaId] is id of media file
  Future getMediaUrl({mediaId}) async {
    var url = 'https://graph.facebook.com/v14.0/$mediaId';

    var response = await http.get(Uri.parse(url), headers: _headers);
    try {
      return json.decode(response.body);
    } catch (e) {
      return response.body;
    }
  }

  /// Delete uploaded media
  /// [mediaId] is id of media file
  Future deleteMedia({mediaId}) async {
    var url = 'https://graph.facebook.com/v14.0/$mediaId';

    var response = await http.delete(Uri.parse(url), headers: _headers);
    try {
      return json.decode(response.body);
    } catch (e) {
      return response.body;
    }
  }

  /// Update WhatsApp Business Account Details
  /// [businessAddress] is address of business
  /// [businessDescription] is description of business
  /// [businessIndustry] is industry of business
  /// [businessAbout] is about of your business
  /// [businessEmail] is email of your business
  /// [businessWebsites] is list of website to update
  /// [businessProfileId] is image handle id to update profile picture of business
  Future updateProfile(
      {businessAddress,
      businessDescription,
      businessIndustry,
      businessAbout,
      businessEmail,
      required List businessWebsites,
      businessProfileId}) async {
    var url =
        'https://graph.facebook.com/v14.0/$_fromNumberId/whatsapp_business_profile';

    Map data = {
      "messaging_product": "whatsapp",
      "address": businessAddress,
      "description": businessDescription,
      "vertical": businessIndustry,
      "about": businessAbout,
      "email": businessEmail,
      "websites": businessWebsites,
      "profile_picture_handle": businessProfileId
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
