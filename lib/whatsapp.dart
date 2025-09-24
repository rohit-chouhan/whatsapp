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
import 'package:whatsapp/services/phone.dart';
import 'package:whatsapp/services/reaction.dart';
import 'package:whatsapp/services/registration.dart';
import 'package:whatsapp/services/reply.dart';
import 'package:whatsapp/services/sticker.dart';
import 'package:whatsapp/services/template.dart';
import 'package:whatsapp/services/text.dart';
import 'package:whatsapp/services/video.dart';
import 'package:whatsapp/services/flow.dart';
import 'package:whatsapp/services/catalog.dart';
import 'package:whatsapp/services/status.dart';
import 'package:whatsapp/utils/request.dart';
import 'package:whatsapp/utils/response/blocked_users_response.dart';
import 'package:whatsapp/utils/response/media_delete_response.dart';
import 'package:whatsapp/utils/response/media_get_response.dart';
import 'package:whatsapp/utils/response/media_upload_response.dart';
import 'package:whatsapp/utils/response/whatsapp_response.dart';

class WhatsApp {
  final String _accessToken;
  final String _fromNumberId;
  late final Request _request;
  late final TextService _textService;
  late final ImageService _imageService;
  late final AudioService _audioService;
  late final DocumentService _documentService;
  late final VideoService _videoService;
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
  late final ReplyService _replyService;
  late final TemplateService _templateService;
  late final CustomService _customService;
  late final FlowService _flowService;
  late final CatalogService _catalogService;
  late final StatusService _statusService;

