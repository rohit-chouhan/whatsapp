import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:whatsapp/whatsapp.dart';

class BusinessPage extends StatefulWidget {
  final WhatsApp whatsapp;

  const BusinessPage({super.key, required this.whatsapp});

  @override
  State<BusinessPage> createState() => _BusinessPageState();
}

class _BusinessPageState extends State<BusinessPage> {
  String? about;
  String? address;
  String? description;
  String? email;
  String? profilePictureUrl;
  String? vertical;
  List<String> websites = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadBusinessProfile();
  }

  Future<void> _loadBusinessProfile() async {
    try {
      final response = await widget.whatsapp.getBusinessProfile();
      if (response.isSuccess()) {
        setState(() {
          about = response.getAbout();
          address = response.getAddress();
          description = response.getDescription();
          email = response.getEmail();
          profilePictureUrl = response.getProfilePictureUrl();
          vertical = response.getVertical();
          websites = response.getWebsites();
          isLoading = false;
        });
      } else {
        debugPrint(
            'DEBUG: Failed to load business profile, response: ${response.toString()}');
        _showSnackBar('Failed to load business profile', Colors.red);
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      _showSnackBar('Error: $e', Colors.red);
      setState(() {
        isLoading = false;
      });
    }
  }

  void _showSnackBar(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: color),
    );
  }

  dynamic _onLoading(bool show) {
    if (show) {
      showDialog(
        context: context,
        barrierDismissible: false,
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
      if (Navigator.of(context).canPop()) {
        Navigator.of(context).pop();
      }
    }
  }

  Future<void> _pickAndUpdateProfilePicture() async {
    try {
      await _onLoading(true);
      WhatsAppResumableUploadResponse uploadResponse;

      FilePickerResult? result =
          await FilePicker.platform.pickFiles(type: FileType.image);

      if (result != null) {
        if (!kIsWeb) {
          uploadResponse = await widget.whatsapp.createUploadResumableFile(
              fileLength: result.files.first.size,
              file: File(result.files.first.path!),
              fileType: widget.whatsapp
                  .getAutoFileType(filePath: result.files.first.path!),
              fileName: result.files.first.name);
        } else {
          // Web implementation - Note: Direct uploads from web browsers are blocked by CORS
          final bytes = result.files.first.bytes;
          if (bytes != null) {
            try {
              uploadResponse = await widget.whatsapp.createUploadResumableFile(
                fileLength: bytes.length,
                file: bytes, // Pass bytes directly for web
                fileType: widget.whatsapp
                    .getAutoFileType(filePath: result.files.first.name),
                fileName: result.files.first.name,
              );
            } catch (e) {
              if (e.toString().contains('Failed to fetch') ||
                  e.toString().contains('CORS')) {
                _showSnackBar(
                    'Web uploads are not supported due to CORS restrictions. Use a backend proxy for web applications.',
                    Colors.red);
                await _onLoading(false);
                return;
              } else {
                rethrow;
              }
            }
          } else {
            _showSnackBar('Unable to read file bytes on web', Colors.red);
            await _onLoading(false);
            return;
          }
        }

        final mediaId = uploadResponse.getH();

        await widget.whatsapp.updateBusinessProfile(
          profilePictureHandle: mediaId,
        );
        await _onLoading(false);
        _showSnackBar('Profile Picture Updated', Colors.green);
        await _loadBusinessProfile();
      } else {
        await _onLoading(false);
        _showSnackBar('No file selected', Colors.orange);
      }
    } catch (e) {
      await _onLoading(false);
      _showSnackBar('Error updating profile picture: $e', Colors.red);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Business Profile'),
          backgroundColor: const Color(0xFF25D366),
        ),
        body: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Business Profile'),
        backgroundColor: const Color(0xFF25D366),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Center(
              child: GestureDetector(
                onTap: _pickAndUpdateProfilePicture,
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Color(0xFF25D366), width: 6),
                    color: Colors.transparent,
                  ),
                  child: CircleAvatar(
                    radius: 80,
                    backgroundImage: profilePictureUrl != null &&
                            profilePictureUrl!.isNotEmpty
                        ? NetworkImage(profilePictureUrl!)
                        : null,
                    child:
                        profilePictureUrl == null || profilePictureUrl!.isEmpty
                            ? const Icon(Icons.camera_alt,
                                size: 40, color: Colors.grey)
                            : null,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            _buildInfoTile('About', about ?? '', (value) {
              setState(() => about = value);
              _updateField('About', value);
            }),
            _buildInfoTile('Address', address ?? '', (value) {
              setState(() => address = value);
              _updateField('Address', value);
            }),
            _buildInfoTile('Description', description ?? '', (value) {
              setState(() => description = value);
              _updateField('Description', value);
            }),
            _buildInfoTile('Email', email ?? '', (value) {
              setState(() => email = value);
              _updateField('Email', value);
            }),
            _buildWebsitesTile(),
            _buildInfoTile('Industry', vertical ?? '', (value) {
              setState(() => vertical = value);
              _updateField('Industry', value);
            }),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoTile(String title, String value, Function(String) onUpdate) {
    return ListTile(
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(value.isNotEmpty ? value : 'Not set'),
      trailing: IconButton(
        icon: const Icon(Icons.edit),
        onPressed: () => _showEditDialog(title, value, onUpdate),
      ),
    );
  }

  Widget _buildWebsitesTile() {
    String websitesText = websites.join(', ');
    return ListTile(
      title:
          const Text('Websites', style: TextStyle(fontWeight: FontWeight.bold)),
      subtitle:
          Text(websitesText.isNotEmpty ? websitesText : 'No websites set'),
      trailing: IconButton(
        icon: const Icon(Icons.edit),
        onPressed: () => _showEditDialog('Websites', websitesText, (newValue) {
          setState(() {
            websites = newValue
                .split(',')
                .map((s) => s.trim())
                .where((s) => s.isNotEmpty)
                .toList();
          });
          _updateWebsites();
        }),
      ),
    );
  }

  void _showEditDialog(
      String title, String currentValue, Function(String) onSave) {
    TextEditingController controller =
        TextEditingController(text: currentValue);
    debugPrint('DEBUG: Created TextEditingController for $title');
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Edit $title'),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(labelText: title),
          maxLines: title == 'Description' ? 3 : 1,
        ),
        actions: [
          TextButton(
            onPressed: () {
              debugPrint('DEBUG: Disposing TextEditingController for $title');
              controller.dispose();
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              debugPrint(
                  'DEBUG: Saving and disposing TextEditingController for $title');
              onSave(controller.text);
              controller.dispose();
              Navigator.of(context).pop();
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  Future<void> _updateField(String field, String value) async {
    try {
      await _onLoading(true);
      Map<String, String> params = {};
      switch (field) {
        case 'About':
          params['about'] = value;
          break;
        case 'Address':
          params['address'] = value;
          break;
        case 'Description':
          params['description'] = value;
          break;
        case 'Email':
          params['email'] = value;
          break;
        case 'Industry':
          params['industry'] = value;
          break;
      }
      await widget.whatsapp.updateBusinessProfile(
        about: params['about'],
        address: params['address'],
        description: params['description'],
        email: params['email'],
        industry: params['industry'],
      );
      await _onLoading(false);
      _showSnackBar('$field updated', Colors.green);
    } catch (e) {
      await _onLoading(false);
      _showSnackBar('Error updating $field: $e', Colors.red);
    }
  }

  Future<void> _updateWebsites() async {
    debugPrint('DEBUG: Starting _updateWebsites, calling _onLoading(true)');
    try {
      await _onLoading(true);
      await widget.whatsapp.updateBusinessProfile(websites: websites);
      debugPrint('DEBUG: API call successful, calling _onLoading(false)');
      await _onLoading(false);
      _showSnackBar('Websites updated', Colors.green);
    } catch (e) {
      debugPrint(
          'DEBUG: Error in _updateWebsites: $e, calling _onLoading(false)');
      await _onLoading(false);
      _showSnackBar('Error updating websites: $e', Colors.red);
    }
  }
}
