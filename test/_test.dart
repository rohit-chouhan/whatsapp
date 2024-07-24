/// create test code here
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:whatsapp/model/replay.dart';
import 'package:whatsapp/utils/request.dart';
import 'package:whatsapp/whatsapp.dart';

void main() {
  const accessToken =
      'EAAGp6aTb8wMBOZBGuOHRAg5QZAjALfgZBpnYIxdrzHnN0LOqPSP9cikYPDUlwqGDpY5OhyukgxunXnH0SPhfCs2SI3wQM4iUFVF4fXo7SLfkIRUrGbnB8wtDaEsEsErdTF0uHkSa974Q92SfRNDZBLXr23XK7gsbNPX5WZBlbvUJGrmHyiuW6mnHhTUuMq3Pk10VhawhFZAD5NZCZArjSZAUHzWI0uakEHbgCf6UZD';
  const fromNumberId = '108277245242985';
  const phoneNumber = '917023042306';
  var testMessageId = '';

  var testImageMediaId = '1000263478443162';
  var testAudioMediaId = '1216242786051547';
  var testVideoMediaId = '492888249957937';
  var testDocumentMediaId = '903275095147958';
  var testStickerMediaId = '327908227064360';
  var uploadingFileId = '';

  final client = WhatsApp(accessToken, fromNumberId);

  test('sendMessage()', () async {
    var res = await client.sendMessage(
        phoneNumber: phoneNumber, text: "Hello, this is a test message!");
    // testMessageId = res.getMessageId()!;
    debugPrint(res.getResponse().toString());
    testResponse(res);
    // expect(res.isSuccess(), true);
  });

  test('sendImageById()', () async {
    var res = await client.sendImageById(
        phoneNumber: phoneNumber,
        mediaId: testImageMediaId,
        caption: "Hello I am Image");
    testResponse(res);
    expect(res.isSuccess(), true);
  });

  test('sendImageByUrl()', () async {
    var res = await client.sendImageByUrl(
        phoneNumber: phoneNumber,
        imageUrl:
            "https://www.akc.org/wp-content/uploads/2015/03/so-you-want-to-breed-dogs-500x500.jpg",
        caption: "Love my puppy?");
    testResponse(res);
    expect(res.isSuccess(), true);
  });

  test('sendAudioById()', () async {
    var res = await client.sendAudioById(
        phoneNumber: phoneNumber, mediaId: testAudioMediaId);
    testResponse(res);
    expect(res.isSuccess(), true);
  });

  test('sendAudioByUrl()', () async {
    var res = await client.sendAudioByUrl(
        phoneNumber: phoneNumber,
        audioUrl:
            "https://onlinetestcase.com/wp-content/uploads/2023/06/100-KB-MP3.mp3");
    testResponse(res);
    expect(res.isSuccess(), true);
  });

  test('sendDocumentById()', () async {
    var res = await client.sendDocumentById(
        phoneNumber: phoneNumber,
        mediaId: testDocumentMediaId,
        caption: "My File",
        filename: "hello.pdf");
    testResponse(res);
    expect(res.isSuccess(), true);
  });

  test('sendDocumentByUrl()', () async {
    var res = await client.sendDocumentByUrl(
        phoneNumber: phoneNumber,
        documentUrl: "https://www.gutenberg.org/files/2701/2701-0.txt",
        caption: "My File",
        filename: "gutenberg.txt");
    testResponse(res);
    expect(res.isSuccess(), true);
  });

  test('sendVideoById()', () async {
    var res = await client.sendVideoById(
        phoneNumber: phoneNumber,
        mediaId: testVideoMediaId,
        caption: "Sample Video");
    testResponse(res);
    expect(res.isSuccess(), true);
  });

  test('sendVideoByUrl()', () async {
    var res = await client.sendVideoByUrl(
        phoneNumber: phoneNumber,
        videoUrl:
            "https://sample-videos.com/video321/mp4/720/big_buck_bunny_720p_1mb.mp4",
        caption: "Sample Video");
    testResponse(res);
    expect(res.isSuccess(), true);
  });

  test('sendSticker()', () async {
    var res = await client.sendSticker(
        phoneNumber: phoneNumber, stickerId: testStickerMediaId);
    testResponse(res);
    expect(res.isSuccess(), true);
  });

  test('sendReaction()', () async {
    var res = await client.sendReaction(
        phoneNumber: phoneNumber,
        messageId: testMessageId,
        emoji: "\uD83D\uDE00");
    testResponse(res);
    expect(res.isSuccess(), true);
  });

  test('sendLocationRequest()', () async {
    var res = await client.sendLocationRequest(
        phoneNumber: phoneNumber, text: "Send me your location");
    testResponse(res);
    expect(res.isSuccess(), true);
  });

  test('sendLocation()', () async {
    var res = await client.sendLocation(
        phoneNumber: phoneNumber,
        latitude: 25.197197,
        longitude: 55.2743764,
        name: "Burj Khalifa",
        address:
            "1 Sheikh Mohammed bin Rashid Blvd - Downtown Dubai - Dubai - United Arab Emirates");
    testResponse(res);
    expect(res.isSuccess(), true);
  });

  test('sendInteractiveReplayButtons()', () async {
    var res = await client.sendInteractiveReplayButton(
        phoneNumber: phoneNumber,
        headerInteractive: {
          "type": "image",
          "image": {
            "link":
                "https://www.akc.org/wp-content/uploads/2015/03/so-you-want-to-breed-dogs-500x500.jpg",
          }
        },
        bodyText: "Choose an option",
        footerText: "Tap to proceed",
        interactiveReplyButtons: [
          {
            "type": "reply",
            "reply": {"id": "change-button", "title": "Change"}
          },
          {
            "type": "reply",
            "reply": {"id": "cancel-button", "title": "Cancel"}
          }
        ]);
    testResponse(res);
    expect(res.isSuccess(), true);
  });

  test('sendInteractiveLists()', () async {
    var res = await client.sendInteractiveLists(
      phoneNumber: phoneNumber,
      headerText: "Welcome Dear",
      bodyText: "Choose your favorite animal",
      footerText: "Please choose only one",
      buttonText: "Choose",
      sections: [
        {
          "title": "Birds",
          "rows": [
            {
              "id": "1001",
              "title": "Peacock",
              "description": "Lifespan: 15 years"
            },
            {
              "id": "1002",
              "title": "Cardinal",
              "description": "Lifespan: 12 years"
            },
            {
              "id": "1003",
              "title": "Cockatiel",
              "description": "Lifespan: 10 years"
            }
          ]
        },
        {
          "title": "Wild Animals",
          "rows": [
            {
              "id": "2001",
              "title": "Lion",
              "description": "Lifespan: 15 years"
            },
            {
              "id": "2002",
              "title": "Tiger",
              "description": "Lifespan: 12 years"
            },
            {
              "id": "2003",
              "title": "Elephant",
              "description": "Lifespan: 10 years"
            }
          ]
        }
      ],
    );
    testResponse(res);
    expect(res.isSuccess(), true);
  });

  test('sendCallToActionButton()', () async {
    var res = await client.sendCallToActionButton(
      phoneNumber: phoneNumber,
      bodyText: "Please have a look to my website.",
      buttonText: "Open",
      actionUrl: "https://rohitchouhan.com",
    );
    testResponse(res);
    expect(res.isSuccess(), true);
  });

  test('sendContactDetails()', () async {
    var res = await client.sendContactDetails(
        phoneNumber: phoneNumber,
        dateOfBirth: "1990-01-01",
        addresses: [
          {
            "street": "Ajmer",
            "city": "Ajmer",
            "state": "Rajasthan",
            "zip": "305001",
            "country": "India",
            "country_code": "in",
            "type": "contact",
          }
        ],
        emails: [
          {"email": "me@rohitchouhan.com", "type": "contact"},
        ],
        organization: {
          "company": "Codebrine",
          "department": "IT",
          "title": "Founder"
        },
        person: {
          "formatted_name": "Rohit Chouhan",
          "first_name": "Rohit",
          "last_name": "Chouhan",
          "middle_name": "",
          "suffix": "Mr.",
          "prefix": "Mr."
        },
        phones: [
          {"phone": "+919999999999", "type": "Home"},
        ],
        urls: [
          {"url": "https://rohitchouhan.com", "type": "Personal Website"},
        ]);

    testResponse(res);
    //expect(res.isSuccess(), true);
  });

  test('uploadMediaFile()', () async {
    var res = await client.uploadMediaFile(
      file: File('test/image.png'),
      fileType: 'image/png',
    );
    debugPrint(res.getMediaId());
    testResponse(res);
    expect(res.isSuccess(), true);
  });

  test('uploadMediaFileByUrl()', () async {
    var res = await client.uploadMediaFileByUrl(
      fileUrl:
          'https://www.akc.org/wp-content/uploads/2015/03/so-you-want-to-breed-dogs-500x500.jpg',
      fileType: 'image/jpeg',
    );
    debugPrint(res.getMediaId());
    testResponse(res);
    //expect(res.isSuccess(), true);
  });

  test('getMedia()', () async {
    var res = await client.getMedia(mediaId: "1041224066853401");
    debugPrint(res.getMediaFileSize());
    debugPrint(res.getMediaId());
    debugPrint(res.getMediaMimeType());
    debugPrint(res.getMediaSha256());
    debugPrint(res.getMediaUrl());
    testResponse(res);
    expect(res.isSuccess(), true);
  });

  test('deleteMedia()', () async {
    var res = await client.deleteMedia(
      mediaId: uploadingFileId,
    );
    testResponse(res);
    expect(res.isSuccess(), true);
  });

  test('accountMigrationRegister()', () async {
    var res = await client.accountMigrationRegister(
        digitsPinCode: "123456", backupData: "TEST", password: "TEST123");
    testResponse(res);
    expect(res.isSuccess(), true);
  });

  test('getBusinessProfile()', () async {
    var res = await client.getBusinessProfile();
    testResponse(res);
    expect(res.isSuccess(), true);
  });

  test('updateBusinessProfile()', () async {
    var res = await client.updateBusinessProfile(
      about: "My Name is Rohit Chouhan",
      email: "me@rohitchouhan.com",
    );
    testResponse(res);
    expect(res.isSuccess(), true);
  });

  test('requestCode()', () async {
    var res = await client.requestCode(codeMethod: 'SMS', language: 'en');
    testResponse(res);
    expect(res.isSuccess(), true);
  });

  test('verifyCode()', () async {
    var res = await client.verifyCode(code: 123456);
    testResponse(res);
    expect(res.isSuccess(), true);
  });

  test('register()', () async {
    var res = await client.register(pin: 123456);
    testResponse(res);
    expect(res.isSuccess(), true);
  });

  test('deregister()', () async {
    var res = await client.deRegister();
    testResponse(res);
    expect(res.isSuccess(), true);
  });

  test('sendTemplate()', () async {
    var res = await client.sendTemplate(
        phoneNumber: phoneNumber,
        template: "one_time_pass",
        language: "en_US",
        placeholder: [
          {"type": "text", "text": "111111"}
        ]);
    testResponse(res);
    expect(res.isSuccess(), true);
  });

  test('twoStepVerification()', () async {
    var res = await client.twoStepVerification(pin: 123456);
    testResponse(res);
    expect(res.isSuccess(), true);
  });
  test('sendCustomRequest()', () async {
    var res = await client.sendCustomRequest(path: '/messages', payload: {
      "messaging_product": "whatsapp",
      "recipient_type": "individual",
      "to": "+917023042306",
      "type": "text",
      "text": {"preview_url": false, "body": "Hello"}
    });
    testResponse(res);
    expect(res.isSuccess(), true);
  });

  test('replay()', () async {
    var res = await client.replay(
      phoneNumber: phoneNumber,
      messageId: testMessageId,
      replay: Replay().text("nice", true),
    );
    testResponse(res);
    expect(res.isSuccess(), true);
  });
}

testResponse(Request res) {
  if (!res.isSuccess()) {
    debugPrint('Response: ${res.getResponse()}');
    debugPrint('Error API: ${res.getErrorMessage()}');
    debugPrint('Error: ${res.getError()}');
  } else {
    debugPrint('ID: ${res.getMessageId()}');
  }
}
