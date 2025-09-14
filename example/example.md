# WhatsApp Business API Flutter Package Examples

This file contains comprehensive examples for using the WhatsApp Business API Flutter package v4.0.0.

## Basic Setup

```dart
import 'package:flutter/material.dart';
import 'package:whatsapp/whatsapp.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

void main() => runApp(MaterialApp(home: Home()));

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Initialize WhatsApp with your access token and phone number ID
  late WhatsApp whatsapp;
  String phoneNumber = '1234567890'; // Phone number with country code
  
  @override
  void initState() {
    super.initState();
    whatsapp = WhatsApp(
      'YOUR_ACCESS_TOKEN_HERE', // Your WhatsApp Business API access token
      'YOUR_PHONE_NUMBER_ID',   // Your WhatsApp Business phone number ID
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WhatsApp Business API Examples'),
        backgroundColor: Colors.green,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Basic Text Messages
          _buildSectionTitle('Basic Messages'),
          _buildButton(
            'Send Text Message',
            () async {
              var res = await whatsapp.sendMessage(
                phoneNumber: phoneNumber,
                text: 'Hello from Flutter!',
                previewUrl: true,
              );
              _handleResponse(res);
            },
          ),
          
          // Media Messages
          _buildSectionTitle('Media Messages'),
          _buildButton(
            'Send Image by ID',
            () async {
              var res = await whatsapp.sendImageById(
                phoneNumber: phoneNumber,
                mediaId: '437536581613407',
                caption: 'Check out this image!',
              );
              _handleResponse(res);
            },
          ),
          _buildButton(
            'Send Image by URL',
            () async {
              var res = await whatsapp.sendImageByUrl(
                phoneNumber: phoneNumber,
                imageUrl: 'https://example.com/image.jpg',
                caption: 'Image from URL',
              );
              _handleResponse(res);
            },
          ),
          _buildButton(
            'Send Video by ID',
            () async {
              var res = await whatsapp.sendVideoById(
                phoneNumber: phoneNumber,
                mediaId: '437536581613407',
                caption: 'Amazing video!',
              );
              _handleResponse(res);
            },
          ),
          _buildButton(
            'Send Document by ID',
            () async {
              var res = await whatsapp.sendDocumentById(
                phoneNumber: phoneNumber,
                mediaId: '437536581613407',
                caption: 'Important document',
                filename: 'document.pdf',
              );
              _handleResponse(res);
            },
          ),
          _buildButton(
            'Send Audio by ID',
            () async {
              var res = await whatsapp.sendAudioById(
                phoneNumber: phoneNumber,
                mediaId: '437536581613407',
              );
              _handleResponse(res);
            },
          ),
          
          // Interactive Messages
          _buildSectionTitle('Interactive Messages'),
          _buildButton(
            'Send Interactive Reply Buttons',
            () async {
              var res = await whatsapp.sendInteractiveReplyButton(
                phoneNumber: phoneNumber,
                headerInteractive: {'type': 'text', 'text': 'Choose an option'},
                bodyText: 'What would you like to do?',
                footerText: 'Select one option',
                interactiveReplyButtons: [
                  {'type': 'reply', 'reply': {'id': 'yes', 'title': '👍 Yes'}},
                  {'type': 'reply', 'reply': {'id': 'no', 'title': '👎 No'}},
                ],
              );
              _handleResponse(res);
            },
          ),
          _buildButton(
            'Send Interactive Lists',
            () async {
              var res = await whatsapp.sendInteractiveLists(
                phoneNumber: phoneNumber,
                headerText: 'Menu Options',
                bodyText: 'Choose from our menu',
                footerText: 'Select an item',
                buttonText: 'View Menu',
                sections: [
                  {
                    'title': 'Appetizers',
                    'rows': [
                      {'id': 'app1', 'title': 'Bruschetta', 'description': 'Fresh tomatoes on toast'},
                      {'id': 'app2', 'title': 'Caesar Salad', 'description': 'Classic caesar salad'},
                    ]
                  },
                  {
                    'title': 'Main Course',
                    'rows': [
                      {'id': 'main1', 'title': 'Pasta', 'description': 'Spaghetti with marinara'},
                      {'id': 'main2', 'title': 'Pizza', 'description': 'Margherita pizza'},
                    ]
                  }
                ],
              );
              _handleResponse(res);
            },
          ),
          _buildButton(
            'Send Call-to-Action Button',
            () async {
              var res = await whatsapp.sendCallToActionButton(
                phoneNumber: phoneNumber,
                headerText: 'Visit Our Website',
                bodyText: 'Check out our latest products and offers',
                footerText: 'Click the button below',
                buttonText: 'Visit Store',
                actionUrl: 'https://example.com/store',
              );
              _handleResponse(res);
            },
          ),
          
          // NEW FEATURES - Flow Messages
          _buildSectionTitle('Flow Messages (NEW in v4.0.0)'),
          _buildButton(
            'Send Flow Message',
            () async {
              var res = await whatsapp.sendFlowMessage(
                phoneNumber: phoneNumber,
                flowToken: 'your_flow_token_here',
                flowId: 'your_flow_id_here',
                flowCta: 'Start Survey',
                flowActionPayload: '{"screen": "WELCOME_SCREEN"}',
                headerText: 'Welcome to our survey!',
                bodyText: 'Help us improve by answering a few questions.',
                footerText: 'This will only take 2 minutes',
              );
              _handleResponse(res);
            },
          ),
          
          // NEW FEATURES - Catalog & Product Messages
          _buildSectionTitle('Catalog & Product Messages (NEW in v4.0.0)'),
          _buildButton(
            'Send Catalog Message',
            () async {
              var res = await whatsapp.sendCatalogMessage(
                phoneNumber: phoneNumber,
                catalogId: 'your_catalog_id_here',
                productRetailerId: 'product_retailer_id_here',
                headerText: 'Check out this product!',
                bodyText: 'Amazing product at a great price.',
                footerText: 'Limited time offer',
              );
              _handleResponse(res);
            },
          ),
          _buildButton(
            'Send Product Message',
            () async {
              var res = await whatsapp.sendProductMessage(
                phoneNumber: phoneNumber,
                catalogId: 'your_catalog_id_here',
                productRetailerId: 'product_retailer_id_here',
              );
              _handleResponse(res);
            },
          ),
          
          // Location Messages
          _buildSectionTitle('Location Messages'),
          _buildButton(
            'Send Location',
            () async {
              var res = await whatsapp.sendLocation(
                phoneNumber: phoneNumber,
                latitude: 26.4866491,
                longitude: 74.5288578,
                name: 'Pushkar, Rajasthan',
                address: 'Rajasthan, India',
              );
              _handleResponse(res);
            },
          ),
          _buildButton(
            'Request Location',
            () async {
              var res = await whatsapp.sendLocationRequest(
                phoneNumber: phoneNumber,
                text: 'Please share your current location',
              );
              _handleResponse(res);
            },
          ),
          
          // Contact Messages
          _buildSectionTitle('Contact Messages'),
          _buildButton(
            'Send Contact Details',
            () async {
              var res = await whatsapp.sendContactDetails(
                phoneNumber: phoneNumber,
                person: {
                  'name': {'formatted_name': 'John Doe'},
                  'org': {'company': 'Flutter Company'}
                },
                phones: [
                  {'phone': '+1234567890', 'type': 'WORK'},
                  {'phone': '+0987654321', 'type': 'HOME'}
                ],
                emails: [
                  {'email': 'john@example.com', 'type': 'WORK'}
                ],
                addresses: [
                  {
                    'street': '123 Main St',
                    'city': 'New York',
                    'state': 'NY',
                    'zip': '10001',
                    'country': 'USA',
                    'type': 'WORK'
                  }
                ],
              );
              _handleResponse(res);
            },
          ),
          
          // Message Management
          _buildSectionTitle('Message Management'),
          _buildButton(
            'Mark Message as Read',
            () async {
              var res = await whatsapp.markAsRead(
                messageId: 'wamid.XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX==',
              );
              _handleResponse(res);
            },
          ),
          _buildButton(
            'Mark Message as Delivered',
            () async {
              var res = await whatsapp.markAsDelivered(
                messageId: 'wamid.XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX==',
              );
              _handleResponse(res);
            },
          ),
          _buildButton(
            'Get Message Status',
            () async {
              var res = await whatsapp.getMessageStatus(
                'wamid.XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX==',
              );
              _handleResponse(res);
            },
          ),
          _buildButton(
            'Send Reaction',
            () async {
              var res = await whatsapp.sendReaction(
                phoneNumber: phoneNumber,
                messageId: 'wamid.XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX==',
                emoji: '👍',
              );
              _handleResponse(res);
            },
          ),
          _buildButton(
            'Reply to Message',
            () async {
              var res = await whatsapp.reply(
                phoneNumber: phoneNumber,
                messageId: 'wamid.XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX==',
                reply: {
                  'type': 'text',
                  'text': {'body': 'Thanks for your message!'}
                },
              );
              _handleResponse(res);
            },
          ),
          
          // Template Messages
          _buildSectionTitle('Template Messages'),
          _buildButton(
            'Send Template Message',
            () async {
              var res = await whatsapp.sendTemplate(
                phoneNumber: phoneNumber,
                template: 'hello_world',
                language: 'en_US',
                placeholder: [
                  {'type': 'text', 'text': 'John'}
                ],
              );
              _handleResponse(res);
            },
          ),
          
          // Media Management
          _buildSectionTitle('Media Management'),
          _buildButton(
            'Upload Media File',
            () async {
              final ImagePicker picker = ImagePicker();
              final XFile? image = await picker.pickImage(source: ImageSource.gallery);
              if (image != null) {
                var res = await whatsapp.uploadMediaFile(
                  file: File(image.path),
                  fileType: 'image/jpeg',
                );
                _handleResponse(res);
              }
            },
          ),
          _buildButton(
            'Upload Media by URL',
            () async {
              var res = await whatsapp.uploadMediaFileByUrl(
                fileUrl: 'https://example.com/image.jpg',
                fileType: 'image/jpeg',
              );
              _handleResponse(res);
            },
          ),
          _buildButton(
            'Get Media Info',
            () async {
              var res = await whatsapp.getMedia(
                mediaId: '437536581613407',
              );
              _handleResponse(res);
            },
          ),
          _buildButton(
            'Delete Media',
            () async {
              var res = await whatsapp.deleteMedia(
                mediaId: '437536581613407',
              );
              _handleResponse(res);
            },
          ),
          
          // Business Profile
          _buildSectionTitle('Business Profile'),
          _buildButton(
            'Get Business Profile',
            () async {
              var res = await whatsapp.getBusinessProfile(
                scope: ['name', 'email', 'about'],
              );
              _handleResponse(res);
            },
          ),
          _buildButton(
            'Update Business Profile',
            () async {
              var res = await whatsapp.updateBusinessProfile(
                about: 'AI-powered solutions',
                address: 'New York, USA',
                description: 'Leading technology company',
                industry: 'Technology',
                email: 'contact@example.com',
                websites: ['https://example.com'],
              );
              _handleResponse(res);
            },
          ),
          
          // Utility Functions
          _buildSectionTitle('Utility Functions'),
          _buildButton(
            'Generate WhatsApp Link',
            () async {
              String link = whatsapp.getLink(
                phoneNumber: phoneNumber,
                message: 'Hello from Flutter!',
                shortLink: true,
                bold: ['Flutter'],
                italic: ['Hello'],
              );
              print('Generated link: $link');
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Link copied: $link')),
              );
            },
          ),
          _buildButton(
            'Set API Version',
            () async {
              whatsapp.setVersion('v21.0');
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('API version set to v21.0')),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.green,
        ),
      ),
    );
  }

  Widget _buildButton(String text, VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
        ),
        child: Text(text),
      ),
    );
  }

  void _handleResponse(dynamic res) {
    if (res.isSuccess()) {
      print('✅ Success!');
      print('Message ID: ${res.getMessageId()}');
      print('Phone Number: ${res.getPhoneNumber()}');
      print('Response: ${res.getResponse()}');
    } else {
      print('❌ Error!');
      print('HTTP Code: ${res.getHttpCode()}');
      print('Error Message: ${res.getErrorMessage()}');
      print('Error: ${res.getError()}');
      print('Response: ${res.getResponse()}');
    }
  }
}
```

