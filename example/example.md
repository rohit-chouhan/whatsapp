enjoy coding 😃

```dart
import 'package:flutter/material.dart';
import 'package:whatsapp/whatsapp.dart';

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
      fromNumberId: 0000000000,
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
              await whatsapp.short(
                to: phoneNumber,
                message: "Hello Flutter",
                compress: true,
              );
            },
            child: const Text("Generate Short Link"),
          ),
          TextButton(
            onPressed: () async {
              await whatsapp.messagesText(
                to: phoneNumber,
                message: "Hello Flutter",
                previewUrl: true,
              );
            },
            child: const Text("Send Message"),
          ),
          TextButton(
            onPressed: () async {
              await whatsapp.messagesTemplate(
                to: phoneNumber,
                templateName: "hello_world",
              );
            },
            child: const Text("Send Template"),
          ),
          TextButton(
            onPressed: () async {
            await  whatsapp.messagesMedia(
                to: phoneNumber,
                mediaId: "",
                mediaType: "image",
              );
            },
            child: const Text("Send Media File"),
          ),
          TextButton(
            onPressed: () async {
              await whatsapp.messagesLocation(
                to: 917611959290,
                address: "Rajasthan, India",
                longitude: "26.4866491",
                latitude: "74.5288578",
                name: "Pushkar",
              );
            },
            child: const Text("Send Location"),
          ),
          TextButton(
            onPressed: () async {
              await whatsapp.messagesMediaByLink(
                to: 910000000000,
                mediaType:"video",
                mediaLink: "https://example.com/flutter.mp4",
                caption:"My Flutter Video"
              );
            },
            child: const Text("Send Media By Link"),
          ),
          TextButton(
            onPressed: () async {
              await whatsapp.messagesReaction(
                to: phoneNumber,
                messageId: "wamid.xxxxxxxxxxxxxxxxxx==",
                emoji: "👍",
              );
            },
            child: const Text("Send Reaction on Message"),
          ),
          TextButton(
            onPressed: () async {
              await whatsapp.messagesReply(
                to: phoneNumber,
                messageId: "wamid.xxxxxxxxxxxxxxxxxx==",
                message: "Hey, Flutter!",
                previewUrl: true,
              );
            },
            child: const Text("Send Reply on Message"),
          ),
           TextButton(
            onPressed: () async {
              await whatsapp.messagesReplyMedia(
                to: 910000000000,
                messageId: "wamid.xxxxxxxxxxxxxxxxxx==",
                mediaType: "image",
                mediaId: "1000000000000000"
              );
            },
            child: const Text("Send Reply with Media"),
          ),
           TextButton(
            onPressed: () async {
              await whatsapp.messagesReplyMediaUrl(
                to: 910000000000,
                messageId: "wamid.xxxxxxxxxxxxxxxxxx==",
                mediaType: "video",
                medialInk: "http://example.com/video.mp4",
                caption: "My Flutter Video"
              );
            },
            child: const Text("Send Reply with Media (Url)"),
          ),
           TextButton(
            onPressed: () async {
              await whatsapp.registerNumber(
                pin:"123456"
              );
            },
            child: const Text("Register a number"),
          ),
           TextButton(
            onPressed: () async {
              await whatsapp.deregisterNumber(
                pin:"123456"
              );
            },
            child: const Text("Deregister a number"),
          ),
           TextButton(
            onPressed: () async {
              await whatsapp.getWhatsAppBusinessAccounts(
                inputToken:"EAAFl..."
              );
            },
            child: const Text("Get Shared WhatsApp Business Account Id"),
          ),
          TextButton(
            onPressed: () async {
              await whatsapp.getWhatsAppBusinessAccountsList(
                accountId:805021500648488
              );
            },
            child: const Text("Get Shared WhatsApp Business Account List"),
          ),
        ],
      ),
    );
  }
}

```
