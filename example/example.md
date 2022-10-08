enjoy coding 😃

```dart
import 'package:flutter/material.dart';
import 'package:whatsapp/whatsapp.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http_parser/http_parser.dart' as http_parser;

void main() => runApp(MaterialApp(home: Home()));

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  WhatsApp whatsapp = WhatsApp();
  int phoneNumber = 910000000000;
  @override
  void initState() {
    whatsapp.setup(
      accessToken: "YOUR_ACCESS_TOKEN_HERE",
      fromNumberId: 000000000000000,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          TextButton(
            onPressed: () async {
              print(await whatsapp.short(
                to: phoneNumber,
                message: "Hello Flutter",
                compress: true,
              ));
            },
            child: const Text("Generate Short Link"),
          ),
          TextButton(
            onPressed: () async {
              print(await whatsapp.messagesText(
                to: phoneNumber,
                message: "Hello Flutter",
                previewUrl: true,
              ));
            },
            child: const Text("Send Message"),
          ),
          TextButton(
            onPressed: () async {
              print(await whatsapp.messagesTemplate(
                to: phoneNumber,
                templateName: "hello_world",
              ));
            },
            child: const Text("Send Template"),
          ),
          TextButton(
            onPressed: () async {
              print(await whatsapp.messagesMedia(
                to: phoneNumber,
                mediaId: "437536581613407",
                mediaType: "image",
              ));
            },
            child: const Text("Send Media File"),
          ),
          TextButton(
            onPressed: () async {
              print(await whatsapp.messagesLocation(
                to: phoneNumber,
                address: "Rajasthan, India",
                longitude: "26.4866491",
                latitude: "74.5288578",
                name: "Pushkar",
              ));
            },
            child: const Text("Send Location"),
          ),
          TextButton(
            onPressed: () async {
              print(await whatsapp.messagesMediaByLink(
                  to: phoneNumber,
                  mediaType: "video",
                  mediaLink: "https://example.com/flutter.mp4",
                  caption: "My Flutter Video"));
            },
            child: const Text("Send Media By Link"),
          ),
          TextButton(
            onPressed: () async {
              print(await whatsapp.messagesReaction(
                to: phoneNumber,
                messageId: "wamid.XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX==",
                emoji: "👍",
              ));
            },
            child: const Text("Send Reaction on Message"),
          ),
          TextButton(
            onPressed: () async {
              print(await whatsapp.messagesReply(
                to: phoneNumber,
                messageId: "wamid.XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX==",
                message: "Hey, Flutter!",
                previewUrl: true,
              ));
            },
            child: const Text("Send Reply on Message"),
          ),
          TextButton(
            onPressed: () async {
              print(await whatsapp.messagesReplyMedia(
                  to: phoneNumber,
                  messageId: "wamid.XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX==",
                  mediaType: "image",
                  mediaId: "437536581613407"));
            },
            child: const Text("Send Reply with Media"),
          ),
          TextButton(
            onPressed: () async {
              print(await whatsapp.messagesReplyMediaUrl(
                  to: phoneNumber,
                  messageId: "wamid.XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX==",
                  mediaType: "video",
                  mediaLink: "http://example.com/video.mp4",
                  caption: "My Flutter Video"));
            },
            child: const Text("Send Reply with Media (Url)"),
          ),
          TextButton(
            onPressed: () async {
              print(await whatsapp.registerNumber(pin: "123456"));
            },
            child: const Text("Register a number"),
          ),
          TextButton(
            onPressed: () async {
              print(await whatsapp.deregisterNumber(pin: "123456"));
            },
            child: const Text("Deregister a number"),
          ),
          TextButton(
            onPressed: () async {
              print(await whatsapp.getWhatsAppBusinessAccounts(
                  inputToken: "EAAGp6a..."));
            },
            child: const Text("Get Shared WhatsApp Business Account Id"),
          ),
          TextButton(
            onPressed: () async {
              print(await whatsapp.getWhatsAppBusinessAccountsList(
                  accountId: 111939554870583));
            },
            child: const Text("Get Shared WhatsApp Business Account List"),
          ),
          TextButton(
            onPressed: () async {
              print(await whatsapp.messagesButton(
                  to: phoneNumber,
                  bodyText: "Do you love flutter",
                  buttons: [
                    {"id": "yes", "text": "👍 Yes"},
                    {"id": "no", "text": "✋ No"}
                  ]));
            },
            child: const Text("Send Button Options"),
          ),
          TextButton(
            onPressed: () async {
              final ImagePicker _picker = ImagePicker();
              final XFile? image =
                  await _picker.pickImage(source: ImageSource.gallery);
              print(await whatsapp.uploadMedia(
                  mediaFile: image,
                  mediaType: http_parser.MediaType('image', 'png'),
                  mediaName: "Flutter Logo"));
            },
            child: const Text("Upload Image"),
          ),
          TextButton(
            onPressed: () async {
              print(await whatsapp.deleteMedia(mediaId: "614427183802844"));
            },
            child: const Text("Delete Media"),
          ),
          TextButton(
            onPressed: () async {
              print(await whatsapp.getMediaUrl(mediaId: "429565272622604"));
            },
            child: const Text("Retrive Media URL"),
          ),
          TextButton(
            onPressed: () async {
              print(await whatsapp.updateProfile(
                  businessAbout: "A.I.",
                  businessWebsites: ["https://tonystark.com"], //list of website
                  businessAddress: "New York",
                  businessDescription: "You know who i am, the Ironman",
                  businessEmail: "tony@ironman.com",
                  businessIndustry: "A.I",
                  businessProfileId: "10203949568543"));
            },
            child: const Text("Update Profile"),
          ),
          TextButton(
            onPressed: () async {
              print(whatsapp.setTwoStepVerification(pin: "123456"));
            },
            child: const Text("Set Two Step Verification"),
          ),
        ],
      ),
    );
  }
}


```
