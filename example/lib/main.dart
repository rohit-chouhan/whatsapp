import 'package:flutter/material.dart';
import 'package:whatsapp/whatsapp.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WhatsApp Package Test',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const WhatsAppTestPage(),
    );
  }
}

class WhatsAppTestPage extends StatefulWidget {
  const WhatsAppTestPage({super.key});

  @override
  State<WhatsAppTestPage> createState() => _WhatsAppTestPageState();
}

class _WhatsAppTestPageState extends State<WhatsAppTestPage> {
  final TextEditingController _phoneController = TextEditingController(
    text: '1234567890',
  );
  final TextEditingController _messageController = TextEditingController(
    text: 'Hello from WhatsApp package test!',
  );
  final TextEditingController _tokenController = TextEditingController(
    text: 'your_access_token_here',
  );
  final TextEditingController _fromNumberController = TextEditingController(
    text: 'your_from_number_id_here',
  );
  final TextEditingController _mediaUrlController = TextEditingController(
    text: 'https://example.com/sample.png',
  );

  late WhatsApp whatsapp;

  @override
  void initState() {
    super.initState();
    // Initialize with dummy values for testing
    whatsapp = WhatsApp(_tokenController.text, _fromNumberController.text);
  }

  void _generateLink() {
    final link = whatsapp.getLink(
      phoneNumber: _phoneController.text,
      message: _messageController.text,
    );
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Generated WhatsApp Link'),
        content: SelectableText(link),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _testSendMessage() async {
    try {
      final response = await whatsapp.sendMessage(
        phoneNumber: _phoneController.text,
        text: _messageController.text,
      );
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Message sent: ${response.getMessageId()}')),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  void _testUploadMedia() async {
    try {
      final response = await whatsapp.uploadMediaFileByUrl(
        fileUrl: _mediaUrlController.text,
        fileType: 'image/png', // Assuming image for demo
      );
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Media uploaded: ${response.getMediaId()}')),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  void _updateCredentials() {
    setState(() {
      whatsapp = WhatsApp(_tokenController.text, _fromNumberController.text);
    });
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Credentials updated')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WhatsApp Package Test'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _tokenController,
              decoration: const InputDecoration(
                labelText: 'Access Token',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _fromNumberController,
              decoration: const InputDecoration(
                labelText: 'From Number ID',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _updateCredentials,
              child: const Text('Update Credentials'),
            ),
            const SizedBox(height: 24),
            TextField(
              controller: _phoneController,
              decoration: const InputDecoration(
                labelText: 'Phone Number',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _messageController,
              decoration: const InputDecoration(
                labelText: 'Message',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _mediaUrlController,
              decoration: const InputDecoration(
                labelText: 'Media URL',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: _generateLink,
              icon: const Icon(Icons.link),
              label: const Text('Generate WhatsApp Link'),
            ),
            const SizedBox(height: 8),
            ElevatedButton.icon(
              onPressed: _testSendMessage,
              icon: const Icon(Icons.send),
              label: const Text('Test Send Message'),
            ),
            const SizedBox(height: 8),
            ElevatedButton.icon(
              onPressed: _testUploadMedia,
              icon: const Icon(Icons.upload),
              label: const Text('Test Upload Media'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _messageController.dispose();
    _tokenController.dispose();
    _fromNumberController.dispose();
    _mediaUrlController.dispose();
    super.dispose();
  }
}