  WhatsApp(this._accessToken, this._fromNumberId) {
    _request = Request();
    _textService = TextService(_accessToken, _fromNumberId, _request);
    _imageService = ImageService(_accessToken, _fromNumberId, _request);
    _audioService = AudioService(_accessToken, _fromNumberId, _request);
    _documentService = DocumentService(_accessToken, _fromNumberId, _request);
    _videoService = VideoService(_accessToken, _fromNumberId, _request);
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
    _replyService = ReplyService(_accessToken, _fromNumberId, _request);
    _templateService = TemplateService(_accessToken, _fromNumberId, _request);
    _customService = CustomService(_accessToken, _fromNumberId, _request);
    _flowService = FlowService(_accessToken, _fromNumberId, _request);
    _catalogService = CatalogService(_accessToken, _fromNumberId, _request);
    _statusService = StatusService(_accessToken, _fromNumberId, _request);
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
  Future<WhatsAppResponse> sendMessage(
      {required String phoneNumber,
      required String text,
      bool previewUrl = false}) async {
    WhatsAppResponse res =
        await _textService.sendMessage(phoneNumber, text, previewUrl);
    return res;
  }

  /// Send a message with an image attachment to the specified phone number
  /// [phoneNumber] The phone number with country code to which the message will be sent
  /// [mediaId] The uploaded image file id to be sent
  /// [caption] The caption for the image (optional)
  ///
  /// return Request The response object containing the HTTP response code, error message, and message ID if the
  Future<WhatsAppResponse> sendImageById(
      {required String phoneNumber,
      required String mediaId,
      String? caption}) async {
    WhatsAppResponse res =
        await _imageService.sendImageById(phoneNumber, mediaId, caption);
    return res;
  }

  /// Send a message with an image attachment to the specified phone number
  /// [phoneNumber] The phone number with country code to which the message will be sent
  /// [imageUrl] The direct URL of the image to be sent
  /// [caption] The caption for the image (optional)
  ///
  /// return Request The response object containing the HTTP response code, error message, and message ID if the
  Future<WhatsAppResponse> sendImageByUrl(
      {required String phoneNumber,
      required String imageUrl,
      String? caption}) async {
    WhatsAppResponse res =
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
  /// [messageId] The message ID to be marked as read
  ///
  /// return Request The response object containing the HTTP response code, error message, and message ID if the
  Future<Request> markAsRead({required String messageId}) async {
    Request res = await _statusService.markAsRead(messageId);
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

  /// Send Interactive Reply Button to the specified phone number
  /// [phoneNumber] The phone number with country code to which the interactive reply button will be sent
  /// [headerInteractive] The header text for the interactive reply button
  /// [bodyText] The body text for the interactive reply button
  /// [footerText] The footer text for the interactive reply button
  /// [interactiveReplyButtons] The interactive reply buttons to be sent
  ///
  /// return Request The response object containing the HTTP response code, error message, and message ID if the

  Future<Request> sendInteractiveReplyButton(
      {required String phoneNumber,
      required Map<String, dynamic> headerInteractive,
      required String bodyText,
      required String footerText,
      required List<Map<String, dynamic>> interactiveReplyButtons}) async {
    Request res = await _interactiveService.sendInteractiveReplyButtons(
        phoneNumber,
        headerInteractive,
        bodyText,
        footerText,
        interactiveReplyButtons);
    return res;
  }

  /// Send Interactive Lists to the specified phone number
  /// [phoneNumber] The phone number with country code to which the interactive reply button will be sent
  /// [headerText] The header text for the interactive reply button (optional)
  /// [bodyText] The body text for the interactive reply button
  /// [footerText] The footer text for the interactive reply button (optional)
  /// [buttonText] The text for the interactive reply button (optional)
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
  /// [phoneNumber] The phone number with country code to which the interactive reply button will be sent
  /// [headerText] The header text for the interactive reply button (optional)
  /// [bodyText] The body text for the interactive reply button
  /// [footerText] The footer text for the interactive reply button (optional)
  /// [buttonText] The text for the interactive reply button (optional)
  /// [actionUrl] Url to open when the interactive reply button is clicked
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

  /// Upload media file to business server by Url
  /// [fileUrl] Public file url
  /// [fileType] The type of the file (e.g., "image/jpeg", "video/mp4", "document/pdf")
  ///
  /// return String The URL of the uploaded media file
  Future<MediaUploadResponse> uploadMediaFileByUrl(
      {required String fileUrl, required String fileType}) async {
    MediaUploadResponse res =
        await _mediaService.uploadMediaFileByUrl(fileUrl, fileType);
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

  Future<MediaGetResponse> getMedia({required String mediaId}) async {
    MediaGetResponse res = await _mediaService.getMedia(mediaId);
    return res;
  }

  /// Delete media file from business server by media ID
  /// [mediaId] The media ID of the uploaded file
  ///
  /// return Request The response object containing the HTTP response code, error message, and message ID if the
  ///
  Future<MediaDeleteResponse> deleteMedia({required String mediaId}) async {
    MediaDeleteResponse res = await _mediaService.deleteMedia(mediaId);
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

  /// Send a reply message to the message
  ///
  /// [phoneNumber] The phone number with country code to which the reply message will be sent
  /// [messageId] The message ID of the message to be replied to
  /// [reply] The reply message content
  ///
  /// return Request The response object containing the HTTP response code, error message, and message ID if the
  Future<Request> reply(
      {required String phoneNumber,
      required String messageId,
      required Map<String, dynamic> reply}) async {
    Request res = await _replyService.reply(phoneNumber, messageId, reply);
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
      {required String phoneNumber,
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

  /// Send a Flow message to the specified phone number
  /// [phoneNumber] The phone number with country code to which the flow message will be sent
  /// [flowToken] The flow token for the flow message
  /// [flowId] The flow ID for the flow message
  /// [flowCta] The call-to-action text for the flow message
  /// [flowActionPayload] The payload for the flow action
  /// [headerText] The header text for the flow message (optional)
  /// [bodyText] The body text for the flow message (optional)
  /// [footerText] The footer text for the flow message (optional)
  ///
  /// return Request The response object containing the HTTP response code, error message, and message ID if the
  Future<Request> sendFlowMessage({
    required String phoneNumber,
    String flowToken = 'unused',
    required String flowId,
    required String flowCta,
    required Map<String, dynamic> flowActionPayload,
    String? headerText,
    String? bodyText,
    String? footerText,
  }) async {
    Request res = await _flowService.sendFlowMessage(
      phoneNumber: phoneNumber,
      flowToken: flowToken,
      flowId: flowId,
      flowCta: flowCta,
      flowActionPayload: flowActionPayload,
      headerText: headerText,
      bodyText: bodyText,
      footerText: footerText,
    );
    return res;
  }

  /// Send a catalog message to the specified phone number
  /// [phoneNumber] The phone number with country code to which the catalog message will be sent
  /// [catalogId] The catalog ID for the catalog message
  /// [productRetailerId] The product retailer ID for the catalog message
  /// [headerText] The header text for the catalog message (optional)
  /// [bodyText] The body text for the catalog message (optional)
  /// [footerText] The footer text for the catalog message (optional)
  ///
  /// return Request The response object containing the HTTP response code, error message, and message ID if the
  Future<Request> sendCatalogMessage({
    required String phoneNumber,
    required String productRetailerId,
    String? headerText,
    String? bodyText,
    String? footerText,
  }) async {
    Request res = await _catalogService.sendCatalogMessage(
      phoneNumber: phoneNumber,
      productRetailerId: productRetailerId,
      headerText: headerText,
      bodyText: bodyText,
      footerText: footerText,
    );
    return res;
  }

  /// Send a product message to the specified phone number
  /// [phoneNumber] The phone number with country code to which the product message will be sent
  /// [catalogId] The catalog ID for the product message
  /// [productRetailerId] The product retailer ID for the product message
  ///
  /// return Request The response object containing the HTTP response code, error message, and message ID if the
  Future<Request> sendProductMessage({
    required String phoneNumber,
    required String catalogId,
    required String productRetailerId,
    String? bodyText,
    String? footerText,
  }) async {
    Request res = await _catalogService.sendProductMessage(
        phoneNumber: phoneNumber,
        catalogId: catalogId,
        productRetailerId: productRetailerId,
        bodyText: bodyText!,
        footerText: footerText!);
    return res;
  }

  /// Get message status by message ID
  /// [messageId] The message ID to get status for
  ///
  /// return Request The response object containing the HTTP response code, error message, and message status
  // Future<Request> getMessageStatus({required String messageId}) async {
  //   Request res = await _statusService.getMessageStatus(messageId);
  //   return res;
  // }

  /// Mark message as delivered
  /// [messageId] The message ID to mark as delivered
  ///
  /// return Request The response object containing the HTTP response code, error message, and message ID if the
  // Future<Request> markAsDelivered({required String messageId}) async {
  //   Request res = await _statusService.markAsDelivered(messageId);
  //   return res;
  // }

  /// Generate direct whatsapp link
  /// [phoneNumber] The phone number with country code to which the whatsapp link will be generated
  /// [message] The message content for the whatsapp link (optional)
  /// [shortLink] Generate a shortened link (optional)
  /// [bold] Add bold formatting to the message (optional)
  /// [italic] Add italic formatting to the message (optional)
  /// [strikethrough] Add strikethrough formatting to the message (optional)
  /// [monospace] Add monospace formatting to the message (optional)
  ///
  /// Return The generated whatsapp message link
  String getLink({
    required String phoneNumber,
    String? message,
    bool? shortLink = false,
    List<String>? bold,
    List<String>? italic,
    List<String>? strikethrough,
    List<String>? monospace,
  }) {
    return _textService.getLink(phoneNumber, message, shortLink, bold, italic,
        strikethrough, monospace);
  }

  /// Send Typing Indicator
  /// [messageId] The message ID to which the typing indicator is related
  Future<Request> sendTypingIndicator({
    required String messageId,
  }) async {
    Request res = await _statusService.sendTypingIndicator(messageId);
    return res;
  }

  /// Block users by their phone numbers or message id
  /// [users] List of phone numbers with country code to be blocked
  Future<Request> blockUsers({required List<String>? users}) async {
    Request res = await _accountService.blockUsers(users);
    return res;
  }

  /// Unblock users by their phone numbers or message id
  /// [users] List of phone numbers with country code to be unblocked
  Future<Request> unblockUsers({required List<String>? users}) async {
    Request res = await _accountService.unblockUsers(users);
    return res;
  }

  /// Get the list of blocked users
  /// [limit] The maximum number of blocked users to return (optional)
  /// [before] A cursor for pagination to get the previous page of results (optional)
  /// [after] A cursor for pagination to get the next page of results (optional)
  Future<BlockedUsersResponse> getBlockedUsers(
      {int? limit, String? before, String? after}) async {
    BlockedUsersResponse res =
        (await _accountService.getBlockedUsers(limit, before, after));
    return res;
  }
}
