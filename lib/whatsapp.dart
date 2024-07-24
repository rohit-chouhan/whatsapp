library whatsapp;

import 'dart:io';

import 'package:whatsapp/services/account.dart';
import 'package:whatsapp/services/business.dart';
import 'package:whatsapp/services/contact.dart';
import 'package:whatsapp/services/custom.dart';
import 'package:whatsapp/services/interactive.dart';
import 'package:whatsapp/services/audio.dart';
import 'package:whatsapp/services/document.dart';
import 'package:whatsapp/services/image.dart';
import 'package:whatsapp/services/location.dart';
import 'package:whatsapp/services/media.dart';
import 'package:whatsapp/services/message.dart';
import 'package:whatsapp/services/phone.dart';
import 'package:whatsapp/services/reaction.dart';
import 'package:whatsapp/services/registration.dart';
import 'package:whatsapp/services/replay.dart';
import 'package:whatsapp/services/sticker.dart';
import 'package:whatsapp/services/template.dart';
import 'package:whatsapp/services/text.dart';
import 'package:whatsapp/services/video.dart';
import 'package:whatsapp/utils/request.dart';

class WhatsApp {
  final String _accessToken;
  final String _fromNumberId;
  late final Request _request;
  late final TextService _textService;
  late final ImageService _imageService;
  late final AudioService _audioService;
  late final DocumentService _documentService;
  late final VideoService _videoService;
  late final MessageService _messageService;
  late final StickerService _stickerService;
  late final ReactionService _reactionService;
  late final LocationService _locationService;
  late final InteractiveService _interactiveService;
  late final ContactService _contactService;
  late final MediaService _mediaService;
  late final AccountService _accountService;
  late final BusinessService _businessService;
  late final PhoneService _phoneService;
  late final RegistrationService _registrationService;
  late final ReplayService _replayService;
  late final TemplateService _templateService;
  late final CustomService _customService;

  WhatsApp(this._accessToken, this._fromNumberId) {
    _request = Request();
    _textService = TextService(_accessToken, _fromNumberId, _request);
    _imageService = ImageService(_accessToken, _fromNumberId, _request);
    _audioService = AudioService(_accessToken, _fromNumberId, _request);
    _documentService = DocumentService(_accessToken, _fromNumberId, _request);
    _videoService = VideoService(_accessToken, _fromNumberId, _request);
    _messageService = MessageService(_accessToken, _fromNumberId, _request);
    _stickerService = StickerService(_accessToken, _fromNumberId, _request);
    _reactionService = ReactionService(_accessToken, _fromNumberId, _request);
    _locationService = LocationService(_accessToken, _fromNumberId, _request);
    _interactiveService =
        InteractiveService(_accessToken, _fromNumberId, _request);
    _contactService = ContactService(_accessToken, _fromNumberId, _request);
    _mediaService = MediaService(_accessToken, _fromNumberId, _request);
    _accountService = AccountService(_accessToken, _fromNumberId, _request);
    _businessService = BusinessService(_accessToken, _fromNumberId, _request);
    _phoneService = PhoneService(_accessToken, _fromNumberId, _request);
    _registrationService =
        RegistrationService(_accessToken, _fromNumberId, _request);
    _replayService = ReplayService(_accessToken, _fromNumberId, _request);
    _templateService = TemplateService(_accessToken, _fromNumberId, _request);
    _customService = CustomService(_accessToken, _fromNumberId, _request);
  }

  /// Method to set custom version of the Facebook Graph API.
  /// [version] The version of the Facebook Graph API to use ex. v19.0
  void setVersion(String version) {
    _request.setVersion(version);
  }

  /// Send a message to the specified phone number
  /// [phoneNumber] The phone number with country code to which the message will be sent
  /// [text] The text message to be sent
  /// [previewUrl] Whether to include a preview URL in the message (default: false)
  ///
  /// return Request The response object containing the HTTP response code, error message, and message ID if the
  Future<Request> sendMessage(
      {required String phoneNumber,
      required String text,
      bool previewUrl = false}) async {
    Request res = await _textService.sendMessage(phoneNumber, text, previewUrl);
    return res;
  }