## Additional Examples

### Using the Reply Model

```dart
import 'package:whatsapp/model/reply.dart';

// Create reply objects
final reply = Reply();

// Text reply
final textReply = reply.text('Hello World', previewUrl: true);

// Image reply by ID
final imageReply = reply.imageById('image_id_123');

// Image reply by URL
final imageUrlReply = reply.imageByUrl('https://example.com/image.jpg');

// Video reply
final videoReply = reply.videoById('video_id_123');

// Document reply
final documentReply = reply.documentById('document_id_123');

// Use in reply method
await whatsapp.reply(
  phoneNumber: '1234567890',
  messageId: 'message_id_here',
  reply: textReply,
);
```

### Error Handling

```dart
import 'package:whatsapp/utils/exception.dart';

try {
  var res = await whatsapp.sendMessage(
    phoneNumber: phoneNumber,
    text: 'Hello World',
  );
  
  if (res.isSuccess()) {
    print('Message sent successfully!');
  } else {
    print('Error: ${res.getErrorMessage()}');
  }
} on WhatsAppAuthenticationException catch (e) {
  print('Authentication error: ${e.message}');
} on WhatsAppRateLimitException catch (e) {
  print('Rate limit exceeded: ${e.message}');
} on WhatsAppValidationException catch (e) {
  print('Validation error: ${e.message}');
} catch (e) {
  print('Unexpected error: $e');
}
```

### Custom API Requests

```dart
// Send custom API request
var res = await whatsapp.sendCustomRequest(
  path: '/your-custom-endpoint',
  payload: {
    'custom_field': 'custom_value',
    'another_field': 123,
  },
);
```

## Notes

- Replace `YOUR_ACCESS_TOKEN_HERE` with your actual WhatsApp Business API access token
- Replace `YOUR_PHONE_NUMBER_ID` with your actual phone number ID
- Replace placeholder IDs and URLs with your actual values
- The package now supports WhatsApp Business API v21.0
- All new features are marked with "(NEW in v4.0.0)" in the examples

Enjoy coding! 😃
