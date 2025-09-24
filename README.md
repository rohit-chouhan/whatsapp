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

- **Speed Optimized** – Now 3x faster than previous versions
- **Dedicated Methods** – Each service now has its own getter for better clarity
- **Flow Messages** – Send interactive flow messages for enhanced user experience
- **Catalog & Product Messages** – Send product information and catalog messages for e-commerce
- **Enhanced Error Handling** – Clearer exceptions with specific error types
- **Bugs Fixed** – Fixed issues with various methods
- **Updated API Version** – Now supports WhatsApp Business API v23.0

---

## Basic Usage

```dart
const accessToken ='EAAGp6aTb8.....';
const fromNumberId = '1082772452xxxxx';

final whatsapp = WhatsApp(accessToken, fromNumberId);

var res = await whatsapp.sendMessage(
    phoneNumber: 'PHONE_NUMBER',
    text: 'text_message',
    previewUrl: true,
);

if (res.isSuccess()) {
    // when message sent
    //Return id of message
    print('Message ID: ${res.getMessageId()}');

    //Return number where message sent
    print('Message sent to: ${res.getContactId()}');

    //Return exact API Response Body
    print('API Response: ${res.getFullResponse()}');
} else {
    //Will return WhatsApp error code
    print('HTTP Code: ${res.getErrorCode()}');

    // Will return exact error from WhatsApp Cloud API
    print('API Error: ${res.getErrorMessage()}');

    // Will return WhatsApp error type
    print('Request Error: ${res.getErrorType()}');
}
```

# Contributors

[![chouhan-rahul](https://user-images.githubusercontent.com/82075108/193220114-cd307ff4-9176-448c-9be6-e8bdee70206d.svg)
](https://github.com/chouhan-rahul)

Have you found a bug or have a suggestion of how to enhance WhatsApp Package? Open an issue or pull request and we will take a look at it as soon as possible.

# Report bugs or issues

You are welcome to open a _[ticket](https://github.com/rohit-chouhan/whatsapp/issues)_ on github if any problems arise. New ideas are always welcome.

# Copyright and License

> Copyright © 2022 **[Rohit Chouhan](https://rohitchouhan.com)**. Licensed under the _[MIT LICENSE](https://github.com/rohit-chouhan/whatsapp/blob/main/LICENSE)_.
