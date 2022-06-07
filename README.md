<center><img width="150" src="https://upload.wikimedia.org/wikipedia/commons/thumb/6/6b/WhatsApp.svg/2044px-WhatsApp.svg.png"/>
<p>
WhatsApp API package for flutter, to send message and product information.
</p>
</center>


- [WhatsApp Business Configuration](#whatsapp-business-configuration)
- [Installation](#installation)
  * [Configure access_token and Phone ID](#configure-access-token-and-phone-id)
  * [💬 messagesTemplate `Send a template message`](#---messagestemplate--send-a-template-message-)
  * [💬 messagesText `Send a text message`](#---messagestext--send-a-text-message-)
  * [💬 messagesMedia `Send a media message`](#---messagesmedia--send-a-media-message-)
  * [💬 messagesLocation `Send a location message`](#---messageslocation--send-a-location-message-)
  * [More Coming soon]

### WhatsApp Business Configuration
You must have WhatsApp apps in facebook developer, to use this package, please follow this link for [Guidence](https://developers.facebook.com/).
### Installation
```dart 
import ''
Whatsapp whatsapp = new Whatsapp();
```
#### Configure access_token and Phone ID
```dart
whatsapp.setup({
	access_token: "your_access_token_here",
	phone_numner: "your_business_number_id"
});
```

#### 💬 messagesTemplate `Send a template message`
this method used to send a template message to client's whatsapp

**parameter:-**
* `to` - number of client 
* `template_name` - name of a template

**sample code:-**
```dart
whatsapp.messagesTemplate(
	to: "910000000000", // number with country code (without +),
	template_name: "hello_world" //template name
);
```

#### 💬 messagesText `Send a text message`
this method used to send a text message to client's whatsapp

**parameter:-**
* `to` - number of client 
* `message` - message your want to send
* `preview_url` - true and false for preview url in message

**sample code:-**
```dart
whatsapp.messagesTemplate(
	to: "910000000000", // number with country code (without +),
	message: "Hey, Flutter, follow me on https://example.com", //message
	preview_url: true
);
```
#### 💬 messagesMedia `Send a media message`
this method used to send a media message to client's whatsapp

**parameter:-**
* `to` - number of client 
* `media_type` - type of media ex. image
* `media_id` - uploaded media id on whatsapp business
**sample code:-**
```dart
whatsapp.messagesMedia(
	to: "910000000000", // number with country code (without +),
	media_type: "image",
	media_id: "f043afd0-f0ae-4b9c-ab3d-696fb4c8cd68"
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
whatsapp.messagesMedia(
	to: "910000000000", // number with country code (without +),
	longitude: "26.4866491",
	latitude: "74.5288578",
	name: "Pushkar",
	address: "Rajasthan, India"
);
```