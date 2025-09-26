import 'package:flutter/material.dart';
import 'package:whatsapp/whatsapp.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:file_picker/file_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'settings_page.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WhatsApp Package Test',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF25D366),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF25D366)),
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
    text: dotenv.env['RECEIPT_NUMBER'],
  );
  final TextEditingController _messageController = TextEditingController(
    text: 'Hello from WhatsApp package test!',
  );
  final TextEditingController _mediaUrlController = TextEditingController(
    text:
        'https://raw.githack.com/rohit-chouhan/whatsapp/main/sample_files/sample.png',
  );
  final TextEditingController _mediaIdController = TextEditingController();

  late WhatsApp whatsapp;
  String accessToken = '';
  String fromNumberId = '';
  var mediaId = '';
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadCredentials();
  }

  Future<void> _loadCredentials() async {
    print('DEBUG: Starting _loadCredentials');
    try {
      await dotenv.load(fileName: ".env");
      print('DEBUG: dotenv loaded successfully');
    } catch (e) {
      print('DEBUG: Error loading dotenv: $e');
    }
    final prefs = await SharedPreferences.getInstance();
    print('DEBUG: SharedPreferences instance obtained');
    accessToken =
        prefs.getString('access_token') ?? dotenv.env['ACCESS_TOKEN'] ?? '';
    fromNumberId = prefs.getString('phone_number_id') ??
        dotenv.env['PHONE_NUMBER_ID'] ??
        '';
    print('DEBUG: accessToken: ${accessToken.isNotEmpty ? 'set' : 'empty'}');
    print('DEBUG: fromNumberId: ${fromNumberId.isNotEmpty ? 'set' : 'empty'}');
    try {
      whatsapp = WhatsApp(accessToken, fromNumberId);
      print('DEBUG: WhatsApp instance created');
    } catch (e) {
      print('DEBUG: Error creating WhatsApp instance: $e');
    }
    print('DEBUG: Setting isLoading to false');
    setState(() {
      isLoading = false;
    });
    print('DEBUG: _loadCredentials completed');
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void _showError(String error) {
    _showSnackBar('Error: $error');
  }

  Future<void> _execute(Function() action) async {
    try {
      await action();
    } catch (e) {
      _showError(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('WhatsApp Package Test'),
          backgroundColor: const Color(0xFF25D366),
        ),
        body: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('WhatsApp Package Test'),
        backgroundColor: const Color(0xFF25D366),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const Text(
                    'Note: To received messages, the recipient number must have sent a message to the WhatsApp Business number within the last 24 hours. or use register() method for permanent opt-in.',
                    style: TextStyle(fontSize: 15),
                  ),
                  const SizedBox(height: 20),
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
                    maxLines: 2,
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _mediaUrlController,
                    decoration: const InputDecoration(
                      labelText: 'Media URL',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _mediaIdController,
                    decoration: const InputDecoration(
                      labelText: 'Media ID',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
            ),
            ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(16.0),
              children: [
                _buildCategoryCard('Text', _buildTextTab()),
                _buildCategoryCard('Media', _buildMediaTab()),
                _buildCategoryCard('Location', _buildLocationTab()),
                const SizedBox(height: 16),
                const Card(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'For more examples, please check https://whatsapp-flutter.github.io',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SettingsPage()),
          );
          _loadCredentials(); // Refresh credentials after returning from settings
        },
        backgroundColor: const Color(0xFF25D366),
        child: const Icon(Icons.settings),
      ),
    );
  }

  Widget _buildCategoryCard(String title, Widget content) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            content,
          ],
        ),
      ),
    );
  }

  Widget _buildTextTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ElevatedButton.icon(
          onPressed: () => _execute(() async {
            final response = await whatsapp.sendMessage(
              phoneNumber: _phoneController.text,
              text: _messageController.text,
            );
            _showSnackBar('Message sent: ${response.getMessageId()}');
          }),
          icon: const Icon(Icons.send),
          label: const Text('Send Text Message'),
        ),
      ],
    );
  }

  Widget _buildMediaTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ElevatedButton.icon(
          onPressed: () async {
            FilePickerResult? result = await FilePicker.platform.pickFiles(
              type: FileType.image,
            );
            if (result != null) {
              final bytes = result.files.single.bytes;
              final uploadResponse = await whatsapp.uploadMediaFile(
                file: bytes!,
                fileType: 'image/png',
              );
              final mediaId = uploadResponse.getMediaId();
              _mediaIdController.text = mediaId;
              await whatsapp.sendImageById(
                phoneNumber: _phoneController.text,
                imageId: mediaId,
              );
              _showSnackBar('Image uploaded and sent');
            }
          },
          icon: const Icon(Icons.upload_file),
          label: const Text('Upload and Send Image'),
        ),
        const SizedBox(height: 8),
        ElevatedButton.icon(
          onPressed: () => _execute(() async {
            await whatsapp.sendImageByUrl(
              phoneNumber: _phoneController.text,
              imageUrl: _mediaUrlController.text,
            );
            _showSnackBar('Image sent by URL');
          }),
          icon: const Icon(Icons.image),
          label: const Text('Send Image by URL'),
        ),
        const SizedBox(height: 8),
        ElevatedButton.icon(
          onPressed: () => _execute(() async {
            await whatsapp.sendImageById(
              phoneNumber: _phoneController.text,
              imageId: _mediaIdController.text,
            );
            _showSnackBar('Image sent by ID');
          }),
          icon: const Icon(Icons.image),
          label: const Text('Send Image by ID'),
        ),
        const SizedBox(height: 8),
        ElevatedButton.icon(
          onPressed: () => _execute(() async {
            await whatsapp.deleteMedia(mediaId: _mediaIdController.text);
            _mediaIdController.clear();
            _showSnackBar('Media deleted');
          }),
          icon: const Icon(Icons.delete),
          label: const Text('Delete Media'),
        ),
      ],
    );
  }

  Widget _buildLocationTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ElevatedButton.icon(
          onPressed: () => _execute(() async {
            await whatsapp.sendLocation(
              phoneNumber: _phoneController.text,
              latitude: 37.7749,
              longitude: -122.4194,
            );
            _showSnackBar('Location sent');
          }),
          icon: const Icon(Icons.location_on),
          label: const Text('Send Location'),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _messageController.dispose();
    _mediaUrlController.dispose();
    _mediaIdController.dispose();
    super.dispose();
  }
}