  /// Send a message with an image attachment to the specified phone number
  /// [phoneNumber] The phone number with country code to which the message will be sent
  /// [mediaId] The uploaded image file id to be sent
  /// [caption] The caption for the image (optional)
  ///
  /// return Request The response object containing the HTTP response code, error message, and message ID if the
  Future<Request> sendImageById(
      {required String phoneNumber,
      required String mediaId,
      String? caption}) async {
    Request res =
        await _imageService.sendImageById(phoneNumber, mediaId, caption);
    return res;
  }

  /// Send a message with an image attachment to the specified phone number
  /// [phoneNumber] The phone number with country code to which the message will be sent
  /// [imageUrl] The direct URL of the image to be sent
  /// [caption] The caption for the image (optional)
  ///
  /// return Request The response object containing the HTTP response code, error message, and message ID if the
  Future<Request> sendImageByUrl(
      {required String phoneNumber,
      required String imageUrl,
      String? caption}) async {
    Request res =
        await _imageService.sendImageByUrl(phoneNumber, imageUrl, caption);
    return res;
  }

  /// Send a message with an audio attachment to the specified phone number using Media Id
  /// [phoneNumber] The phone number with country code to which the message will be sent
  /// [mediaId] The uploaded audio file id to be sent
  ///
  /// return Request The response object containing the HTTP response code, error message, and message ID if the
  Future<Request> sendAudioById(
      {required String phoneNumber, required String mediaId}) async {
    Request res = await _audioService.sendAudioById(phoneNumber, mediaId);
    return res;
  }

  /// Send a message with an audio attachment to the specified phone number using URL
  /// [phoneNumber] The phone number with country code to which the message will be sent
  /// [audioUrl] The direct URL of the audio file to be sent
  ///
  /// return Request The response object containing the HTTP response code, error message, and message ID if the
  ///
  Future<Request> sendAudioByUrl(
      {required String phoneNumber, required String audioUrl}) async {
    Request res = await _audioService.sendAudioByUrl(phoneNumber, audioUrl);
    return res;
  }

  /// Send a message with a document attachment to the specified phone number using Media Id
  /// [phoneNumber] The phone number with country code to which the message will be sent
  /// [mediaId] The uploaded document file id to be sent
  /// [caption] The caption for the document (optional)
  /// [filename] The filename for the document (optional)
  ///
  /// return Request The response object containing the HTTP response code, error message, and message ID if the
  ///
  Future<Request> sendDocumentById(
      {required String phoneNumber,
      required String mediaId,
      String? caption,
      String? filename}) async {
    Request res = await _documentService.sendDocumentById(
        phoneNumber, mediaId, caption, filename);
    return res;
  }

  /// Send a message with a document attachment to the specified phone number using Media Id
  /// [phoneNumber] The phone number with country code to which the message will be sent
  /// [documentUrl] The direct URL of the document file to be sent
  /// [caption] The caption for the document (optional)
  /// [filename] The filename for the document (optional)
  ///
  /// return Request The response object containing the HTTP response code, error message, and message ID if the
  ///
  Future<Request> sendDocumentByUrl(
      {required String phoneNumber,
      required String documentUrl,
      String? caption,
      String? filename}) async {
    Request res = await _documentService.sendDocumentByUrl(
        phoneNumber, documentUrl, caption, filename);
    return res;
  }

  /// Send a message with an video attachment to the specified phone number
  /// [phoneNumber] The phone number with country code to which the message will be sent
  /// [mediaId] The uploaded video file id to be sent
  /// [caption] The caption for the video (optional)
  ///
  /// return Request The response object containing the HTTP response code, error message, and message ID if the
  Future<Request> sendVideoById(
      {required String phoneNumber,
      required String mediaId,
      String? caption}) async {
    Request res =
        await _videoService.sendVideoById(phoneNumber, mediaId, caption);
    return res;
  }

  /// Send a message with an video attachment to the specified phone number
  /// [phoneNumber] The phone number with country code to which the message will be sent
  /// [videoUrl] The direct URL of the video to be sent
  /// [caption] The caption for the video (optional)
  ///
  /// return Request The response object containing the HTTP response code, error message, and message ID if the
  Future<Request> sendVideoByUrl(
      {required String phoneNumber,
      required String videoUrl,
      String? caption}) async {
    Request res =
        await _videoService.sendVideoByUrl(phoneNumber, videoUrl, caption);
    return res;
  }

