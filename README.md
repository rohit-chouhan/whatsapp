<p align="center"><img src="https://raw.githubusercontent.com/rohit-chouhan/whatsapp/main/img/banner.png"/></p>

This Flutter package allows you to integrate the WhatsApp Business API into your Flutter applications, enabling features such as sending `messages`, `media`, `templates`, `business information`, `interactives`, and more.

[![rohit-chouhan](https://user-images.githubusercontent.com/82075108/182797964-a92e0c59-b9ef-432d-92af-63b6475a4b1c.svg)](https://www.github.com/rohit-chouhan) _[![sponsor](https://user-images.githubusercontent.com/82075108/182797969-11208ddc-b84c-4618-8534-18388d24ac18.svg)](https://github.com/sponsors/rohit-chouhan)_

## Documentation

The full documentation for WhatsApp Package can be found on [whatsapp-flutter.github.io](https://whatsapp-flutter.github.io)

To switch the documentation version, use the version selector located at the top of the page, marked with `version:`.

**Note:** The documentation in the main branch is more up-to-date than the released documentation on the official docs website.

Other useful links:

- [Official WhatsApp Flutter website](https://whatsapp-flutter.github.io)
- [Initialization of WhatsApp Flutter](https://whatsapp-flutter.github.io/docs/initialization)
- [Return Methods](https://whatsapp-flutter.github.io/docs/return-methods) will help you determine your request.
- [Method Usage](https://whatsapp-flutter.github.io/docs/method-usage) contains important information to help you get started.

Example:

```dart
const accessToken ='EAAGp6aTb8.....';
const fromNumberId = '1082772452xxxxx';

final whatsapp = WhatsApp(accessToken, fromNumberId);

var res = await whatsapp.sendMessage(
  phoneNumber : 'PHONE_NUMBER',
  text : 'text_message',
  previewUrl : true,
);

if (res.isSuccess()) {
    // when message sent
    //Return id of message
    debugPrint('Message ID: ${res.getMessageId()}');

    //Return number where message sent
    debugPrint('Message sent to: ${res.getPhoneNumber()}');

    //Return exact API Response Body
    debugPrint('API Response: ${res.getResponse().toString()}');
} else {
    //when something went wrong
    //Will return HTTP CODE
    debugPrint('HTTP Code: ${res.getHttpCode()}');

    // Will return exact error from WhatsApp Cloud API
    debugPrint('API Error: ${res.getErrorMessage()}');

    // Will return HTTP Request error
    debugPrint('Request Error: ${res.getError()}');

    //Return exact API Response Body
    debugPrint('API Response: ${res.getResponse().toString()}');
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
