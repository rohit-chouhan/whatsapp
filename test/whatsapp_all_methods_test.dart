import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:whatsapp/whatsapp.dart';

/// --- Response Models ---
class WhatsAppResponse {
  final String messagingProduct;
  final List<Contact> contacts;
  final List<Message> messages;
  final Map<String, dynamic> rawResponse;

  WhatsAppResponse({
    required this.messagingProduct,
    required this.contacts,
    required this.messages,
    required this.rawResponse,
  });

  factory WhatsAppResponse.fromJson(Map<String, dynamic> json) {
    return WhatsAppResponse(
      messagingProduct: json['messaging_product'] ?? '',
      contacts: (json['contacts'] as List?)
              ?.map((c) => Contact.fromJson(c))
              .toList() ??
          [],
      messages: (json['messages'] as List?)
              ?.map((m) => Message.fromJson(m))
              .toList() ??
          [],
      rawResponse: json,
    );
  }
}

class Contact {
  final String input;
  final String waId;

  Contact({required this.input, required this.waId});

  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
      input: json['input'] ?? '',
      waId: json['wa_id'] ?? '',
    );
  }
}

class Message {
  final String id;
  final String? messageStatus;

  Message({required this.id, this.messageStatus});

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['id'] ?? '',
      messageStatus: json['message_status'],
    );
  }
}

/// --- Enhanced Helpers ---
Map<String, dynamic> decodeResponse(dynamic response) {
  if (response is String) return jsonDecode(response);
  if (response is Map<String, dynamic>) return response;
  throw ArgumentError('Unexpected response type: ${response.runtimeType}');
}

void assertNoError(Map<String, dynamic> response) {
  if (response.containsKey('error')) {
    fail('WhatsApp API returned error: ${response['error']}');
  }
}

/// Rate limiting prevention
Future<void> _apiDelay() async {
  await Future.delayed(Duration(milliseconds: 1000));
}

/// Enhanced response validation with proper error handling
Future<void> _checkResponseDetailed(
    Future<dynamic> future, String testName) async {
  print('\n🧪 Testing: $testName');

  try {
    await _apiDelay(); // Prevent rate limiting

    final result = await future;
    final response = decodeResponse(result.response);
    assertNoError(response);

    // Basic validations
    expect(response['messaging_product'], equals('whatsapp'));

    // Detailed logging
    print('✅ $testName completed successfully');
    if (response.containsKey('contacts')) {
      print('📱 Contact: ${response['contacts']}');
    }
    if (response.containsKey('messages')) {
      print('💬 Message: ${response['messages']}');
    }
    if (response.containsKey('success')) {
      print('✅ Success: ${response['success']}');
    }
    print('📊 Full response: $response');

    await _apiDelay(); // Space out API calls
  } catch (e) {
    print('❌ $testName failed with error: $e');
    await _apiDelay(); // Still delay on error
    rethrow;
  }
}