  /// Read (Seen) the messages received by the specified phone number
  /// [phoneNumber] The phone number with country code to which the messages will be read
  /// [messageId] The message ID to be marked as read (optional)
  ///
  /// return Request The response object containing the HTTP response code, error message, and message ID if the
  Future<Request> markAsRead(
      {required String phoneNumber, required String messageId}) async {
    Request res = await _messageService.markAsRead(phoneNumber, messageId);
    return res;
  }

  /// Send sticker to the specified phone number
  /// [phoneNumber] The phone number with country code to which the sticker will be sent
  /// [stickerId] The sticker ID to be sent
  ///
  /// return Request The response object containing the HTTP response code, error message, and message ID if the
  Future<Request> sendSticker(
      {required String phoneNumber, required String stickerId}) async {
    Request res = await _stickerService.sendSticker(phoneNumber, stickerId);
    return res;
  }

  /// Reaction to the specified message
  /// [phoneNumber] The phone number with country code to which the sticker will be sent
  /// [messageId] The message ID to which the reaction will be sent
  /// [emoji] The emoji to be used for the reaction
  ///
  /// return Request The response object containing the HTTP response code, error message, and message ID if the
  Future<Request> sendReaction(
      {required String phoneNumber,
      required String messageId,
      required String emoji}) async {
    Request res =
        await _reactionService.sendReaction(phoneNumber, messageId, emoji);
    return res;
  }

  /// Request a location from the specified phone number
  /// [phoneNumber] The phone number with country code to which the location will be requested
  /// [text] The text message to accompany the location request
  ///
  /// return Request The response object containing the HTTP response code, error message, and message ID if the
  Future<Request> sendLocationRequest(
      {required String phoneNumber, required String text}) async {
    Request res = await _locationService.sendLocationRequest(phoneNumber, text);
    return res;
  }

  /// Send location to specified phone number
  /// [phoneNumber] The phone number with country code to which the location will be sent
  /// [latitude] The latitude of the location
  /// [longitude] The longitude of the location
  /// [name] The name of the location (optional)
  /// [address] The address of the location (optional)
  ///
  /// return Request The response object containing the HTTP response code, error message, and message ID if the

  Future<Request> sendLocation(
      {required String phoneNumber,
      required double latitude,
      required double longitude,
      String? name,
      String? address}) async {
    Request res = await _locationService.sendLocation(
        phoneNumber, latitude, longitude, name, address);
    return res;
  }

  /// Send Interactive Replay Button to the specified phone number
  /// [phoneNumber] The phone number with country code to which the interactive replay button will be sent
  /// [headerInteractive] The header text for the interactive replay button
  /// [bodyText] The body text for the interactive replay button
  /// [footerText] The footer text for the interactive replay button
  /// [interactiveReplyButtons] The interactive reply buttons to be sent
  ///
  /// return Request The response object containing the HTTP response code, error message, and message ID if the

  Future<Request> sendInteractiveReplayButton(
      {required String phoneNumber,
      required Map<String, dynamic> headerInteractive,
      required String bodyText,
      required String footerText,
      required List<Map<String, dynamic>> interactiveReplyButtons}) async {
    Request res = await _interactiveService.sendInteractiveReplayButtons(
        phoneNumber,
        headerInteractive,
        bodyText,
        footerText,
        interactiveReplyButtons);
    return res;
  }

  /// Send Interactive Lists to the specified phone number
  /// [phoneNumber] The phone number with country code to which the interactive replay button will be sent
  /// [headerText] The header text for the interactive replay button (optional)
  /// [bodyText] The body text for the interactive replay button
  /// [footerText] The footer text for the interactive replay button (optional)
  /// [buttonText] The text for the interactive replay button (optional)
  /// [sections] Sections of interactive lists to be sent
  ///
  /// return Request The response object containing the HTTP response code, error message, and message ID if the

  Future<Request> sendInteractiveLists(
      {required String phoneNumber,
      String? headerText,
      required String bodyText,
      String? footerText,
      required String buttonText,
      required List<Map<String, dynamic>> sections}) async {
    Request res = await _interactiveService.sendInteractiveLists(
        phoneNumber, headerText, bodyText, footerText, buttonText, sections);
    return res;
  }

  /// Send Interactive for Call-To-Action Url to the specified phone number
  /// [phoneNumber] The phone number with country code to which the interactive replay button will be sent
  /// [headerText] The header text for the interactive replay button (optional)
  /// [bodyText] The body text for the interactive replay button
  /// [footerText] The footer text for the interactive replay button (optional)
  /// [buttonText] The text for the interactive replay button (optional)
  /// [actionUrl] Url to open when the interactive replay button is clicked
  ///
  /// return Request The response object containing the HTTP response code, error message, and message ID if the

