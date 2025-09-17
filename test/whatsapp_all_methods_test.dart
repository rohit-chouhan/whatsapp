import 'package:flutter_test/flutter_test.dart';
import 'package:whatsapp/whatsapp.dart';

void main() {
  group('WhatsApp public API surface', () {
    late WhatsApp whatsapp;

    setUp(() {
      whatsapp = WhatsApp('test_access_token', 'test_phone_number_id');
    });

    test('constructor creates instance', () {
      expect(whatsapp, isA<WhatsApp>());
    });

    test('setVersion does not throw', () {
      expect(() => whatsapp.setVersion('v21.0'), returnsNormally);
    });

    test('getLink generates wa.me link', () {
      final link = whatsapp.getLink(
        phoneNumber: '1234567890',
        message: 'Hello World',
        bold: ['World'],
        italic: ['Hello'],
        strikethrough: [],
        monospace: [],
      );
      expect(link, contains('wa.me'));
      expect(link, contains('1234567890'));
    });

    // Network dependent tests - skipped by default.
    test('sendMessage', () async {
      // This test performs a network call; keep skipped unless mocking Request/http.
      final future = whatsapp.sendMessage(
        phoneNumber: '1234567890',
        text: 'hello',
        previewUrl: true,
      );
      expect(future, completes);
    }, skip: true);

    test('sendImageById', () async {
      expect(
        whatsapp.sendImageById(
          phoneNumber: '1234567890',
          mediaId: 'media_id',
          caption: 'cap',
        ),
        completes,
      );
    }, skip: true);

    test('sendImageByUrl', () async {
      expect(
        whatsapp.sendImageByUrl(
          phoneNumber: '1234567890',
          imageUrl: 'https://example.com/image.jpg',
          caption: 'cap',
        ),
        completes,
      );
    }, skip: true);

    test('sendAudioById', () async {
      expect(
        whatsapp.sendAudioById(
          phoneNumber: '1234567890',
          mediaId: 'media_id',
        ),
        completes,
      );
    }, skip: true);

    test('sendAudioByUrl', () async {
      expect(
        whatsapp.sendAudioByUrl(
          phoneNumber: '1234567890',
          audioUrl: 'https://example.com/audio.mp3',
        ),
        completes,
      );
    }, skip: true);

    test('sendDocumentById', () async {
      expect(
        whatsapp.sendDocumentById(
          phoneNumber: '1234567890',
          mediaId: 'media_id',
          caption: 'cap',
          filename: 'file.pdf',
        ),
        completes,
      );
    }, skip: true);

    test('sendDocumentByUrl', () async {
      expect(
        whatsapp.sendDocumentByUrl(
          phoneNumber: '1234567890',
          documentUrl: 'https://example.com/file.pdf',
          caption: 'cap',
          filename: 'file.pdf',
        ),
        completes,
      );
    }, skip: true);

    test('sendVideoById', () async {
      expect(
        whatsapp.sendVideoById(
          phoneNumber: '1234567890',
          mediaId: 'media_id',
          caption: 'cap',
        ),
        completes,
      );
    }, skip: true);

    test('sendVideoByUrl', () async {
      expect(
        whatsapp.sendVideoByUrl(
          phoneNumber: '1234567890',
          videoUrl: 'https://example.com/video.mp4',
          caption: 'cap',
        ),
        completes,
      );
    }, skip: true);

    test('markAsRead', () async {
      expect(
        whatsapp.markAsRead(messageId: 'wamid.sample'),
        completes,
      );
    }, skip: true);

    test('sendSticker', () async {
      expect(
        whatsapp.sendSticker(
          phoneNumber: '1234567890',
          stickerId: 'sticker_id',
        ),
        completes,
      );
    }, skip: true);

    test('sendReaction', () async {
      expect(
        whatsapp.sendReaction(
          phoneNumber: '1234567890',
          messageId: 'wamid.sample',
          emoji: '👍',
        ),
        completes,
      );
    }, skip: true);

    test('sendLocationRequest', () async {
      expect(
        whatsapp.sendLocationRequest(
          phoneNumber: '1234567890',
          text: 'Please share location',
        ),
        completes,
      );
    }, skip: true);

    test('sendLocation', () async {
      expect(
        whatsapp.sendLocation(
          phoneNumber: '1234567890',
          latitude: 0.0,
          longitude: 0.0,
          name: 'Test',
          address: 'Addr',
        ),
        completes,
      );
    }, skip: true);

    test('sendInteractiveReplyButton', () async {
      expect(
        whatsapp.sendInteractiveReplyButton(
          phoneNumber: '1234567890',
          headerInteractive: {'type': 'text', 'text': 'Header'},
          bodyText: 'Body',
          footerText: 'Footer',
          interactiveReplyButtons: [
            {'type': 'reply', 'reply': {'id': 'yes', 'title': 'Yes'}},
          ],
        ),
        completes,
      );
    }, skip: true);

    test('sendInteractiveLists', () async {
      expect(
        whatsapp.sendInteractiveLists(
          phoneNumber: '1234567890',
          headerText: 'Header',
          bodyText: 'Body',
          footerText: 'Footer',
          buttonText: 'Choose',
          sections: [
            {'title': 'Sec', 'rows': []},
          ],
        ),
        completes,
      );
    }, skip: true);

    test('sendCallToActionButton', () async {
      expect(
        whatsapp.sendCallToActionButton(
          phoneNumber: '1234567890',
          headerText: 'Header',
          bodyText: 'Body',
          footerText: 'Footer',
          buttonText: 'Open',
          actionUrl: 'https://example.com',
        ),
        completes,
      );
    }, skip: true);

    test('sendContactDetails', () async {
      expect(
        whatsapp.sendContactDetails(
          phoneNumber: '1234567890',
          person: {'name': {'formatted_name': 'John Doe'}},
          phones: [
            {'phone': '+123', 'type': 'WORK'},
          ],
          addresses: [],
          emails: [],
          organization: null,
          urls: [],
        ),
        completes,
      );
    }, skip: true);

    test('uploadMediaFile (by File)', () async {
      // Requires real file; keep skipped.
      // expect(whatsapp.uploadMediaFile(file: File('path'), fileType: 'image/jpeg'), completes);
    }, skip: true);

    test('uploadMediaFileByUrl', () async {
      expect(
        whatsapp.uploadMediaFileByUrl(
          fileUrl: 'https://example.com/image.jpg',
          fileType: 'image/jpeg',
        ),
        completes,
      );
    }, skip: true);

    test('getMedia', () async {
      expect(
        whatsapp.getMedia(mediaId: 'media_id'),
        completes,
      );
    }, skip: true);

    test('deleteMedia', () async {
      expect(
        whatsapp.deleteMedia(mediaId: 'media_id'),
        completes,
      );
    }, skip: true);

    test('accountMigrationRegister', () async {
      expect(
        whatsapp.accountMigrationRegister(
          digitsPinCode: '000000',
          password: 'pass',
          backupData: 'data',
        ),
        completes,
      );
    }, skip: true);

    test('getBusinessProfile', () async {
      expect(
        whatsapp.getBusinessProfile(scope: ['name']),
        completes,
      );
    }, skip: true);

    test('updateBusinessProfile', () async {
      expect(
        whatsapp.updateBusinessProfile(
          about: 'About',
          address: 'Addr',
          description: 'Desc',
          industry: 'Tech',
          email: 'a@b.com',
          websites: ['https://example.com'],
          profilePictureHandle: 'handle',
        ),
        completes,
      );
    }, skip: true);

    test('requestCode', () async {
      expect(whatsapp.requestCode(codeMethod: 'SMS', language: 'en'), completes);
    }, skip: true);

    test('verifyCode', () async {
      expect(whatsapp.verifyCode(code: 123456), completes);
    }, skip: true);

    test('register', () async {
      expect(
        whatsapp.register(pin: 123456, enableLocalStorage: true, dataLocalizationRegion: 'US'),
        completes,
      );
    }, skip: true);

    test('deRegister', () async {
      expect(whatsapp.deRegister(), completes);
    }, skip: true);

    test('reply', () async {
      expect(
        whatsapp.reply(
          phoneNumber: '1234567890',
          messageId: 'wamid.sample',
          reply: {
            'type': 'text',
            'text': {'body': 'Replying...'},
          },
        ),
        completes,
      );
    }, skip: true);

    test('sendTemplate', () async {
      expect(
        whatsapp.sendTemplate(
          phoneNumber: '1234567890',
          template: 'hello_world',
          language: 'en_US',
          placeholder: [
            {'type': 'text', 'text': 'name'},
          ],
        ),
        completes,
      );
    }, skip: true);

    test('twoStepVerification', () async {
      expect(whatsapp.twoStepVerification(pin: 123456), completes);
    }, skip: true);

    test('sendCustomRequest', () async {
      expect(
        whatsapp.sendCustomRequest(
          path: '/messages',
          payload: {
            'messaging_product': 'whatsapp',
          },
        ),
        completes,
      );
    }, skip: true);

    // New v4 methods
    test('sendFlowMessage', () async {
      expect(
        whatsapp.sendFlowMessage(
          phoneNumber: '1234567890',
          flowToken: 'flow_token',
          flowId: 'flow_id',
          flowCta: 'CTA',
          flowActionPayload: '{"screen":"WELCOME"}',
          headerText: 'Header',
          bodyText: 'Body',
          footerText: 'Footer',
        ),
        completes,
      );
    }, skip: true);

    test('sendCatalogMessage', () async {
      expect(
        whatsapp.sendCatalogMessage(
          phoneNumber: '1234567890',
          catalogId: 'catalog_id',
          productRetailerId: 'retailer_id',
          headerText: 'Header',
          bodyText: 'Body',
          footerText: 'Footer',
        ),
        completes,
      );
    }, skip: true);

    test('sendProductMessage', () async {
      expect(
        whatsapp.sendProductMessage(
          phoneNumber: '1234567890',
          catalogId: 'catalog_id',
          productRetailerId: 'retailer_id',
        ),
        completes,
      );
    }, skip: true);

    test('getMessageStatus', () async {
      expect(whatsapp.getMessageStatus('wamid.sample'), completes);
    }, skip: true);

    test('markAsDelivered', () async {
      expect(whatsapp.markAsDelivered('wamid.sample'), completes);
    }, skip: true);
  });
}
