enjoy coding 😃

```dart
import 'package:flutter/material.dart';
import 'package:whatsapp/whatsapp.dart';

void main() {
  runApp(const MaterialApp(
    home: MyApp(),
  ));
}


class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    whatsapp.setup(
      access_token: 'cXnwup67hgj3QdvpXXXXX==',
      fromNumberId: 1800000000000, //Integer
    );
  }


  Whatsapp whatsapp = Whatsapp();
  @override
  Widget build(BuildContext context) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                child: const Text('Send Message'),
                onPressed: () async {
                  await whatsapp.messagesTemplate(
                    to: 91000000000, //integer
                    template_name: "hello_world"
                  );
                },
              ),
            ],
          ),
        ),
      );
  }
}
```