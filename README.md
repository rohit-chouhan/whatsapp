<center><img width="150" src="https://raw.githubusercontent.com/rohit-chouhan/whatsapp/main/img/banner.png"/>
<p>
WhatsApp API package for flutter, to send message and product information.
</p>
</center>

### Platform Support

| Android | iOS | MacOS | Web | Linux | Windows |
| :-----: | :-: | :---: | :-: | :---: | :-----: |
|   ✔️    | ✔️  |  ✔️   | ✔️  |  ✔️   |   ✔️    |


- [WhatsApp Business Configuration](#whatsapp-business-configuration)
- [Installation](#installation)
  * [Configure accessToken and Phone ID](#configure-accessToken-and-phone-id)
  * [💬 short `Direct chat link`](#---short--direct-chat-link-)
  * [💬 messagesTemplate `Send a template message`](#---messagestemplate--send-a-template-message-)
  * [💬 messagesText `Send a text message`](#---messagestext--send-a-text-message-)
  * [💬 messagesMedia `Send a media message`](#---messagesmedia--send-a-media-message-)
  * [💬 messagesLocation `Send a location message`](#---messageslocation--send-a-location-message-)
  * [More Coming soon]

### WhatsApp Business Configuration
You must have WhatsApp apps in facebook developer, to use this package, please follow this link for [Guidence](https://developers.facebook.com/).
### Installation
```dart 
import 'package:whatsapp/whatsapp.dart';
Whatsapp whatsapp = Whatsapp();
```
#### Configure accessToken and Phone ID
```dart
whatsapp.setup(
	accessToken: "your_access_token_here",
	fromNumberId: 10000000000000 //integer
);
```

#### 💬 short `Direct chat link`
this method used to generate direct chat link

**parameter:-**
* `to` - number of client 
* `message` - message
* `compress` - true / false for compress link

**sample code:-**
```dart
whatsapp.short(
	to: 910000000000, // number with country code (without +),
	message: "Hey",
	compress: true
);

//return : https://wa.me/910000000000?text=Hy
```

#### 💬 messagesTemplate `Send a template message`
this method used to send a template message to client's whatsapp

**parameter:-**
* `to` - number of client 
* `templateName` - name of a template

**sample code:-**
```dart
whatsapp.messagesTemplate(
	to: 910000000000, // number with country code (without +),
	templateName: "hello_world" //template name
);
```

#### 💬 messagesText `Send a text message`
this method used to send a text message to client's whatsapp

**parameter:-**
* `to` - number of client 
* `message` - message your want to send
* `previewUrl` - true and false for preview url in message

**sample code:-**
```dart
whatsapp.messagesTemplate(
	to: 910000000000, // number with country code (without +),
	message: "Hey, Flutter, follow me on https://example.com", //message
	previewUrl: true
);
```
#### 💬 messagesMedia `Send a media message`
this method used to send a media message to client's whatsapp

**parameter:-**
* `to` - number of client 
* `mediaType` - type of media ex. image
* `mediaId` - uploaded media id on whatsapp business

**sample code:-**
```dart
whatsapp.messagesMedia(
	to: 910000000000, // number with country code (without +),
	mediaType: "image",
	mediaId: "f043afd0-f0ae-4b9c-ab3d-696fb4c8cd68"
);
```

#### 💬 messagesLocation `Send a location message`
this method used to send a location message to client's whatsapp

**parameter:-**
* `to` - number of client 
* `longitude` -longitude string
* `latitude` - latitude string
* `name` - name of location
* `address` - full address of location

**sample code:-**
```dart
whatsapp.messagesLocation(
	to: 910000000000, // number with country code (without +),
	longitude: "26.4866491",
	latitude: "74.5288578",
	name: "Pushkar",
	address: "Rajasthan, India"
);
```

#### Feel free to contribute ❤️