  Future<Request> sendCallToActionButton(
      {required String phoneNumber,
      String? headerText,
      required String bodyText,
      String? footerText,
      required String buttonText,
      required String actionUrl}) async {
    Request res = await _interactiveService.sendCallToActionButton(
        phoneNumber, headerText, bodyText, footerText, buttonText, actionUrl);
    return res;
  }

  /// Send contact details to the specified phone number
  /// [phoneNumber] The phone number with country code to which the contact details will be sent
  /// [dateOfBirth] The date of birth of the contact
  /// [addresses] List of addresses of the contact
  /// [emails] List of emails of the contact
  /// [person] Person object containing contact details
  /// [organization] Organization object containing contact details
  /// [phones] List of phone numbers of the contact
  /// [urls] List of URLs of the contact
  ///
  /// return Request The response object containing the HTTP response code, error message, and message ID if the
  ///

  Future<Request> sendContactDetails(
      {required String phoneNumber,
      String? dateOfBirth,
      List<Map<dynamic, dynamic>>? addresses,
      List<Map<dynamic, dynamic>>? emails,
      required Map<dynamic, dynamic> person,
      Map<dynamic, dynamic>? organization,
      required List<Map<dynamic, dynamic>> phones,
      List<Map<dynamic, dynamic>>? urls}) async {
    Request res = await _contactService.sendContactDetails(phoneNumber,
        dateOfBirth, addresses, emails, person, organization, phones, urls);
    return res;
  }

  /// Upload media file to business server
  /// [file] The file to be uploaded
  /// [fileType] The type of the file (e.g., "image/jpeg", "video/mp4", "document/pdf")
  ///
  /// return String The URL of the uploaded media file
  Future<Request> uploadMediaFile(
      {required File file, required String fileType}) async {
    Request res = await _mediaService.uploadMediaFile(file, fileType);
    return res;
  }

  /// Get media url and information by media ID
  /// [mediaId] The media ID of the uploaded file
  ///
  /// returns -
  /// - getMediaUrl() - The URL of the media file
  /// - getMediaMimeType() - The MIME type of the media file (e.g., "image/jpeg")
  /// - getMediaFileSize() - The size of the media file in bytes
  /// - getMediaSha256() - The SHA-256 hash of the media file

  Future<Request> getMedia({required String mediaId}) async {
    Request res = await _mediaService.getMedia(mediaId);
    return res;
  }

  /// Delete media file from business server by media ID
  /// [mediaId] The media ID of the uploaded file
  ///
  /// return Request The response object containing the HTTP response code, error message, and message ID if the
  ///
  Future<Request> deleteMedia({required String mediaId}) async {
    Request res = await _mediaService.deleteMedia(mediaId);
    return res;
  }

  /// Register the number for use with Cloud API after you have performed your backup.
  /// [digitsPinCode] The digits PIN for the number
  /// [password] The password for the number
  /// [backupData] The backup data for the number
  ///
  /// return Request The response object containing the HTTP response code, error message, and message ID if the

  Future<Request> accountMigrationRegister(
      {required String digitsPinCode,
      required String password,
      required String backupData}) async {
    Request res = await _accountService.accountMigrationRegister(
        digitsPinCode, password, backupData);
    return res;
  }

  /// Get business details
  /// [scope] The scope of the business details (e.g. ["name", "email"]) (optional)
  ///
  /// return Request The response object containing the HTTP response code, error message, and message ID if the
  Future<Request> getBusinessProfile({List<String>? scope}) async {
    Request res = await _businessService.getBusinessProfile(scope);
    return res;
  }

  /// Update business details
  /// [about] The about section of the business profile (optional)
  /// [address] The address section of the business profile (optional)
  /// [description] The description section of the business profile (optional)
  /// [industry] The industry of the business profile (optional)
  /// [email] The email section of the business profile (optional)
  /// [websites] The websites section of the business profile (optional)
  /// [profilePictureHandle] The profile picture handle of the business profile (optional)
  ///
  /// return Request The response object containing the HTTP response code, error message, and message ID if the
  Future<Request> updateBusinessProfile({
    String? about,
    String? address,
    String? description,
    String? industry,
    String? email,
    List<String>? websites,
    String? profilePictureHandle,
  }) async {
    Request res = await _businessService.updateBusinessProfile(about, address,
        description, industry, email, websites, profilePictureHandle);
    return res;
  }