void main() {
  // Properly isolated test variables
  late String markAsReadSampleMessageId;
  late String samplePhotoMediaId;
  late String sampleDocumentMediaId;
  late String sampleAudioMediaId;
  late String sampleVideoMediaId;
  late String sampleStickerMediaId;
  late String incomingMsgId =
      'wamid.HBgMOTE3MDIzMDQyMzA2FQIAEhgUM0EwQ0ZBRkUzNUJGN0I4RTk5NDEA';

  group('WhatsApp public API surface - Complete Test Suite', () {
    late WhatsApp whatsapp;
    // String phoneNumber = '917023042306';
    String phoneNumber = '917023042306';

    setUpAll(() async {
      print('\n🚀 Initializing WhatsApp API Test Suite...');

      whatsapp = WhatsApp(
        'EAAGp6aTb8wMBPd8ildLz0aX3BeITfTaHxCHLOm3D0tDfLupjVrrQ4kZAPZBwjwhsXbaUBTkTy1C7eZBC1LwvscGHp9ngPRlRH1EoMYNLl6alXnw6vOqahJctGFDulXAuglHiIUmze6xqqXimqWo2RjknhQzLIZCp8wJRgJaAtAvDB4GOZBxJFW7clhsagJAHZC6oiAl2aFyl6m',
        '108277245242985',
      );

      print('✅ WhatsApp instance created for: $phoneNumber');

      // Initialize default values to prevent null reference errors
      markAsReadSampleMessageId = 'wamid.sample';
      samplePhotoMediaId = '';
      sampleDocumentMediaId = '';
      sampleAudioMediaId = '';
      sampleVideoMediaId = '';
      sampleStickerMediaId = '';
    });

    tearDownAll(() async {
      print('\n🧹 Test suite cleanup completed');
      await _apiDelay();
    });

    // === BASIC FUNCTIONALITY TESTS ===
    test('constructor creates instance', () {
      expect(whatsapp, isA<WhatsApp>());
      print('✅ WhatsApp instance validated');
    });

    test('setVersion does not throw', () {
      expect(() => whatsapp.setVersion('v23.0'), returnsNormally);
      print('✅ API version set to v23.0');
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
      print('✅ Generated link: $link');
    });

    // === MESSAGE SENDING TESTS ===
    test('sendMessage', () async {
      var result = await whatsapp.sendMessage(
        phoneNumber: phoneNumber,
        text: 'Visit my site https://rohitchouhan.com',
        previewUrl: true,
      );
      print('message id: ' + result.getMessageId());
      print('contact id: ' + result.getContactId());
      print(result.getFullResponse());
    });

    // === MEDIA UPLOAD TESTS (Sequential to prevent conflicts) ===
    test('uploadMediaFileByUrl (Image)', () async {
      await _apiDelay();
      var media = await whatsapp.uploadMediaFileByUrl(
        fileUrl:
            'https://download.samplelib.com/png/sample-bumblebee-400x300.png',
        fileType: 'image/png',
      );
      samplePhotoMediaId = media.getMediaId();
      print('photo id: ' + samplePhotoMediaId);
      print(media.getFullResponse());
    });

    test('uploadMediaFileByUrl (Document)', () async {
      await _apiDelay();
      var media = await whatsapp.uploadMediaFileByUrl(
        fileUrl:
            'https://sample-files.com/downloads/documents/pdf/basic-text.pdf',
        fileType: 'application/pdf',
      );
      sampleDocumentMediaId = media.getMediaId();
      print('document id: ' + sampleDocumentMediaId);
      print(media.getFullResponse());
    });

    test('uploadMediaFileByUrl (Audio)', () async {
      await _apiDelay();
      var media = await whatsapp.uploadMediaFileByUrl(
        fileUrl: 'https://sample-files.com/downloads/audio/mp3/tone-test.mp3',
        fileType: 'audio/mpeg',
      );
      sampleAudioMediaId = media.getMediaId() ?? '';
      print('audio id: ' + sampleAudioMediaId);
      print(media.getFullResponse());
    });

    test('uploadMediaFileByUrl (Video)', () async {
      await _apiDelay();
      var media = await whatsapp.uploadMediaFileByUrl(
        fileUrl: 'https://download.samplelib.com/mp4/sample-5s.mp4',
        fileType: 'video/mp4',
      );
      sampleVideoMediaId = media.getMediaId() ?? '';
      print('video id: ' + sampleVideoMediaId);
      print(media.getFullResponse());
    });

    test('uploadMediaFileByUrl (Sticker)', () async {
      await _apiDelay();
      var media = await whatsapp.uploadMediaFileByUrl(
        fileUrl: 'https://filesamples.com/samples/image/webp/sample1.webp',
        fileType: 'image/webp',
      );
      sampleStickerMediaId = media.getMediaId() ?? '';
      print('sticker id: ' + sampleStickerMediaId);
      print(media.getFullResponse());
    });

    // === MEDIA MANAGEMENT TESTS ===
    test('getMedia', () async {
      await _apiDelay();
      var getMedia = await whatsapp.getMedia(mediaId: '1945814936194411');
      print('isUploaded id: ' + getMedia.isSuccess().toString());
      print('getMediaId id: ' + getMedia.getMediaId());
      print('getUrl id: ' + getMedia.getMediaUrl());
      print('getMimeType id: ' + getMedia.getMediaMimeType());
      print('getSha256 id: ' + getMedia.getMediaSha256());
      print('getFileSize id: ' + getMedia.getMediaFileSize().toString());
      print(getMedia.getFullResponse());
    });

    test('deleteMedia', () async {
      var getMedia = await whatsapp.deleteMedia(mediaId: '1945814936194411');
      print('isUploaded id: ' + getMedia.isDeleted().toString());
      print(getMedia.getFullResponse());
      // Skip by default to preserve media for other tests
      print('⚠️ deleteMedia test skipped to preserve test media');
    }, skip: true);

    // === MEDIA SENDING TESTS ===
    test('sendImageById', () async {
      var result = await whatsapp.sendImageById(
        phoneNumber: phoneNumber,
        mediaId: '1945814936194411',
        caption: 'Media Send with ID',
      );

      print('message id: ' + result.getMessageId());
      print('contact id: ' + result.getContactId());
      print(result.getFullResponse());
    });

    test('sendImageByUrl', () async {
      await _checkResponseDetailed(
          whatsapp.sendImageByUrl(
            phoneNumber: phoneNumber,
            imageUrl:
                'https://sample-files.com/downloads/images/jpg/thumbnail_150x150_10.5kb.jpg',
            caption: 'Test image from URL',
          ),
          'Send Image by URL');
    });

    test('sendAudioById', () async {
      if (sampleAudioMediaId.isNotEmpty) {
        await _checkResponseDetailed(
            whatsapp.sendAudioById(
              phoneNumber: phoneNumber,
              mediaId: sampleAudioMediaId,
            ),
            'Send Audio by Media ID');
      } else {
        print('⚠️ Skipping sendAudioById - no valid audio media ID');
      }
    });

    test('sendAudioByUrl', () async {
      await _checkResponseDetailed(
          whatsapp.sendAudioByUrl(
            phoneNumber: phoneNumber,
            audioUrl:
                'https://sample-files.com/downloads/audio/mp3/tone-test.mp3',
          ),
          'Send Audio by URL');
    });

    test('sendDocumentById', () async {
      if (sampleDocumentMediaId.isNotEmpty) {
        await _checkResponseDetailed(
            whatsapp.sendDocumentById(
              phoneNumber: phoneNumber,
              mediaId: sampleDocumentMediaId,
              caption: 'Test document',
              filename: 'test_file.pdf',
            ),
            'Send Document by Media ID');
      } else {
        print('⚠️ Skipping sendDocumentById - no valid document media ID');
      }
    });

    test('sendDocumentByUrl', () async {
      await _checkResponseDetailed(
          whatsapp.sendDocumentByUrl(
            phoneNumber: phoneNumber,
            documentUrl:
                'https://sample-files.com/downloads/documents/pdf/basic-text.pdf',
            caption: 'Test document from URL',
            filename: 'test_file.pdf',
          ),
          'Send Document by URL');
    });

    test('sendVideoById', () async {
      if (sampleVideoMediaId.isNotEmpty) {
        await _checkResponseDetailed(
            whatsapp.sendVideoById(
              phoneNumber: phoneNumber,
              mediaId: sampleVideoMediaId,
              caption: 'Test video',
            ),
            'Send Video by Media ID');
      } else {
        print('⚠️ Skipping sendVideoById - no valid video media ID');
      }
    });

    test('sendVideoByUrl', () async {
      await _checkResponseDetailed(
          whatsapp.sendVideoByUrl(
            phoneNumber: phoneNumber,
            videoUrl: 'https://download.samplelib.com/mp4/sample-5s.mp4',
            caption: 'Test video from URL',
          ),
          'Send Video by URL');
    });

    test('sendSticker', () async {
      if (sampleStickerMediaId.isNotEmpty) {
        await _checkResponseDetailed(
            whatsapp.sendSticker(
              phoneNumber: phoneNumber,
              stickerId: sampleStickerMediaId,
            ),
            'Send Sticker');
      } else {
        print('⚠️ Skipping sendSticker - no valid sticker media ID');
      }
    });

    // === INTERACTION TESTS ===
    test('markAsRead', () async {
      await _checkResponseDetailed(
          whatsapp.markAsRead(messageId: incomingMsgId),
          'Mark Message as Read');
    }, skip: true);

    test('sendReaction', () async {
      await _checkResponseDetailed(
          whatsapp.sendReaction(
            phoneNumber: phoneNumber,
            messageId: markAsReadSampleMessageId,
            emoji: '👍',
          ),
          'Send Reaction');
    });

    // === LOCATION TESTS ===
    test('sendLocationRequest', () async {
      await _checkResponseDetailed(
          whatsapp.sendLocationRequest(
            phoneNumber: phoneNumber,
            text: 'Please share your location',
          ),
          'Send Location Request');
    });

    test('sendLocation', () async {
      await _checkResponseDetailed(
          whatsapp.sendLocation(
            phoneNumber: phoneNumber,
            latitude: 37.7749,
            longitude: -122.4194,
            name: 'San Francisco Test Location',
            address: 'San Francisco, CA, USA',
          ),
          'Send Location');
    });

    // === INTERACTIVE MESSAGE TESTS ===
    test('sendInteractiveReplyButton', () async {
      await _checkResponseDetailed(
          whatsapp.sendInteractiveReplyButton(
            phoneNumber: phoneNumber,
            headerInteractive: {'type': 'text', 'text': 'Choose an Option'},
            bodyText: 'Please select one of the options below:',
            footerText: 'Enhanced Test Suite',
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
          ),
          'Send Interactive Reply Buttons');
    });

    test('sendInteractiveLists', () async {
      await _checkResponseDetailed(
          whatsapp.sendInteractiveLists(
            phoneNumber: phoneNumber,
            headerText: 'Select from List',
            bodyText: 'Choose an option from the list below',
            footerText: 'Enhanced Test Suite',
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
          ),
          'Send Interactive Lists');
    });

    test('sendCallToActionButton', () async {
      await _checkResponseDetailed(
          whatsapp.sendCallToActionButton(
            phoneNumber: phoneNumber,
            headerText: 'Visit Our Website',
            bodyText: 'Click the button below to visit our site',
            footerText: 'Enhanced Test Suite',
            buttonText: 'Visit Website',
            actionUrl: 'https://example.com',
          ),
          'Send Call to Action Button');
    });

    // === CONTACT TESTS ===
    test('sendContactDetails', () async {
      await _checkResponseDetailed(
          whatsapp.sendContactDetails(
            phoneNumber: phoneNumber,
            person: {
              'formatted_name': 'John Doe Test',
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
          ),
          'Send Contact Details');
    });

    // === ACCOUNT MANAGEMENT TESTS ===
    test('accountMigrationRegister', () async {
      await _checkResponseDetailed(
          whatsapp.accountMigrationRegister(
            digitsPinCode: '123456',
            password: 'test_password',
            backupData: 'test_backup_data',
          ),
          'Account Migration Register');
    }, skip: true);

    test('getBusinessProfile', () async {
      await _apiDelay();
      var getProfile = await whatsapp
          .getBusinessProfile(scope: ['name', 'about', 'address']);
      var json = decodeResponse(getProfile.response);
      print('🏢 Business Profile: $json');
      expect(json['data'], isNotEmpty);
    });

    test('updateBusinessProfile', () async {
      await _apiDelay();
      var updateProfile = await whatsapp.updateBusinessProfile(
        about: 'Enhanced Test Suite Business',
        address: 'Test Address 123',
        description: 'Business for testing enhanced suite',
        industry: 'NONPROFIT',
        email: 'test@business.com',
        websites: ['https://test-business.com'],
        profilePictureHandle:
            'https://sample-files.com/downloads/images/jpg/thumbnail_150x150_10.5kb.jpg',
      );
      var json = decodeResponse(updateProfile.response);
      print('📝 Profile Update: $json');
      expect(json['success'], isTrue);
    });

    // === VERIFICATION TESTS ===
    test('requestCode', () async {
      await _checkResponseDetailed(
          whatsapp.requestCode(codeMethod: 'SMS', language: 'en'),
          'Request Verification Code');
    }, skip: true);

    test('verifyCode', () async {
      await _checkResponseDetailed(
          whatsapp.verifyCode(code: 123456), 'Verify Code');
    }, skip: true);

    test('register', () async {
      print('\n🧪 Testing: Register Account');

      try {
        await _apiDelay();
        final result = await whatsapp.register(pin: 123456);
        final response = decodeResponse(result.response);
        assertNoError(response);

        // Special validation for register
        expect(response, contains('success'));
        if (response.containsKey('success')) {
          expect(response['success'], isTrue,
              reason: 'Expected register success but got: $response');
        }

        print('✅ Register completed successfully');
        print('📊 Full response: $response');
        await _apiDelay();
      } catch (e) {
        print('❌ Register failed with error: $e');
        await _apiDelay();
        rethrow;
      }
    }, skip: true);

    test('deRegister', () async {
      await _checkResponseDetailed(whatsapp.deRegister(), 'Deregister Account');
    }, skip: true);

    test('twoStepVerification', () async {
      print('\n🧪 Testing: Two Step Verification');

      try {
        await _apiDelay();
        final result = await whatsapp.twoStepVerification(pin: 123456);
        final response = decodeResponse(result.response);
        assertNoError(response);

        // Special validation for register
        expect(response, contains('success'));
        if (response.containsKey('success')) {
          expect(response['success'], isTrue,
              reason: 'Expected register success but got: $response');
        }

        print('✅ Two Step Verification completed successfully');
        print('📊 Full response: $response');
        await _apiDelay();
      } catch (e) {
        print('❌ Two Step Verification failed with error: $e');
        await _apiDelay();
        rethrow;
      }
    }, skip: true);

    // === REPLY AND TEMPLATE TESTS ===
    test('reply', () async {
      await _checkResponseDetailed(
          whatsapp.reply(
            phoneNumber: phoneNumber,
            messageId: markAsReadSampleMessageId,
            reply: {
              'type': 'text',
              'text': {'body': 'This is a reply from enhanced test suite'},
            },
          ),
          'Reply to Message');
    });

    test('sendTemplate', () async {
      await _checkResponseDetailed(
          whatsapp.sendTemplate(
            phoneNumber: phoneNumber,
            template: 'account_creation_confirmation',
            language: 'en_US',
            placeholder: [
              {"type": "text", "text": "Rohit Chouhan"},
              {"type": "text", "text": "me@rohitchouhan.com"}
            ],
          ),
          'Send Template Message');
    });

    test('sendCustomRequest', () async {
      await _checkResponseDetailed(
          whatsapp.sendCustomRequest(
            path: '/messages',
            payload: {
              'messaging_product': 'whatsapp',
              'to': phoneNumber,
              'type': 'text',
              'text': {'body': 'Custom request test'},
            },
          ),
          'Send Custom Request');
    });

    // === V4 NEW METHODS TESTS ===
    test('sendFlowMessage', () async {
      await _checkResponseDetailed(
          whatsapp.sendFlowMessage(
            phoneNumber: phoneNumber,
            flowToken: 'unused',
            flowId: '825115873182362',
            flowCta: 'Start Flow',
            flowActionPayload: {'screen': 'RECOMMEND'},
            headerText: 'Flow Test Header',
            bodyText: 'This is a flow message test',
            footerText: 'Enhanced Test Suite',
          ),
          'Send Flow Message');
    });

    test('sendCatalogMessage', () async {
      await _checkResponseDetailed(
          whatsapp.sendCatalogMessage(
            phoneNumber: phoneNumber,
            productRetailerId: 'SFPRO-001',
            headerText: 'Browse Our Catalog',
            bodyText: 'Check out our products',
            footerText: 'Enhanced Test Suite',
          ),
          'Send Catalog Message');
    });

    test('sendProductMessage', () async {
      await _checkResponseDetailed(
          whatsapp.sendProductMessage(
              phoneNumber: phoneNumber,
              catalogId: '1322891656100432',
              productRetailerId: 'SFPRO-001',
              bodyText: "Available",
              footerText: "Limited Offer"),
          'Send Product Message');
    });

    test('sendTypingIndicator', () async {
      var msg = await whatsapp.sendTypingIndicator(messageId: incomingMsgId);
      var json = decodeResponse(msg.response);
      print('📝 sendTypingIndicator: $json');
      expect(json['success'], isTrue);
    });

    test('blockUsers', () async {
      await _checkResponseDetailed(
          whatsapp.blockUsers(users: ['917611959290']), 'Block Users');
    }, skip: true);

    test('unblockUsers', () async {
      await _checkResponseDetailed(
          whatsapp.unblockUsers(users: ['917023042306']), 'Unblock Users');
    }, skip: true);

    test('getBlockedUsers', () async {
      // await _checkResponseDetailed(
      //     whatsapp.getBlockedUsers(), 'Get Blocked Users');
      var list = await whatsapp.getBlockedUsers();
      print(list.getCursorAfter());
    });
  });
}
