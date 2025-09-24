// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:example/main.dart';

void main() {
  testWidgets('WhatsApp test app loads correctly', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that the app title is displayed
    expect(find.text('WhatsApp Package Test'), findsOneWidget);

    // Verify that text fields are present
    expect(find.byType(TextField), findsNWidgets(5)); // token, fromNumber, phone, message, mediaUrl

    // Verify that buttons are present
    expect(find.text('Update Credentials'), findsOneWidget);
    expect(find.text('Generate WhatsApp Link'), findsOneWidget);
    expect(find.text('Test Send Message'), findsOneWidget);
    expect(find.text('Test Upload Media'), findsOneWidget);
  });

  testWidgets('Generate WhatsApp Link shows dialog', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Tap the 'Generate WhatsApp Link' button
    await tester.tap(find.text('Generate WhatsApp Link'));
    await tester.pump();

    // Verify that a dialog is shown
    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text('Generated WhatsApp Link'), findsOneWidget);

    // Verify that the link contains expected content
    expect(find.textContaining('api.whatsapp.com'), findsOneWidget);
  });


  testWidgets('Update Credentials shows snackbar', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Tap the 'Update Credentials' button
    await tester.tap(find.text('Update Credentials'));
    await tester.pump();

    // Verify that a snackbar is shown
    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Credentials updated'), findsOneWidget);
  });

}
