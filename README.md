<p align="center"><img src="https://raw.githubusercontent.com/rohit-chouhan/whatsapp/main/img/banner.png"/></p>
<p align="center"><img src="https://raw.githubusercontent.com/rohit-chouhan/whatsapp/main/img/banner2.jpg"/></p>

[![rohit-chouhan](https://user-images.githubusercontent.com/82075108/182797964-a92e0c59-b9ef-432d-92af-63b6475a4b1c.svg)](https://www.github.com/rohit-chouhan)
_[![sponsor](https://user-images.githubusercontent.com/82075108/182797969-11208ddc-b84c-4618-8534-18388d24ac18.svg)](https://github.com/sponsors/rohit-chouhan)_

WhatsApp API package for flutter, to send message and product information.

<!-- TOC start -->

- [WhatsApp Business Configuration](#whatsapp-business-configuration)
  - [💬 Short link](#short-link)
  - [💬 Send template](#send-template)
  - [💬 Send text message](#send-text-message)
  - [💬 Send media files](#send-media-files)
  - [💬 Send location details](#send-location-details)
  - [💬 Send media by link](#send-media-by-link)
  - [💬 Send reaction on message](#send-reaction-on-message)
  - [💬 Send reply on message](#send-reply-on-message)
  - [💬 Send reply with media](#send-reply-with-media)
  - [💬 Send reply with media url](#send-reply-with-media-url)
  - [📞 Register a number](#register-a-number)
  - [📞 Deregister a number](#deregister-a-number)
  - [🆔 Get Shared WhatsApp Business Account Id](#get-shared-whatsapp-business-account-id)
  - [🆔 Get Shared WhatsApp Business Account List](#get-shared-whatsapp-business-account-list)
  - [🔘 Send button options](#send-button-options)
  - [📁 Upload media files](#upload-media-files)
  - [📁 Delete media files](#delete-media-files)
  - [📁 Retrive media url](#retrive-media-url)
  - [🚀 Update Business profile](#update-business-profile)
  - [🔐 Two step verification code](#two-step-verification-code)
  <!-- TOC end -->

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

#### Short link

💬 Generate the short link of the WhatsApp.

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

#### Send template

💬 Send the template to the client.

- `to` - the phone number with country code but without the plus (+) sign.
- `templateName` - the template name.

```dart
whatsapp.messagesTemplate(
	to: 910000000000,
	templateName: "hello_world"
);
```

#### Send text message

💬 Send the text message to the client.

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

#### Send media files

💬 Send the media files to the client.

- `to` - the phone number with country code but without the plus (+) sign.
- `mediaType` - the type of media such as image, document, audio, image, or video
- `mediaId` - Use this edge to retrieve and delete media.

```dart
whatsapp.messagesMedia(
	to: 910000000000,
	mediaType: "image",
	mediaId: "f043afd0-f0ae-4b9c-ab3d-696fb4c8cd68"
);
```

#### Send location details

💬 Send the location to the client.

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

#### Send media by link

💬 Send the location to the client.

- `to` - the phone number with country code but without the plus (+) sign.
- `mediaType` - the type of media such as image, document, audio, image, or video
- `mediaLink` - the media to be sent.
- `caption` - the caption of media

```dart
whatsapp.messagesMediaByLink(
	to: 910000000000,
	mediaType:"video",
	mediaLink: "https://example.com/flutter.mp4",
	caption:"My Flutter Video"
);
```

#### Send reaction on message

💬 Send the location to the client.

- `to` - the phone number with country code but without the plus (+) sign.
- `messageId` - the message id.
- `emoji` - the emoji to be sent.

```dart
whatsapp.messagesReaction(
	to: 910000000000,
	messageId: "wamid.xxxxxxxxxxxxxxxxxx==",
	emoji: "👍"
);
```

#### Send reply on message

💬 Send the location to the client.

- `to` - the phone number with country code but without the plus (+) sign.
- `messageId` - the message id.
- `message` - the message to be sent.
- `previewUrl` - used to preview the URL in the chat window.

```dart
whatsapp.messagesReply(
	to: 910000000000,
	messageId: "wamid.xxxxxxxxxxxxxxxxxx==",
	message: "Hey, Flutter!",
	previewUrl: true
);
```

#### Send reply with media

💬 Reply to a media by ID

- `to` - the phone number with country code but without the plus (+) sign.
- `messageId` - the message id.
- `mediaType` - type of media such as image, document, audio or video
- `mediaId` - id of media to be replay.

```dart
whatsapp.messagesReplyMedia(
	to: 910000000000,
	messageId: "wamid.xxxxxxxxxxxxxxxxxx==",
	mediaType: "image",
	mediaId: "1000000000000000"
);
```

#### Send reply with media url

💬 Reply to a media by URL

- `to` - the phone number with country code but without the plus (+) sign.
- `messageId` - the message id.
- `mediaType` - type of media such as image, document, audio or video
- `mediaLink` - link of media to be replay.
- `caption` - caption of media to be replay.

```dart
whatsapp.messagesReplyMediaUrl(
	to: 910000000000,
	messageId: "wamid.xxxxxxxxxxxxxxxxxx==",
	mediaType: "video",
	mediaLink: "http://example.com/video.mp4",
	caption: "My Flutter Video"
);
```

#### Register a number

📞 Register a phone number

- `pin` is 6-digit pin for Register number.

```dart
whatsapp.registerNumber(
	pin:"123456"
);
```

#### Deregister a number

📞 Deregister a phone number

- `pin` is 6-digit pin for deregister number.

```dart
whatsapp.deregisterNumber(
	pin:"123456"
);
```

#### Get Shared WhatsApp Business Account Id

🆔 Get Shared WhatsApp Business Account Id

- `inputToken` - token generated after embedding the signup flow

```dart
whatsapp.getWhatsAppBusinessAccounts(
	inputToken:"EAAFl...."
);
```

#### Get Shared WhatsApp Business Account List

🆔 Get Shared WhatsApp Business Account List

- `accountId` - Business manager account Id

```dart
whatsapp.getWhatsAppBusinessAccountsList(
	accountId: 805021500648488
);
```

#### Send button options

🔘 Send message with action buttons for choice

- `to` - the phone number with country code but without the plus (+) sign.
- `bodyText` -the main body text of message
- `buttons` - list of action buttons with id and text

```dart
whatsapp.messagesButton(
	bodyText: "Do you love flutter",
    buttons: [
        {"id": "yes", "text": "👍 Yes"},
        {"id": "no", "text": "✋ No"}
	]
);
```

#### Upload media files

📁 Upload Media to WhatsApp Business

- `mediaFile` - the file object to be send
- `mediaName` - the name of file

You need third-party packages for media uploads, for example [image_picker](https://pub.dev/packages/image_picker) for uploading images.

```dart
final ImagePicker _picker = ImagePicker();
final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
whatsapp.uploadMedia(
	mediaFile: image,
	mediaName: "Flutter Logo"
);
```

#### Delete media files

📁 Delete uploaded media

- `mediaId`- id of media file

```dart
whatsapp.deleteMedia(
	mediaId: "1000000000000000"
);
```

#### Retrive media url

📁 Retrive URL of media

- `mediaId`- id of media file

```dart
whatsapp.getMediaUrl(
	mediaId: "1000000000000000"
);
```

#### Update Business profile

🚀 Update WhatsApp Business Account Details

- `businessAddress` - address of business
- `businessDescription` - description of business
- `businessIndustry` - industry of business
- `businessAbout` - about of your business
- `businessEmail` - email of your business
- `businessWebsites` - list of website to update
- `businessProfileId` - image handle id to update profile picture of business

```dart
whatsapp.updateProfile(
	businessAbout: "A.I.",
	businessWebsites: ["https://tonystark.com"], //list of website
	businessAddress: "New York",
	businessDescription: "You know who i am, the Ironman",
	businessEmail: "tony@ironman.com",
	businessIndustry: "A.I",
	businessProfileId: "10203949568543" //image handler id
);
```

#### Two step verification code

🔐 Set Two Step Verification Code

- `pin` - 6-digit pin for two step verification.

```dart
whatsapp.setTwoStepVerification(
	pin:"123456"
);
```

# Contributors

[![chouhan-rahul](https://user-images.githubusercontent.com/82075108/193220114-cd307ff4-9176-448c-9be6-e8bdee70206d.svg)
](https://github.com/chouhan-rahul)

# Report bugs or issues

You are welcome to open a _[ticket](https://github.com/rohit-chouhan/whatsapp/issues)_ on github if any problems arise. New ideas are always welcome.

# Copyright and License

> Copyright © 2022 **[Rohit Chouhan](https://rohitchouhan.com)**. Licensed under the _[MIT LICENSE](https://github.com/rohit-chouhan/whatsapp/blob/main/LICENSE)_.
