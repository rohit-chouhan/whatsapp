# WhatsApp Package Example

This is an example Flutter application demonstrating the usage of the WhatsApp Cloud API package.

## Features

- Generate WhatsApp share links
- Test sending text messages (requires valid API credentials)
- Test uploading media files by URL (requires valid API credentials)
- Interactive UI for testing package functionality

## Getting Started

1. Clone the repository and navigate to the example directory.
2. Run `flutter pub get` to install dependencies.
3. Update the access token and from number ID in the app with your WhatsApp Cloud API credentials.
4. Run the app with `flutter run`.

## Usage

- Enter your WhatsApp Cloud API access token and from number ID.
- Input a phone number and message.
- Input a media URL for testing uploads.
- Use "Generate WhatsApp Link" to create a shareable link.
- Use "Test Send Message" to attempt sending a message via the API.
- Use "Test Upload Media" to attempt uploading media via the API.

Note: Sending messages and uploading media require valid API credentials and will fail with dummy values.

## Resources

- [WhatsApp Cloud API Documentation](https://developers.facebook.com/docs/whatsapp/cloud-api/)
- [Flutter Documentation](https://docs.flutter.dev/)
