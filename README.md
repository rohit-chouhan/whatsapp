<p align="center"><img src="https://raw.githubusercontent.com/rohit-chouhan/whatsapp/main/img/banner.png"/></p>

[![rohit-chouhan](https://user-images.githubusercontent.com/82075108/182797964-a92e0c59-b9ef-432d-92af-63b6475a4b1c.svg)](https://www.github.com/rohit-chouhan)
_[![sponsor](https://user-images.githubusercontent.com/82075108/182797969-11208ddc-b84c-4618-8534-18388d24ac18.svg)](https://github.com/sponsors/rohit-chouhan)_

WhatsApp API package for flutter, to send message and product information.
- [WhatsApp Business Configuration](#whatsapp-business-configuration)
	- [💬 Short link](#💬-short-link)
	- [💬 Send template](#💬-send-template)
	- [💬 Send text message](#💬-send-text-message)
	- [💬 Send media files](#💬-send-media-files)
	- [💬 Send location details](#💬-send-location-details)

### WhatsApp Business Configuration
You must have WhatsApp apps in facebook developer, to use this package, please follow this [Guidelines](https://developers.facebook.com/).

```dart 
WhatsApp whatsapp = WhatsApp();
```
Configure `accessToken` and `fromNumberId`.

```dart
whatsapp.setup(
	accessToken: "your_access_token_here",
	fromNumberId: 10000000000000
);
```

#### 💬 Short link
Generate the short link of the WhatsApp.
- `to` - the phone number with country code but without the plus (+) sign.
- `message` - the message to be sent.
- `compress` - pass `true` to compress the link.

```dart
whatsapp.short(
	to: 910000000000,
	message: "Hey",
	compress: true
);
//return : https://wa.me/910000000000?text=Hy
```

#### 💬 Send template
Send the template to the client.
- `to` - the phone number with country code but without the plus (+) sign.
- `templateName` - the template name.

```dart
whatsapp.messagesTemplate(
	to: 910000000000, 
	templateName: "hello_world"
);
```

#### 💬 Send text message
Send the text message to the client.
- `to` - the phone number with country code but without the plus (+) sign.
- `message` - the message to be sent.
- `previewUrl` - is used to preview the URL in the chat window.

```dart
whatsapp.messagesTemplate(
	to: 910000000000,
	message: "Hey, Flutter, follow me on https://example.com",
	previewUrl: true
);
```
#### 💬 Send media files
Send the media files to the client.
- `to` - the phone number with country code but without the plus (+) sign.
- `mediaType` - the type of media such as image, document, audio, image, video, or sticker.
- `mediaId` - Use this edge to retrieve and delete media.
  
```dart
whatsapp.messagesMedia(
	to: 910000000000,
	mediaType: "image",
	mediaId: "f043afd0-f0ae-4b9c-ab3d-696fb4c8cd68"
);
```

#### 💬 Send location details
Send the location to the client.
- `to` - the phone number with country code but without the plus (+) sign.
- `longitude` - the longitude of the location.
- `latitude` - the latitude of the location.
- `name` - the name of the location.
- `address` - the full address of the location.

```dart
whatsapp.messagesLocation(
	to: 910000000000,
	longitude: "26.4866491",
	latitude: "74.5288578",
	name: "Pushkar",
	address: "Rajasthan, India"
);
```
# Contributors

[![chouhan-rahul](https://user-images.githubusercontent.com/82075108/193220114-cd307ff4-9176-448c-9be6-e8bdee70206d.svg)
](https://github.com/chouhan-rahul)
# Report bugs or issues

You are welcome to open a _[ticket](https://github.com/rohit-chouhan/whatsapp/issues)_ on github if any problems arise. New ideas are always welcome.

# Copyright and License

> Copyright © 2022 **[Rohit Chouhan](https://rohitchouhan.com)**. Licensed under the _[MIT LICENSE](https://github.com/rohit-chouhan/whatsapp/blob/main/LICENSE)_.