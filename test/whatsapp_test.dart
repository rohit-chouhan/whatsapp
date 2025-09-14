import 'package:flutter_test/flutter_test.dart';
import 'package:whatsapp/whatsapp.dart';

void main() {
  group('WhatsApp Package Tests', () {
    late WhatsApp whatsapp;

    setUp(() {
      whatsapp = WhatsApp('test_access_token', 'test_phone_number_id');
    });

    test('WhatsApp instance should be created successfully', () {
      expect(whatsapp, isA<WhatsApp>());
    });

    test('Should be able to set API version', () {
      expect(() => whatsapp.setVersion('v21.0'), returnsNormally);
    });

    test('Should generate WhatsApp link correctly', () {
      final link = whatsapp.getLink(
        phoneNumber: '1234567890',
        message: 'Hello World',
      );
      
      expect(link, contains('wa.me'));
      expect(link, contains('1234567890'));
      expect(link, contains('Hello%20World'));
    });

    test('Should generate WhatsApp link with formatting', () {
      final link = whatsapp.getLink(
        phoneNumber: '1234567890',
        message: 'Hello *World*',
        bold: ['World'],
      );
      
      expect(link, contains('wa.me'));
      expect(link, contains('1234567890'));
    });

    test('Reply model should work correctly', () {
      final reply = Reply();
      
      final textReply = reply.text('Hello World', previewUrl: true);
      expect(textReply['type'], equals('text'));
      expect(textReply['text']['body'], equals('Hello World'));
      expect(textReply['text']['preview_url'], equals(true));
      
      final imageReply = reply.imageById('image_id_123');
      expect(imageReply['type'], equals('image'));
      expect(imageReply['image']['id'], equals('image_id_123'));
    });
  });
}
