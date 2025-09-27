import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:whatsapp/whatsapp.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  late WhatsApp whatsapp;

  String? imageMediaId;
  String? audioMediaId;
  String? documentMediaId;
  String? videoMediaId;
  String? stickerMediaId;
  String? uploadId;

  final String phoneNumber = dotenv.env['RECEIPT_NUMBER']!;
  final String accessToken = dotenv.env['ACCESS_TOKEN']!;
  final String phoneNumberId = dotenv.env['PHONE_NUMBER_ID']!;
  final String waMessageId = dotenv.env['WA_MESSAGE_ID']!;

  // Removed duplicate waMessageId declaration

  setUpAll(() async {
    whatsapp = WhatsApp(accessToken, phoneNumberId);
  });

  group('uploadMediaFileByUrl Media Tests', () {
    //image
    test('uploadMediaFileByUrl (Image) success', () async {
      final fileUrl =
          'https://raw.githack.com/rohit-chouhan/whatsapp/main/sample_files/sample.png';
      final uploadImage = await whatsapp.uploadMediaFileByUrl(
        fileUrl: fileUrl,
        fileType: whatsapp.getAutoFileType(filePath: fileUrl),
      );
      if (uploadImage.isSuccess()) {
        imageMediaId = uploadImage.getMediaId();
      }
      print('Response: ${uploadImage.getFullResponse()}');
      expect(uploadImage.isSuccess(), true);
      expect(uploadImage.getMediaId(), isNotNull);
    });

    //audio
    test('uploadMediaFileByUrl (Audio) success', () async {
      final uploadAudio = await whatsapp.uploadMediaFileByUrl(
        fileUrl:
            'https://raw.githack.com/rohit-chouhan/whatsapp/main/sample_files/sample.mp3',
        fileType: 'audio/mpeg',
      );
      if (uploadAudio.isSuccess()) {
        audioMediaId = uploadAudio.getMediaId();
      }
      print('Response: ${uploadAudio.getFullResponse()}');
      expect(uploadAudio.isSuccess(), true);

      expect(uploadAudio.getMediaId(), isNotNull);
    });

    //document
    test('uploadMediaFileByUrl (Document) success', () async {
      final uploadDocument = await whatsapp.uploadMediaFileByUrl(
        fileUrl:
            'https://raw.githack.com/rohit-chouhan/whatsapp/main/sample_files/sample.pdf',
        fileType: 'application/pdf',
      );

      if (uploadDocument.isSuccess()) {
        documentMediaId = uploadDocument.getMediaId();
      }
      print('Response: ${uploadDocument.getFullResponse()}');
      expect(uploadDocument.isSuccess(), true);
      expect(uploadDocument.getMediaId(), isNotNull);
    });

    //video
    test('uploadMediaFileByUrl (Video) success', () async {
      final uploadVideo = await whatsapp.uploadMediaFileByUrl(
        fileUrl:
            'https://raw.githack.com/rohit-chouhan/whatsapp/main/sample_files/sample.mp4',
        fileType: 'video/mp4',
      );
      if (uploadVideo.isSuccess()) {
        videoMediaId = uploadVideo.getMediaId();
      }
      print('Response: ${uploadVideo.getFullResponse()}');
      expect(uploadVideo.isSuccess(), true);
      expect(uploadVideo.getMediaId(), isNotNull);
    });

    //sticker
    test('uploadMediaFileByUrl (Sticker) success', () async {
      final uploadSticker = await whatsapp.uploadMediaFileByUrl(
        fileUrl:
            'https://raw.githack.com/rohit-chouhan/whatsapp/main/sample_files/sample.webp',
        fileType: 'image/webp',
      );
      if (uploadSticker.isSuccess()) {
        stickerMediaId = uploadSticker.getMediaId();
      }
      print('Response: ${uploadSticker.getFullResponse()}');
      expect(uploadSticker.isSuccess(), true);
      expect(uploadSticker.getMediaId(), isNotNull);
    });
  });

  group('uploadMediaFile Media Tests', () {
    //image
    test('uploadMediaFile (Image) success', () async {
      final uploadImage = await whatsapp.uploadMediaFile(
        file: File('sample_files/sample.png'),
        fileType: 'image/png',
      );
      print('Response: ${uploadImage.getFullResponse()}');
      expect(uploadImage.isSuccess(), true);
      expect(uploadImage.getMediaId(), isNotNull);
    });

    //audio
    test('uploadMediaFile (Audio) success', () async {
      final uploadAudio = await whatsapp.uploadMediaFile(
        file: File('sample_files/sample.mp3'),
        fileType: 'audio/mpeg',
      );
      print('Response: ${uploadAudio.getFullResponse()}');
      expect(uploadAudio.isSuccess(), true);
      expect(uploadAudio.getMediaId(), isNotNull);
    });

    //pdf document
    test('uploadMediaFile (Document) success', () async {
      final uploadDocument = await whatsapp.uploadMediaFile(
        file: File('sample_files/sample.pdf'),
        fileType: 'application/pdf',
      );
      print('Response: ${uploadDocument.getFullResponse()}');
      expect(uploadDocument.isSuccess(), true);
      expect(uploadDocument.getMediaId(), isNotNull);
    });

    //video
    test('uploadMediaFile (Video) success', () async {
      final uploadVideo = await whatsapp.uploadMediaFile(
        file: File('sample_files/sample.mp4'),
        fileType: 'video/mp4',
      );
      print('Response: ${uploadVideo.getFullResponse()}');
      expect(uploadVideo.isSuccess(), true);
      expect(uploadVideo.getMediaId(), isNotNull);
    });

    //sticker
    test('uploadMediaFile (Sticker) success', () async {
      final uploadSticker = await whatsapp.uploadMediaFile(
        file: File('sample_files/sample.webp'),
        fileType: 'image/webp',
      );
      if (uploadSticker.isSuccess()) {
        stickerMediaId = uploadSticker.getMediaId();
      }
      print('Response: ${uploadSticker.getFullResponse()}');
      expect(uploadSticker.isSuccess(), true);
      expect(uploadSticker.getMediaId(), isNotNull);
    });
  });

  group('WhatsApp Client Tests', () {
    test('constructor creates instance', () {
      expect(whatsapp, isA<WhatsApp>());
    });

    test('setVersion does not throw', () {
      expect(() => whatsapp.setVersion('v23.0'), returnsNormally);
    });

    test('getLink generates wa.me link', () {
      final link = whatsapp.getLink(
        phoneNumber: phoneNumber,
        message: 'Hello World',
        bold: ['World'],
        italic: ['Hello'],
        strikethrough: [],
        monospace: [],
      );
      expect(link, contains('https://'));
      expect(link, contains(phoneNumber));
      expect(link, contains('_Hello_'));
      expect(link, contains('*World*'));
    });
  });

  group('Message Sending Tests', () {
    test('sendMessage success', () async {
      final result = await whatsapp.sendMessage(
        phoneNumber: phoneNumber,
        text: 'Test message',
        previewUrl: true,
      );

      print('\nsendMessage response: ${result.getFullResponse()}');
      expect(result.isSuccess(), true);
      expect(result.getMessageId(), isNotNull);
      expect(result.getContactId(), phoneNumber);
    });

    test('sendImageById success', () async {
      if (imageMediaId == null) return;

      final result = await whatsapp.sendImageById(
        phoneNumber: phoneNumber,
        imageId: imageMediaId!,
        caption: 'Test caption (ID)',
      );

      print('\nsendImageById response: ${result.getFullResponse()}');
      expect(result.isSuccess(), true);
      expect(result.getMessageId(), isNotNull);
    });

    test('sendImageByUrl success', () async {
      final result = await whatsapp.sendImageByUrl(
        phoneNumber: phoneNumber,
        imageUrl:
            'https://raw.githack.com/rohit-chouhan/whatsapp/main/sample_files/sample.png',
        caption: 'Test image (URL)',
      );
      print('Response: ${result.getFullResponse()}');
      expect(result.isSuccess(), true);
      expect(result.getMessageId(), isNotNull);
    });

    test('sendAudioById success', () async {
      if (audioMediaId == null) return;

      final result = await whatsapp.sendAudioById(
        phoneNumber: phoneNumber,
        audioId: audioMediaId!,
      );
      print('Response: ${result.getFullResponse()}');
      expect(result.isSuccess(), true);
      expect(result.getMessageId(), isNotNull);
    });

    test('sendAudioByUrl success', () async {
      final result = await whatsapp.sendAudioByUrl(
        phoneNumber: phoneNumber,
        audioUrl:
            'https://raw.githack.com/rohit-chouhan/whatsapp/main/sample_files/sample.mp3',
      );
      print('Response: ${result.getFullResponse()}');
      expect(result.isSuccess(), true);
      expect(result.getMessageId(), isNotNull);
    });

    test('sendDocumentById success', () async {
      if (documentMediaId == null) return;

      final result = await whatsapp.sendDocumentById(
        phoneNumber: phoneNumber,
        documentId: documentMediaId!,
        caption: 'Test document (ID)',
        filename: 'test.pdf',
      );
      print('Response: ${result.getFullResponse()}');
      expect(result.isSuccess(), true);
      expect(result.getMessageId(), isNotNull);
    });

    test('sendDocumentByUrl success', () async {
      final result = await whatsapp.sendDocumentByUrl(
        phoneNumber: phoneNumber,
        documentUrl:
            'https://raw.githack.com/rohit-chouhan/whatsapp/main/sample_files/sample.pdf',
        caption: 'Test document (URL)',
        filename: 'test.pdf',
      );
      print('Response: ${result.getFullResponse()}');
      expect(result.isSuccess(), true);
      expect(result.getMessageId(), isNotNull);
    });

    test('sendVideoById success', () async {
      if (videoMediaId == null) return;

      final result = await whatsapp.sendVideoById(
        phoneNumber: phoneNumber,
        videoId: videoMediaId!,
        caption: 'Test video (ID)',
      );
      print('Response: ${result.getFullResponse()}');
      expect(result.isSuccess(), true);
      expect(result.getMessageId(), isNotNull);
    });

    test('sendVideoByUrl success', () async {
      final result = await whatsapp.sendVideoByUrl(
        phoneNumber: phoneNumber,
        videoUrl:
            'https://raw.githack.com/rohit-chouhan/whatsapp/main/sample_files/sample.mp4',
        caption: 'Test video (URL)',
      );
      print('Response: ${result.getFullResponse()}');
      expect(result.isSuccess(), true);
      expect(result.getMessageId(), isNotNull);
    });

    test('sendStickerById success', () async {
      final result = await whatsapp.sendSticker(
        phoneNumber: phoneNumber,
        stickerId: stickerMediaId!,
      );
      print('Response: ${result.getFullResponse()}');
      expect(result.isSuccess(), true);
      expect(result.getMessageId(), isNotNull);
    });

    test('sendStickerByUrl success', () async {
      final result = await whatsapp.sendStickerByUrl(
        phoneNumber: phoneNumber,
        stickerUrl:
            'https://raw.githack.com/rohit-chouhan/whatsapp/main/sample_files/sample.webp',
      );
      print('Response: ${result.getFullResponse()}');
      expect(result.isSuccess(), true);
      expect(result.getMessageId(), isNotNull);
    });
  });

  group('Interactive Messages Tests', () {
    test('sendInteractiveReplyButton success', () async {
      final result = await whatsapp.sendInteractiveReplyButton(
        phoneNumber: phoneNumber,
        headerInteractive: {'type': 'text', 'text': 'Choose an Option'},
        bodyText: 'Please select one of the options below:',
        footerText: 'Test Suite',
        interactiveReplyButtons: [
          {
            'type': 'reply',
            'reply': {'id': 'yes', 'title': 'Yes'}
          },
          {
            'type': 'reply',
            'reply': {'id': 'no', 'title': 'No'}
          },
        ],
      );
      print('Response: ${result.getFullResponse()}');
      expect(result.isSuccess(), true);
      expect(result.getMessageId(), isNotNull);
    });

    test('sendInteractiveLists success', () async {
      final result = await whatsapp.sendInteractiveLists(
        phoneNumber: phoneNumber,
        headerText: 'Select from List',
        bodyText: 'Choose an option from the list below',
        footerText: 'Test Suite',
        buttonText: 'Choose Option',
        sections: [
          {
            'title': 'Test Section',
            'rows': [
              {'id': 'option1', 'title': 'Option 1'},
              {'id': 'option2', 'title': 'Option 2'},
            ]
          },
        ],
      );
      print('Response: ${result.getFullResponse()}');
      expect(result.isSuccess(), true);
      expect(result.getMessageId(), isNotNull);
    });

    test('sendCallToActionButton success', () async {
      final result = await whatsapp.sendCallToActionButton(
        phoneNumber: phoneNumber,
        headerText: 'Visit Our Website',
        bodyText: 'Click the button below to visit our site',
        footerText: 'Test Suite',
        buttonText: 'Visit Website',
        actionUrl: 'https://rohitchouhan.com',
      );
      print('Response: ${result.getFullResponse()}');
      expect(result.isSuccess(), true);
      expect(result.getMessageId(), isNotNull);
    });
  });

  group('Location Tests', () {
    test('sendLocationRequest success', () async {
      final result = await whatsapp.sendLocationRequest(
        phoneNumber: phoneNumber,
        text: 'Please share your location',
      );
      print('Response: ${result.getFullResponse()}');
      expect(result.isSuccess(), true);
      expect(result.getMessageId(), isNotNull);
    });

    test('sendLocation success', () async {
      final result = await whatsapp.sendLocation(
        phoneNumber: phoneNumber,
        latitude: 37.7749,
        longitude: -122.4194,
        name: 'San Francisco',
        address: 'San Francisco, CA, USA',
      );
      print('Response: ${result.getFullResponse()}');
      expect(result.isSuccess(), true);
      expect(result.getMessageId(), isNotNull);
    });
  });

  group('Contact Tests', () {
    test('sendContactDetails success', () async {
      final result = await whatsapp.sendContactDetails(
        phoneNumber: phoneNumber,
        person: {
          'formatted_name': 'John Doe',
          'first_name': 'John',
          'last_name': 'Doe'
        },
        phones: [
          {'phone': '+1234567890', 'type': 'WORK'},
        ],
        addresses: [
          {'street': '123 Test St', 'city': 'Test City', 'type': 'WORK'}
        ],
        emails: [
          {'email': 'test@example.com', 'type': 'WORK'}
        ],
        organization: {'company': 'Test Company'},
        urls: [
          {'url': 'https://example.com', 'type': 'WORK'}
        ],
      );
      print('Response: ${result.getFullResponse()}');
      expect(result.isSuccess(), true);
      expect(result.getMessageId(), isNotNull);
    });
  });

  group('Reaction Tests', () {
    test('sendReaction success', () async {
      final result = await whatsapp.sendReaction(
        phoneNumber: phoneNumber,
        messageId: waMessageId,
        emoji: '👍',
      );
      print('Response: ${result.getFullResponse()}');
      expect(result.isSuccess(), true);
      expect(result.getMessageId(), isNotNull);
    });
  });

  group('Status Tests', () {
    test('markAsRead success', () async {
      final result = await whatsapp.markAsRead(messageId: waMessageId);
      print('Response: ${result.getFullResponse()}');
      expect(result.isSuccess(), true);
    });

    test('sendTypingIndicator success', () async {
      final result = await whatsapp.sendTypingIndicator(messageId: waMessageId);
      print('Response: ${result.getFullResponse()}');
      expect(result.isSuccess(), true);
    });
  });

  group('Reply Tests', () {
    test('reply success', () async {
      final result = await whatsapp.reply(
        phoneNumber: phoneNumber,
        messageId: waMessageId,
        reply: {
          'type': 'text',
          'text': {'body': 'This is a reply'},
        },
      );
      print('Response: ${result.getFullResponse()}');
      if (!result.isSuccess()) {
        print('Reply response: ${result.getFullResponse()}');
      }
      expect(result.isSuccess(), true);
    });
  });

  group('Template Tests', () {
    test('sendTemplate success', () async {
      final result = await whatsapp.sendTemplate(
        phoneNumber: phoneNumber,
        template: 'account_creation_confirmation',
        language: 'en_US',
        placeholder: [
          {"type": "text", "text": "John Doe"},
          {"type": "text", "text": "john@example.com"}
        ],
      );
      print('Response: ${result.getFullResponse()}');
      expect(result.isSuccess(), true);
      expect(result.getMessageId(), isNotNull);
    });
  });

  group('Custom Request Tests', () {
    test('sendCustomRequest success', () async {
      final result = await whatsapp.sendCustomRequest(
        path: '/messages',
        payload: {
          'messaging_product': 'whatsapp',
          'to': phoneNumber,
          'type': 'text',
          'text': {'body': 'Custom request test'},
        },
      );
      print('Response: ${result.getFullResponse()}');
      expect(result.isSuccess(), true);
      expect(result.getMessageId(), isNotNull);
    });
  });

  group('Flow Tests', () {
    test('sendFlowMessage success', () async {
      var result = await whatsapp.sendFlowMessage(
        phoneNumber: phoneNumber,
        flowToken: 'unused',
        flowId: '825115873182362',
        flowCta: 'Start Flow',
        flowActionPayload: {'screen': 'RECOMMEND'},
        headerText: 'Flow Test Header',
        bodyText: 'This is a flow message test',
        footerText: 'Test Suite',
      );
      print('Response: ${result.getFullResponse()}');
      expect(result.isSuccess(), true);
      expect(result.getMessageId(), isNotNull);
    });
  });

  group('Catalog Tests', () {
    test('sendCatalogMessage success', () async {
      final result = await whatsapp.sendCatalogMessage(
        phoneNumber: phoneNumber,
        productRetailerId: 'SFPRO-001',
        headerText: 'Browse Our Catalog',
        bodyText: 'Check out our products',
        footerText: 'Test Suite',
      );
      print('Response: ${result.getFullResponse()}');
      expect(result.isSuccess(), true);
      expect(result.getMessageId(), isNotNull);
    });

    test('sendProductMessage success', () async {
      final result = await whatsapp.sendProductMessage(
        phoneNumber: phoneNumber,
        catalogId: '1322891656100432',
        productRetailerId: 'SFPRO-001',
        bodyText: "Available",
        footerText: "Limited Offer",
      );
      print('Response: ${result.getFullResponse()}');
      print('Product response: ${result.getFullResponse()}');
      expect(result.isSuccess(), true);
      expect(result.getMessageId(), isNotNull);
    });
  });

  group('Media Management Tests', () {
    test('uploadMediaFileByUrl', () async {
      var result = await whatsapp.uploadMediaFileByUrl(
        fileUrl:
            'https://raw.githack.com/rohit-chouhan/whatsapp/main/sample_files/sample.png',
        fileType: 'image/png',
      );
      print('Response: ${result.getFullResponse()}');
      expect(result.isSuccess(), true);
      expect(result.getMediaId(), isNotNull);
      imageMediaId = result.getMediaId();
    });

    test('getMedia success', () async {
      if (imageMediaId == null) return;

      final result = await whatsapp.getMedia(mediaId: imageMediaId!);
      print('Response: ${result.getFullResponse()}');
      expect(result.isSuccess(), true);
      expect(result.getMediaUrl(), isNotNull);
      expect(result.getMediaMimeType(), isNotNull);
    });

    test('deleteMedia success', () async {
      if (imageMediaId == null) return;

      final result = await whatsapp.deleteMedia(mediaId: imageMediaId!);
      print('Response: ${result.getFullResponse()}');
      expect(result.isSuccess(), true);
    });
  });

  group('Business Profile Tests', () {
    test('getBusinessProfile success', () async {
      final result = await whatsapp.getBusinessProfile(
        scope: ['name', 'about', 'address'],
      );
      print('Response: ${result.getFullResponse()}');
      expect(result.isSuccess(), true);
      expect(result.getAbout(), isNotNull);
    });

    test('updateBusinessProfile success', () async {
      final result = await whatsapp.updateBusinessProfile(
        about: 'Updated business description',
        address: 'New Address',
        email: 'test@example.com',
      );
      print('Response: ${result.getFullResponse()}');
      expect(result.isSuccess(), true);
    });
  });

  group('Account Management Tests', () {
    test('blockUsers success', () async {
      final result = await whatsapp.blockUsers(users: ['918197569103']);

      print('Block response: ${result.getFullResponse()}');
      expect(result.isSuccess(), false);
    });

    test('unblockUsers success', () async {
      final result = await whatsapp.unblockUsers(users: ['918197569103']);

      if (!result.isSuccess()) {
        print('Unblock response: ${result.getFullResponse()}');
      }
      expect(result.isSuccess(), true);
    });

    test('getBlockedUsers success', () async {
      final result = await whatsapp.getBlockedUsers();
      print('Response: ${result.getFullResponse()}');
      expect(result.isSuccess(), true);
    });
  });

  group('Resumable Tests', () {
    test('createResumableUploadSession success', () async {
      var result = await whatsapp.createResumableUploadSession(
        fileLength: 210915,
        fileType: 'image/png',
        fileName: 'sample.png',
      );
      uploadId = result.getId();
      print('Response: ${result.getFullResponse()}');
      expect(result.isSuccess(), true);
      expect(uploadId, isNotNull);
    });

    test('getResumableUploadSession success', () async {
      print("Picked uploadId: $uploadId");
      var result = await whatsapp.getResumableUploadSession(
        uploadId: uploadId!,
      );
      print('Response: ${result.getFullResponse()}');
      expect(result.isSuccess(), true);
      expect(result.getId(), isNotNull);
      expect(result.getFileOffset(), isNotNull);
    });

    test('uploadResumableFile success', () async {
      print("Picked uploadId: $uploadId");
      var result = await whatsapp.uploadResumableFile(
        uploadId: uploadId!,
        file: File('sample_files/resumable-sample.png'),
        fileType: 'image/png',
      );
      print('Response: ${result.getFullResponse()}');
      expect(result.isSuccess(), true);
      expect(result.getH(), isNotNull);
    });

    test('uploadResumableFileByUrl success', () async {
      print("Picked uploadId: $uploadId");
      var result = await whatsapp.uploadResumableFileByUrl(
        uploadId: uploadId!,
        fileUrl:
            'http://raw.githack.com/rohit-chouhan/whatsapp/main/sample_files/resumable-sample.png',
        fileType: 'image/png',
      );
      print('Response: ${result.getFullResponse()}');
      expect(result.isSuccess(), true);
      expect(result.getH(), isNotNull);
    });

    test('createUploadResumableFile success', () async {
      var result = await whatsapp.createUploadResumableFile(
        fileLength: 210915,
        file: File('sample_files/resumable-sample.png'),
        fileType: 'image/png',
        fileName: 'resumable-sample.png',
      );
      print('Response: ${result.getFullResponse()}');
      expect(result.isSuccess(), true);
      expect(result.getH(), isNotNull);
    });

    test('createUploadResumableFileByUrl success', () async {
      var result = await whatsapp.createUploadResumableFile(
        fileLength: 210915,
        fileUrl:
            'http://raw.githack.com/rohit-chouhan/whatsapp/main/sample_files/resumable-sample.png',
        fileType: 'image/png',
        fileName: 'resumable-sample.png',
      );
      print('Response: ${result.getFullResponse()}');
      expect(result.isSuccess(), true);
      expect(result.getH(), isNotNull);
    });
  });
}
