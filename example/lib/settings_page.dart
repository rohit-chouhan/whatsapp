import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final TextEditingController _accessTokenController = TextEditingController();
  final TextEditingController _phoneNumberIdController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _accessTokenController.text =
          prefs.getString('access_token') ?? dotenv.env['ACCESS_TOKEN'] ?? '';
      _phoneNumberIdController.text = prefs.getString('phone_number_id') ??
          dotenv.env['PHONE_NUMBER_ID'] ??
          '';
    });
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

  Future<void> _saveSettings() async {
    _onLoading(true);
    if (_accessTokenController.text.isEmpty ||
        _phoneNumberIdController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Access Token and Phone Number ID cannot be empty'),
            backgroundColor: Colors.red),
      );
      _onLoading(false);
      return;
    }
    _onLoading(true);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('access_token', _accessTokenController.text);
    await prefs.setString('phone_number_id', _phoneNumberIdController.text);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
          content: Text('Settings saved'), backgroundColor: Colors.green),
    );
    _onLoading(false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: const Color(0xFF25D366),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _accessTokenController,
              decoration: const InputDecoration(
                labelText: 'Access Token',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _phoneNumberIdController,
              decoration: const InputDecoration(
                labelText: 'Phone Number ID',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: _saveSettings,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF25D366),
                foregroundColor: Colors.white,
              ),
              child: const Text('Save Settings'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _accessTokenController.dispose();
    _phoneNumberIdController.dispose();
    super.dispose();
  }
}
