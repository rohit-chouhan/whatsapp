import 'dart:io';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:whatsapp/whatsapp.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:file_picker/file_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'settings_page.dart';
import 'business_page.dart';

void main() async {
  //rename .env.example to .env and add your credentials
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late WhatsApp whatsapp;
  bool isLoading = true;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _loadCredentials();
  }

  Future<void> _loadCredentials() async {
    try {
      await dotenv.load(fileName: ".env");
      final prefs = await SharedPreferences.getInstance();
      final accessToken =
          prefs.getString('access_token') ?? dotenv.env['ACCESS_TOKEN'] ?? '';
      final fromNumberId = prefs.getString('phone_number_id') ??
          dotenv.env['PHONE_NUMBER_ID'] ??
          '';
      whatsapp = WhatsApp(accessToken, fromNumberId);
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      // Handle error, perhaps show error screen
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return MaterialApp(
        title: 'WhatsApp Package Test',
        color: Colors.white,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: const Color(0xFF25D366),
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF25D366)),
          useMaterial3: true,
        ),
        home: const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      );
    }
    final List<Widget> pages = [
      WhatsAppTestPage(whatsapp: whatsapp),
      BusinessPage(whatsapp: whatsapp),
      const SettingsPage(),
    ];
    return MaterialApp(
      title: 'WhatsApp Package Test',
      color: Colors.white,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF25D366),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF25D366)),
        useMaterial3: true,
      ),
      home: Scaffold(
        body: pages[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          selectedItemColor: const Color(0xFF25D366),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Main',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.business),
              label: 'Business',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
          ],
        ),
      ),
    );
  }
}

class WhatsAppTestPage extends StatefulWidget {
  final WhatsApp whatsapp;

  const WhatsAppTestPage({super.key, required this.whatsapp});

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

  var mediaId = '';

  void _showSnackBar(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: color),
    );
  }

  dynamic _onLoading(bool show) {
    if (show) {
      showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return const Center(
            child: SizedBox(
              width: 50,
              height: 50,
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            ),
          );
        },
      );
    } else {
      Navigator.of(context, rootNavigator: true).pop();
    }
  }

  void _showError(String error) {
    _showSnackBar('Error: $error', Colors.red);
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
            await _onLoading(true);
            final response = await widget.whatsapp.sendMessage(
              phoneNumber: _phoneController.text,
              text: _messageController.text,
            );
            await _onLoading(false);
            _showSnackBar(
                'Message sent: ${response.getMessageId()}', Colors.green);
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
              await _onLoading(true);
              var uploadResponse;
              if (!kIsWeb) {
                uploadResponse = await widget.whatsapp.uploadMediaFile(
                  file: File(result.files.first.path!),
                  fileType: widget.whatsapp
                      .getAutoFileType(filePath: result.files.first.path!),
                );
              } else {
                uploadResponse = await widget.whatsapp.uploadMediaFile(
                  file: result.files.first.bytes!,
                  fileType: widget.whatsapp
                      .getAutoFileType(filePath: result.files.first.name),
                );
              }
              final mediaId = uploadResponse.getMediaId();
              _mediaIdController.text = mediaId;
              await widget.whatsapp.sendImageById(
                phoneNumber: _phoneController.text,
                imageId: mediaId,
              );
              await _onLoading(false);
              _showSnackBar('Image uploaded and sent', Colors.green);
            }
          },
          icon: const Icon(Icons.upload_file),
          label: const Text('Upload and Send Image'),
        ),
        const SizedBox(height: 8),
        ElevatedButton.icon(
          onPressed: () => _execute(() async {
            await _onLoading(true);
            await widget.whatsapp.sendImageByUrl(
              phoneNumber: _phoneController.text,
              imageUrl: _mediaUrlController.text,
            );
            await _onLoading(false);
            _showSnackBar('Image sent by URL', Colors.green);
          }),
          icon: const Icon(Icons.image),
          label: const Text('Send Image by URL'),
        ),
        const SizedBox(height: 8),
        ElevatedButton.icon(
          onPressed: () => _execute(() async {
            await _onLoading(true);
            await widget.whatsapp.sendImageById(
              phoneNumber: _phoneController.text,
              imageId: _mediaIdController.text,
            );
            await _onLoading(false);
            _showSnackBar('Image sent by ID', Colors.green);
          }),
          icon: const Icon(Icons.image),
          label: const Text('Send Image by ID'),
        ),
        const SizedBox(height: 8),
        ElevatedButton.icon(
          onPressed: () => _execute(() async {
            await _onLoading(true);
            await widget.whatsapp.deleteMedia(mediaId: _mediaIdController.text);
            _mediaIdController.clear();
            await _onLoading(false);
            _showSnackBar('Media deleted', Colors.green);
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
            await _onLoading(true);
            await widget.whatsapp.sendLocation(
              phoneNumber: _phoneController.text,
              latitude: 37.7749,
              longitude: -122.4194,
            );
            await _onLoading(false);
            _showSnackBar('Location sent', Colors.green);
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
