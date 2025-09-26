<p align="center">
  <img src="https://raw.githubusercontent.com/rohit-chouhan/whatsapp/main/img/banner.png" alt="WhatsApp Flutter Banner"/>
</p>

This Flutter package allows you to integrate the **WhatsApp Business API** into your Flutter applications. It enables sending `messages`, `media`, `templates`, managing `business information`, creating `interactives` and `flows`, sending `catalog messages`, and more. The package is updated to support the latest **WhatsApp Business API v23.0**.

![Pub Likes](https://img.shields.io/pub/likes/whatsapp)
![Pub Points](https://img.shields.io/pub/points/whatsapp)
![Pub Monthly Downloads](https://img.shields.io/pub/dm/whatsapp)
![GitHub Issues](https://img.shields.io/github/issues/rohit-chouhan/whatsapp)
![GitHub PRs](https://img.shields.io/github/issues-pr/rohit-chouhan/whatsapp)
![GitHub Forks](https://img.shields.io/github/forks/rohit-chouhan/whatsapp)

[![Rohit Chouhan](https://user-images.githubusercontent.com/82075108/182797964-a92e0c59-b9ef-432d-92af-63b6475a4b1c.svg)](https://www.github.com/rohit-chouhan) 
_[![Sponsor](https://user-images.githubusercontent.com/82075108/182797969-11208ddc-b84c-4618-8534-18388d24ac18.svg)](https://github.com/sponsors/rohit-chouhan)_

---

## Documentation

Full documentation for the WhatsApp Flutter package is available at [whatsapp-flutter.github.io](https://whatsapp-flutter.github.io).

You can switch the documentation version using the version selector at the top of the page (`version:`).  

Other useful links:

- [Official WhatsApp Flutter website](https://whatsapp-flutter.github.io)
- [Initialization Guide](https://whatsapp-flutter.github.io/docs/initialization)
- [Return Methods](https://whatsapp-flutter.github.io/docs/return-methods) – Learn how to handle API responses
- [Method Usage](https://whatsapp-flutter.github.io/docs/method-usage) – Detailed usage instructions

---

## New Features in v4.0.0  

- **Performance Improvements** – Optimized core methods, now up to 3x faster than previous versions.  
- **Web Platform Support** – Now supports fully compatibility with Flutter Web.  
- **Service-Specific Methods** – Each service now provides dedicated getters for cleaner and more explicit usage.  
- **Flow Messages** – Added support for interactive flow messages to improve user engagement.  
- **Catalog & Product Messages** – Send product details and catalog messages for e-commerce use cases.  
- **Resumable Uploads** – Support for creating and managing resumable upload sessions for large files.  
- **Error Handling Enhancements** – Improved and added `WhatsAppException` handling with detailed error types.  
- **Bug Fixes** – Resolved multiple issues affecting stability and reliability.  
- **API Upgrade** – Updated to support `WhatsApp Business API v23.0` (stable).  

---

## Basic Usage

```dart
// Access token provided by Meta for WhatsApp Cloud API
const accessToken = 'YOUR_ACCESS_TOKEN';

// Your WhatsApp Business phone number ID
const fromNumberId = 'YOUR_PHONE_NUMBER_ID';

// Create WhatsApp client instance
final whatsapp = WhatsApp(accessToken, fromNumberId);

// Send a simple text message
var message = await whatsapp.sendMessage(
  phoneNumber: 'RECEIPT_NUMBER', // Recipient's phone number in international format
  text: 'Hi, how are you?',      // Message content
);

if (message.isSuccess()) {
  // Message sent successfully
  // Get and print the unique ID of the sent message
  print('Message ID: ${message.getMessageId()}');
  // Get and print the recipient number
  print('Message sent to: ${message.getContactId()}');
  // Get and print the full API response body
  print('API Response: ${message.getFullResponse()}');
} else {
  // Message failed to send
  // Print HTTP error code returned by the API
  print('HTTP Code: ${message.getErrorCode()}');
  // Print exact error details from WhatsApp Cloud API
  print('API Error: ${message.getErrorMessage()}');
  // Print type of request error (e.g., validation, authorization, etc.)
  print('Request Error: ${message.getErrorType()}');
}
```

## 📌 Looking for a Better Example?

👉 Check out this **working example** here:  
🔗 [pub.dev WhatsApp Example](https://pub.dev/packages/whatsapp/example)

# Contributors

[![chouhan-rahul](https://user-images.githubusercontent.com/82075108/193220114-cd307ff4-9176-448c-9be6-e8bdee70206d.svg)
](https://github.com/chouhan-rahul)

Have you found a bug or have a suggestion of how to enhance WhatsApp Package? Open an issue or pull request and we will take a look at it as soon as possible.

# Report bugs or issues

You are welcome to open a _[ticket](https://github.com/rohit-chouhan/whatsapp/issues)_ on github if any problems arise. New ideas are always welcome.

# Copyright and License

> Copyright © 2022 **[Rohit Chouhan](https://rohitchouhan.com)**. Licensed under the _[MIT LICENSE](https://github.com/rohit-chouhan/whatsapp/blob/main/LICENSE)_.