  /// Send a verification code to the specified phone number
  /// [codeMethod] The code method, default is SMS (e.g., "SMS", "VOICE")
  /// [language] The language code for the verification code, default is en (optional)
  ///
  /// return Request The response object containing the HTTP response code, error message, and message ID if the
  Future<Request> requestCode({String? codeMethod, String? language}) async {
    Request res = await _phoneService.requestCode(codeMethod, language);
    return res;
  }

  /// Verify the verification code sent to the specified phone number
  /// [code] The verification code received from the phone number
  ///
  /// return Request The response object containing the HTTP response code, error message, and message ID if the
  Future<Request> verifyCode({int? code}) async {
    Request res = await _phoneService.verifyCode(code!);
    return res;
  }

  /// Register your business phone number
  /// [pin] The PIN for the new phone number
  /// [enableLocalStorage] Enable local storage for the new phone number (optional)
  /// [dataLocalizationRegion] The data localization region for the new phone number (optional)
  ///
  /// return Request The response object containing the HTTP response code, error message, and message ID if the
  Future<Request> register(
      {required int pin,
      bool? enableLocalStorage,
      String? dataLocalizationRegion}) async {
    Request res = await _registrationService.register(
        pin, enableLocalStorage, dataLocalizationRegion);
    return res;
  }

  /// De-register your business phone number
  ///
  /// return Request The response object containing the HTTP response code, error message, and message ID if the
  Future<Request> deRegister() async {
    Request res = await _registrationService.deRegister();
    return res;
  }

  /// Send a replay message to the message
  ///
  /// [phoneNumber] The phone number with country code to which the replay message will be sent
  /// [messageId] The message ID of the message to be replayed
  /// [replay] The replay message content
  ///
  /// return Request The response object containing the HTTP response code, error message, and message ID if the
  Future<Request> replay(
      {required phoneNumber,
      required String messageId,
      required Map<String, dynamic> replay}) async {
    Request res = await _replayService.replay(phoneNumber, messageId, replay);
    return res;
  }

  /// Send a template message to the specified phone number
  /// [phoneNumber] The phone number with country code to which the template message will be sent
  /// [template] The template ID of the template message
  /// [language] The language code for the template message
  /// [placeholder] The placeholder values for the template message (optional)
  ///
  /// return Request The response object containing the HTTP response code, error message, and message ID if the
  Future<Request> sendTemplate(
      {required phoneNumber,
      required String template,
      required String language,
      List<Map<String, dynamic>>? placeholder}) async {
    Request res = await _templateService.sendTemplate(
        phoneNumber, template, language, placeholder);
    return res;
  }

  /// Two Step Verification for phone number registration
  /// [pin] The PIN for the two-step verification
  ///
  /// return Request The response object containing the HTTP response code, error message, and message ID if the
  Future<Request> twoStepVerification({required int pin}) async {
    Request res = await _registrationService.twoStepVerification(pin);
    return res;
  }

  /// Send your own Business API request
  /// [path] The path of the API endpoint (e.g., "/messages")
  /// [payload] The payload of the API request (e.g., {"message": "Hello, World"})
  ///
  /// return Request The response object containing the HTTP response code, error message, and message ID if the
  Future<Request> sendCustomRequest(
      {required String path, required Map<String, dynamic> payload}) async {
    Request res = await _customService.sendCustomRequest(path, payload);
    return res;
  }

  /// Generate direct whatsapp link
  /// [phoneNumber] The phone number with country code to which the whatsapp link will be generated
  /// [message] The message content for the whatsapp link (optional)
  /// [shortLink] Generate a shortened link (optional)
  /// [bold] Add bold formatting to the message (optional)
  /// [italic] Add italic formatting to the message (optional)
  /// [strikethrough] Add strikethrough formatting to the message (optional)
  /// [monospace] Add monospace formatting to the message (optional)
  ///
  /// Return  The generated whatsapp link
  String getLink({
    required String phoneNumber,
    String? message,
    bool? shortLink = false,
    List<String>? bold,
    List<String>? italic,
    List<String>? strikethrough,
    List<String>? monospace,
  }) {
    String res = _textService.getLink(phoneNumber, message, shortLink, bold,
        italic, strikethrough, monospace);
    return res;
  }
}
