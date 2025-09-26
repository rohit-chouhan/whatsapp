library;

/// A Flutter package for integrating with the WhatsApp Business Cloud API.
/// Provides convenient methods for sending messages, media, and managing business accounts.

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
import 'package:whatsapp/services/resumable.dart';
import 'package:whatsapp/services/sticker.dart';
import 'package:whatsapp/services/template.dart';
import 'package:whatsapp/services/text.dart';
import 'package:whatsapp/services/video.dart';
import 'package:whatsapp/services/flow.dart';
import 'package:whatsapp/services/catalog.dart';
import 'package:whatsapp/services/status.dart';
import 'package:whatsapp/utils/request.dart';
import 'package:whatsapp/utils/response/whatsapp_blocked_users_response.dart';
import 'package:whatsapp/utils/response/whatsapp_get_blocked_users_response.dart';
import 'package:whatsapp/utils/response/whatsapp_media_delete_response.dart';
import 'package:whatsapp/utils/response/whatsapp_media_get_response.dart';
import 'package:whatsapp/utils/response/whatsapp_media_upload_response.dart';
import 'package:whatsapp/utils/response/whatsapp_business_account_response.dart';
import 'package:whatsapp/utils/response/whatsapp_response.dart';
import 'package:whatsapp/utils/response/whatsapp_resumable_upload_response.dart';
import 'package:whatsapp/utils/response/whatsapp_success_response.dart';

/// High-level client for WhatsApp Cloud API.
///
/// This class aggregates all feature-specific services and exposes
/// convenient methods while preserving each service's parameters and
/// behavior. It does not alter service method signatures; it only
/// orchestrates calls and returns parsed response objects.
class WhatsApp {
  final String _accessToken;
  final String _fromNumberId;
  late final Request _request;
  TextService? _textService;
  ImageService? _imageService;
  AudioService? _audioService;
  DocumentService? _documentService;
  VideoService? _videoService;
  StickerService? _stickerService;
  ReactionService? _reactionService;
  LocationService? _locationService;
  InteractiveService? _interactiveService;
  ContactService? _contactService;
  MediaService? _mediaService;
  AccountService? _accountService;
  BusinessService? _businessService;
  PhoneService? _phoneService;
  RegistrationService? _registrationService;
  ReplyService? _replyService;
  TemplateService? _templateService;
  CustomService? _customService;
  FlowService? _flowService;
  CatalogService? _catalogService;
  StatusService? _statusService;
  ResumableService? _resumableService;

  /// Create a new WhatsApp client.
  ///
  /// [accessToken] is the Cloud API bearer token.
  /// [fromNumberId] is the sender phone number ID path prefix used in API URLs.
  /// [request] optional Request instance for dependency injection (used for testing).
  WhatsApp(this._accessToken, this._fromNumberId, [Request? request]) {
    _request = request ?? Request();
  }

  /// Set a custom Facebook Graph API version (e.g. "v19.0").
  ///
  /// [version] Graph API version string like "v19.0".
  void setVersion(String version) {
    _request.setVersion(version);
  }

  TextService get _getTextService =>
      _textService ??= TextService(_accessToken, _fromNumberId, _request);
  ImageService get _getImageService =>
      _imageService ??= ImageService(_accessToken, _fromNumberId, _request);
  AudioService get _getAudioService =>
      _audioService ??= AudioService(_accessToken, _fromNumberId, _request);
  DocumentService get _getDocumentService => _documentService ??=
      DocumentService(_accessToken, _fromNumberId, _request);
  VideoService get _getVideoService =>
      _videoService ??= VideoService(_accessToken, _fromNumberId, _request);
  StickerService get _getStickerService =>
      _stickerService ??= StickerService(_accessToken, _fromNumberId, _request);
  ReactionService get _getReactionService => _reactionService ??=
      ReactionService(_accessToken, _fromNumberId, _request);
  LocationService get _getLocationService => _locationService ??=
      LocationService(_accessToken, _fromNumberId, _request);
  InteractiveService get _getInteractiveService => _interactiveService ??=
      InteractiveService(_accessToken, _fromNumberId, _request);
  ContactService get _getContactService =>
      _contactService ??= ContactService(_accessToken, _fromNumberId, _request);
  MediaService get _getMediaService =>
      _mediaService ??= MediaService(_accessToken, _fromNumberId, _request);
  AccountService get _getAccountService =>
      _accountService ??= AccountService(_accessToken, _fromNumberId, _request);
  BusinessService get _getBusinessService => _businessService ??=
      BusinessService(_accessToken, _fromNumberId, _request);
  PhoneService get _getPhoneService =>
      _phoneService ??= PhoneService(_accessToken, _fromNumberId, _request);
  RegistrationService get _getRegistrationService => _registrationService ??=
      RegistrationService(_accessToken, _fromNumberId, _request);
  ReplyService get _getReplyService =>
      _replyService ??= ReplyService(_accessToken, _fromNumberId, _request);
  TemplateService get _getTemplateService => _templateService ??=
      TemplateService(_accessToken, _fromNumberId, _request);
  CustomService get _getCustomService =>
      _customService ??= CustomService(_accessToken, _fromNumberId, _request);
  FlowService get _getFlowService =>
      _flowService ??= FlowService(_accessToken, _fromNumberId, _request);
  CatalogService get _getCatalogService =>
      _catalogService ??= CatalogService(_accessToken, _fromNumberId, _request);
  StatusService get _getStatusService =>
      _statusService ??= StatusService(_accessToken, _fromNumberId, _request);
  ResumableService get _getResumableService => _resumableService ??=
      ResumableService(_accessToken, _fromNumberId, _request);

  /// Send a message to the specified phone number
  /// [phoneNumber] The phone number with country code to which the message will be sent
  /// [text] The text message to be sent
  /// [previewUrl] Whether to include a preview URL in the message (default: false)
  ///
  /// Returns a [WhatsAppResponse] containing the contact ID, message ID, and full response if the message was sent successfully.
  Future<WhatsAppResponse> sendMessage(
      {required String phoneNumber,
      required String text,
      bool previewUrl = false}) async {
    return await _getTextService.sendMessage(phoneNumber, text, previewUrl);
  }

  /// Send a message with an image attachment to the specified phone number
  /// [phoneNumber] The phone number with country code to which the message will be sent
  /// [imageId] The uploaded image file id to be sent
  /// [caption] The caption for the image (optional)
  ///
  /// Returns a [WhatsAppResponse] containing the contact ID, message ID, and full response if the image was sent successfully.
  Future<WhatsAppResponse> sendImageById(
      {required String phoneNumber,
      required String imageId,
      String? caption}) async {
    return await _getImageService.sendImageById(phoneNumber, imageId, caption);
  }

  /// Send a message with an image attachment to the specified phone number
  /// [phoneNumber] The phone number with country code to which the message will be sent
  /// [imageUrl] The direct URL of the image to be sent
  /// [caption] The caption for the image (optional)
  ///
  /// Returns a [WhatsAppResponse] containing the contact ID, message ID, and full response if the image was sent successfully.
  Future<WhatsAppResponse> sendImageByUrl(
      {required String phoneNumber,
      required String imageUrl,
      String? caption}) async {
    return await _getImageService.sendImageByUrl(
        phoneNumber, imageUrl, caption);
  }

  /// Send a message with an audio attachment to the specified phone number using Media Id
  /// [phoneNumber] The phone number with country code to which the message will be sent
  /// [audioId] The uploaded audio file id to be sent
  ///
  /// Returns a [WhatsAppResponse] containing the contact ID, message ID, and full response if the audio was sent successfully.
  Future<WhatsAppResponse> sendAudioById(
      {required String phoneNumber, required String audioId}) async {
    return await _getAudioService.sendAudioById(phoneNumber, audioId);
  }

  /// Send a message with an audio attachment to the specified phone number using URL
  /// [phoneNumber] The phone number with country code to which the message will be sent
  /// [audioUrl] The direct URL of the audio file to be sent
  ///
  /// Returns a [WhatsAppResponse] containing the contact ID, message ID, and full response if the audio was sent successfully.
  Future<WhatsAppResponse> sendAudioByUrl(
      {required String phoneNumber, required String audioUrl}) async {
    return await _getAudioService.sendAudioByUrl(phoneNumber, audioUrl);
  }

  /// Send a message with a document attachment to the specified phone number using Media Id
  /// [phoneNumber] The phone number with country code to which the message will be sent
  /// [documentId] The uploaded document file id to be sent
  /// [caption] The caption for the document (optional)
  /// [filename] The filename for the document (optional)
  ///
  /// Returns a [WhatsAppResponse] containing the contact ID, message ID, and full response if the document was sent successfully.
  Future<WhatsAppResponse> sendDocumentById(
      {required String phoneNumber,
      required String documentId,
      String? caption,
      String? filename}) async {
    return await _getDocumentService.sendDocumentById(
        phoneNumber, documentId, caption, filename);
  }

  /// Send a message with a document attachment to the specified phone number using URL
  /// [phoneNumber] The phone number with country code to which the message will be sent
  /// [documentUrl] The direct URL of the document file to be sent
  /// [caption] The caption for the document (optional)
  /// [filename] The filename for the document (optional)
  ///
  /// Returns a [WhatsAppResponse] containing the contact ID, message ID, and full response if the document was sent successfully.
  Future<WhatsAppResponse> sendDocumentByUrl(
      {required String phoneNumber,
      required String documentUrl,
      String? caption,
      String? filename}) async {
    return await _getDocumentService.sendDocumentByUrl(
        phoneNumber, documentUrl, caption, filename);
  }

  /// Send a message with a video attachment to the specified phone number
  /// [phoneNumber] The phone number with country code to which the message will be sent
  /// [videoId] The uploaded video file id to be sent
  /// [caption] The caption for the video (optional)
  ///
  /// Returns a [WhatsAppResponse] containing the contact ID, message ID, and full response if the video was sent successfully.
  Future<WhatsAppResponse> sendVideoById(
      {required String phoneNumber,
      required String videoId,
      String? caption}) async {
    return await _getVideoService.sendVideoById(phoneNumber, videoId, caption);
  }

  /// Send a message with a video attachment to the specified phone number
  /// [phoneNumber] The phone number with country code to which the message will be sent
  /// [videoUrl] The direct URL of the video to be sent
  /// [caption] The caption for the video (optional)
  ///
  /// Returns a [WhatsAppResponse] containing the contact ID, message ID, and full response if the video was sent successfully.
  Future<WhatsAppResponse> sendVideoByUrl(
      {required String phoneNumber,
      required String videoUrl,
      String? caption}) async {
    return await _getVideoService.sendVideoByUrl(
        phoneNumber, videoUrl, caption);
  }

  /// Send a message with a sticker attachment to the specified phone number
  /// [phoneNumber] The phone number with country code to which the message will be sent
  /// [stickerUrl] The direct URL of the sticker (webp) to be sent
  ///
  /// Returns a [WhatsAppResponse] containing the contact ID, message ID, and full response if the video was sent successfully.
  Future<WhatsAppResponse> sendStickerByUrl({
    required String phoneNumber,
    required String stickerUrl,
  }) async {
    return await _getStickerService.sendStickerByUrl(phoneNumber, stickerUrl);
  }

  /// Mark the message as read (seen)
  /// [messageId] The message ID to be marked as read
  ///
  /// Returns a [WhatsAppSuccessResponse] indicating whether the message was marked as read successfully.
  Future<WhatsAppSuccessResponse> markAsRead(
      {required String messageId}) async {
    return await _getStatusService.markAsRead(messageId);
  }

  /// Send a sticker to the specified phone number
  /// [phoneNumber] The phone number with country code to which the sticker will be sent
  /// [stickerId] The sticker ID to be sent
  ///
  /// Returns a [WhatsAppResponse] containing the contact ID, message ID, and full response if the sticker was sent successfully.
  Future<WhatsAppResponse> sendSticker(
      {required String phoneNumber, required String stickerId}) async {
    return await _getStickerService.sendStickerById(phoneNumber, stickerId);
  }

  /// Send a reaction to the specified message
  /// [phoneNumber] The phone number with country code to which the reaction will be sent
  /// [messageId] The message ID to which the reaction will be sent
  /// [emoji] The emoji to be used for the reaction
  ///
  /// Returns a [WhatsAppResponse] containing the contact ID, message ID, and full response if the reaction was sent successfully.
  Future<WhatsAppResponse> sendReaction(
      {required String phoneNumber,
      required String messageId,
      required String emoji}) async {
    return await _getReactionService.sendReaction(
        phoneNumber, messageId, emoji);
  }

  /// Request a location from the specified phone number
  /// [phoneNumber] The phone number with country code to which the location will be requested
  /// [text] The text message to accompany the location request
  ///
  /// Returns a [WhatsAppResponse] containing the contact ID, message ID, and full response if the location request was sent successfully.
  Future<WhatsAppResponse> sendLocationRequest(
      {required String phoneNumber, required String text}) async {
    return await _getLocationService.sendLocationRequest(phoneNumber, text);
  }

  /// Send location to specified phone number
  /// [phoneNumber] The phone number with country code to which the location will be sent
  /// [latitude] The latitude of the location
  /// [longitude] The longitude of the location
  /// [name] The name of the location (optional)
  /// [address] The address of the location (optional)
  ///
  /// Returns a [WhatsAppResponse] containing the contact ID, message ID, and full response if the location was sent successfully.

  Future<WhatsAppResponse> sendLocation(
      {required String phoneNumber,
      required double latitude,
      required double longitude,
      String? name,
      String? address}) async {
    return await _getLocationService.sendLocation(
        phoneNumber, latitude, longitude, name, address);
  }

  /// Send Interactive Reply Button to the specified phone number
  /// [phoneNumber] The phone number with country code to which the interactive reply button will be sent
  /// [headerInteractive] The header text for the interactive reply button
  /// [bodyText] The body text for the interactive reply button
  /// [footerText] The footer text for the interactive reply button
  /// [interactiveReplyButtons] The interactive reply buttons to be sent
  ///
  /// Returns a [WhatsAppResponse] containing the contact ID, message ID, and full response if the interactive reply button was sent successfully.

  Future<WhatsAppResponse> sendInteractiveReplyButton(
      {required String phoneNumber,
      required Map<String, dynamic> headerInteractive,
      required String bodyText,
      required String footerText,
      required List<Map<String, dynamic>> interactiveReplyButtons}) async {
    return await _getInteractiveService.sendInteractiveReplyButtons(phoneNumber,
        headerInteractive, bodyText, footerText, interactiveReplyButtons);
  }

  /// Send Interactive Lists to the specified phone number
  /// [phoneNumber] The phone number with country code to which the interactive list will be sent
  /// [headerText] The header text for the interactive list (optional)
  /// [bodyText] The body text for the interactive list
  /// [footerText] The footer text for the interactive list (optional)
  /// [buttonText] The text for the interactive list button
  /// [sections] Sections of interactive lists to be sent
  ///
  /// Returns a [WhatsAppResponse] containing the contact ID, message ID, and full response if the interactive list was sent successfully.

  Future<WhatsAppResponse> sendInteractiveLists(
      {required String phoneNumber,
      String? headerText,
      required String bodyText,
      String? footerText,
      required String buttonText,
      required List<Map<String, dynamic>> sections}) async {
    return await _getInteractiveService.sendInteractiveLists(
        phoneNumber, headerText, bodyText, footerText, buttonText, sections);
  }

  /// Send Interactive Call-To-Action Button to the specified phone number
  /// [phoneNumber] The phone number with country code to which the call-to-action button will be sent
  /// [headerText] The header text for the call-to-action button (optional)
  /// [bodyText] The body text for the call-to-action button
  /// [footerText] The footer text for the call-to-action button (optional)
  /// [buttonText] The text for the call-to-action button
  /// [actionUrl] URL to open when the call-to-action button is clicked
  ///
  /// Returns a [WhatsAppResponse] containing the contact ID, message ID, and full response if the call-to-action button was sent successfully.

  Future<WhatsAppResponse> sendCallToActionButton(
      {required String phoneNumber,
      String? headerText,
      required String bodyText,
      String? footerText,
      required String buttonText,
      required String actionUrl}) async {
    return await _getInteractiveService.sendCallToActionButton(
        phoneNumber, headerText, bodyText, footerText, buttonText, actionUrl);
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
  /// Returns a [WhatsAppResponse] containing the contact ID, message ID, and full response if the contact details were sent successfully.

  Future<WhatsAppResponse> sendContactDetails(
      {required String phoneNumber,
      String? dateOfBirth,
      List<Map<dynamic, dynamic>>? addresses,
      List<Map<dynamic, dynamic>>? emails,
      required Map<dynamic, dynamic> person,
      Map<dynamic, dynamic>? organization,
      required List<Map<dynamic, dynamic>> phones,
      List<Map<dynamic, dynamic>>? urls}) async {
    return await _getContactService.sendContactDetails(phoneNumber, dateOfBirth,
        addresses, emails, person, organization, phones, urls);
  }

  /// Upload media file to business server
  /// [file] The file to be uploaded (`File` on native, `List<int>` on web)
  /// [fileType] The type of the file (e.g., "image/jpeg", "video/mp4", "document/pdf")
  ///
  /// Returns a [WhatsAppMediaUploadResponse] object with the media ID and response details if the upload was successful.
  Future<WhatsAppMediaUploadResponse> uploadMediaFile(
      {required dynamic file, required String fileType}) async {
    return await _getMediaService.uploadMediaFile(file, fileType);
  }

  /// Upload media file to business server by URL
  /// [fileUrl] Public file URL
  /// [fileType] The type of the file (e.g., "image/jpeg", "video/mp4", "document/pdf")
  ///
  /// Returns a [WhatsAppMediaUploadResponse] containing the media ID if the upload was successful.
  Future<WhatsAppMediaUploadResponse> uploadMediaFileByUrl(
      {required String fileUrl, required String fileType}) async {
    return await _getMediaService.uploadMediaFileByUrl(fileUrl, fileType);
  }

  /// Get media URL and information by media ID
  /// [mediaId] The media ID of the uploaded file
  ///
  /// Returns a [WhatsAppMediaGetResponse] containing the media URL, MIME type, file size, and SHA-256 hash.
  Future<WhatsAppMediaGetResponse> getMedia({required String mediaId}) async {
    return await _getMediaService.getMedia(mediaId);
  }

  /// Delete media file from business server by media ID
  /// [mediaId] The media ID of the uploaded file
  ///
  /// Returns a [WhatsAppMediaDeleteResponse] indicating whether the media was deleted successfully.
  Future<WhatsAppMediaDeleteResponse> deleteMedia(
      {required String mediaId}) async {
    return await _getMediaService.deleteMedia(mediaId);
  }

  /// Register the number for use with Cloud API after you have performed your backup.
  /// [digitsPinCode] The digits PIN for the number
  /// [password] The password for the number
  /// [backupData] The backup data for the number
  ///
  /// Returns a [WhatsAppSuccessResponse] indicating whether the account migration was registered successfully.
  Future<WhatsAppSuccessResponse> accountMigrationRegister(
      {required String digitsPinCode,
      required String password,
      required String backupData}) async {
    return await _getAccountService.accountMigrationRegister(
        digitsPinCode, password, backupData);
  }

  /// Get business profile details
  /// [scope] The scope of the business details (e.g. `["name", "email"]`) (optional)
  ///
  /// Returns a [WhatsAppBusinessAccountResponse] containing the business profile details.
  Future<WhatsAppBusinessAccountResponse> getBusinessProfile(
      {List<String>? scope}) async {
    return await _getBusinessService.getBusinessProfile(scope);
  }

  /// Update business profile details
  /// [about] The about section of the business profile (optional)
  /// [address] The address section of the business profile (optional)
  /// [description] The description section of the business profile (optional)
  /// [industry] The industry of the business profile (optional)
  /// [email] The email section of the business profile (optional)
  /// [websites] The websites section of the business profile (optional)
  /// [profilePictureHandle] The profile picture handle of the business profile (optional)
  ///
  /// Returns a [WhatsAppSuccessResponse] indicating whether the business profile was updated successfully.
  Future<WhatsAppSuccessResponse> updateBusinessProfile({
    String? about,
    String? address,
    String? description,
    String? industry,
    String? email,
    List<String>? websites,
    String? profilePictureHandle,
  }) async {
    return await _getBusinessService.updateBusinessProfile(about, address,
        description, industry, email, websites, profilePictureHandle);
  }

  /// Send a verification code to the specified phone number
  /// [codeMethod] The code method, default is SMS (e.g., "SMS", "VOICE")
  /// [language] The language code for the verification code, default is en (optional)
  ///
  /// Returns a [WhatsAppResponse] containing the response details if the code request was successful.
  Future<WhatsAppResponse> requestCode(
      {String? codeMethod, String? language}) async {
    return await _getPhoneService.requestCode(codeMethod, language);
  }

  /// Verify the verification code sent to the specified phone number
  /// [code] The verification code received from the phone number
  ///
  /// Returns a [WhatsAppResponse] containing the response details if the code verification was successful.
  Future<WhatsAppResponse> verifyCode({required int code}) async {
    return await _getPhoneService.verifyCode(code);
  }

  /// Register your business phone number
  /// [pin] The PIN for the new phone number
  /// [enableLocalStorage] Enable local storage for the new phone number (optional)
  /// [dataLocalizationRegion] The data localization region for the new phone number (optional)
  ///
  /// Returns a [WhatsAppSuccessResponse] indicating whether the phone number was registered successfully.
  Future<WhatsAppSuccessResponse> register(
      {required int pin,
      bool? enableLocalStorage,
      String? dataLocalizationRegion}) async {
    return await _getRegistrationService.register(
        pin, enableLocalStorage, dataLocalizationRegion);
  }

  /// De-register your business phone number
  ///
  /// Returns a [WhatsAppSuccessResponse] indicating whether the phone number was deregistered successfully.
  Future<WhatsAppSuccessResponse> deRegister() async {
    return await _getRegistrationService.deRegister();
  }

  /// Send a reply message to the message
  ///
  /// [phoneNumber] The phone number with country code to which the reply message will be sent
  /// [messageId] The message ID of the message to be replied to
  /// [reply] The reply message content
  ///
  /// Returns a [WhatsAppResponse] containing the contact ID, message ID, and full response if the reply was sent successfully.
  Future<WhatsAppResponse> reply(
      {required String phoneNumber,
      required String messageId,
      required Map<String, dynamic> reply}) async {
    return await _getReplyService.reply(phoneNumber, messageId, reply);
  }

  /// Send a template message to the specified phone number
  /// [phoneNumber] The phone number with country code to which the template message will be sent
  /// [template] The template ID of the template message
  /// [language] The language code for the template message
  /// [placeholder] The placeholder values for the template message (optional)
  ///
  /// Returns a [WhatsAppResponse] containing the contact ID, message ID, and full response if the template was sent successfully.
  Future<WhatsAppResponse> sendTemplate(
      {required String phoneNumber,
      required String template,
      required String language,
      List<Map<String, dynamic>>? placeholder}) async {
    return await _getTemplateService.sendTemplate(
        phoneNumber, template, language, placeholder);
  }

  /// Set Two Step Verification for phone number registration
  /// [pin] The PIN for the two-step verification
  ///
  /// Returns a [WhatsAppSuccessResponse] indicating whether the two-step verification was set successfully.
  Future<WhatsAppSuccessResponse> twoStepVerification(
      {required int pin}) async {
    return await _getRegistrationService.twoStepVerification(pin);
  }

  /// Send your own Business API request
  /// [path] The path of the API endpoint (e.g., "/messages")
  /// [payload] The payload of the API request (e.g., {"message": "Hello, World"})
  ///
  /// Returns a [WhatsAppResponse] containing the response details if the custom request was successful.
  Future<WhatsAppResponse> sendCustomRequest(
      {required String path, required Map<String, dynamic> payload}) async {
    return await _getCustomService.sendCustomRequest(path, payload);
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
  /// Returns a [WhatsAppResponse] containing the contact ID, message ID, and full response if the flow message was sent successfully.
  Future<WhatsAppResponse> sendFlowMessage({
    required String phoneNumber,
    String flowToken = 'unused',
    required String flowId,
    required String flowCta,
    required Map<String, dynamic> flowActionPayload,
    String? headerText,
    String? bodyText,
    String? footerText,
  }) async {
    return await _getFlowService.sendFlowMessage(
      phoneNumber: phoneNumber,
      flowToken: flowToken,
      flowId: flowId,
      flowCta: flowCta,
      flowActionPayload: flowActionPayload,
      headerText: headerText,
      bodyText: bodyText,
      footerText: footerText,
    );
  }

  /// Send a catalog message to the specified phone number
  /// [phoneNumber] The phone number with country code to which the catalog message will be sent
  /// [productRetailerId] The product retailer ID for the catalog message
  /// [headerText] The header text for the catalog message (optional)
  /// [bodyText] The body text for the catalog message (optional)
  /// [footerText] The footer text for the catalog message (optional)
  ///
  /// Returns a [WhatsAppResponse] containing the contact ID, message ID, and full response if the catalog message was sent successfully.
  Future<WhatsAppResponse> sendCatalogMessage({
    required String phoneNumber,
    required String productRetailerId,
    String? headerText,
    String? bodyText,
    String? footerText,
  }) async {
    return await _getCatalogService.sendCatalogMessage(
      phoneNumber: phoneNumber,
      productRetailerId: productRetailerId,
      headerText: headerText,
      bodyText: bodyText,
      footerText: footerText,
    );
  }

  /// Send a product message to the specified phone number
  /// [phoneNumber] The phone number with country code to which the product message will be sent
  /// [catalogId] The catalog ID for the product message
  /// [productRetailerId] The product retailer ID for the product message
  /// [bodyText] The body text for the product message (optional)
  /// [footerText] The footer text for the product message (optional)
  ///
  /// Returns a [WhatsAppResponse] containing the contact ID, message ID, and full response if the product message was sent successfully.
  Future<WhatsAppResponse> sendProductMessage({
    required String phoneNumber,
    required String catalogId,
    required String productRetailerId,
    String? bodyText,
    String? footerText,
  }) async {
    return await _getCatalogService.sendProductMessage(
        phoneNumber: phoneNumber,
        catalogId: catalogId,
        productRetailerId: productRetailerId,
        bodyText: bodyText,
        footerText: footerText);
  }

  /// Generate direct WhatsApp link
  /// [phoneNumber] The phone number with country code to which the WhatsApp link will be generated
  /// [message] The message content for the WhatsApp link (optional)
  /// [shortLink] Generate a shortened link (optional)
  /// [bold] Add bold formatting to the message (optional)
  /// [italic] Add italic formatting to the message (optional)
  /// [strikethrough] Add strikethrough formatting to the message (optional)
  /// [monospace] Add monospace formatting to the message (optional)
  ///
  /// Returns the generated WhatsApp message link as a string.
  String getLink({
    required String phoneNumber,
    String? message,
    bool? shortLink = false,
    List<String>? bold,
    List<String>? italic,
    List<String>? strikethrough,
    List<String>? monospace,
  }) {
    return _getTextService.getLink(phoneNumber, message, shortLink, bold,
        italic, strikethrough, monospace);
  }

  /// Send Typing Indicator
  /// [messageId] The message ID to which the typing indicator is related
  ///
  /// Returns a [WhatsAppSuccessResponse] indicating whether the typing indicator was sent successfully.
  Future<WhatsAppSuccessResponse> sendTypingIndicator({
    required String messageId,
  }) async {
    return await _getStatusService.sendTypingIndicator(messageId);
  }

  /// Block users by their phone numbers
  /// [users] List of phone numbers with country code to be blocked
  ///
  /// Returns a [WhatsAppBlockedUsersResponse] containing the result of the block operation.
  Future<WhatsAppBlockedUsersResponse> blockUsers(
      {required List<String>? users}) async {
    return await _getAccountService.blockUsers(users);
  }

  /// Unblock users by their phone numbers
  /// [users] List of phone numbers with country code to be unblocked
  ///
  /// Returns a [WhatsAppBlockedUsersResponse] containing the result of the unblock operation.
  Future<WhatsAppBlockedUsersResponse> unblockUsers(
      {required List<String>? users}) async {
    return await _getAccountService.unblockUsers(users);
  }

  /// Get the list of blocked users
  /// [limit] The maximum number of blocked users to return (optional)
  /// [before] A cursor for pagination to get the previous page of results (optional)
  /// [after] A cursor for pagination to get the next page of results (optional)
  ///
  /// Returns a [WhatsAppGetBlockedUsersResponse] containing the list of blocked users and pagination cursors.
  Future<WhatsAppGetBlockedUsersResponse> getBlockedUsers(
      {int? limit, String? before, String? after}) async {
    return await _getAccountService.getBlockedUsers(limit, before, after);
  }

  /// Get the file type of a file based on its path or URL
  /// [filePath] The file path or URL of the file
  ///
  /// Returns the file type as a string (e.g., "image/jpeg", "video/mp4", "document/pdf") or null if the file type could not be determined.
  String getAutoFileType({required String filePath}) {
    return _request.getAutoFileType(filePath);
  }

  /// Create a resumable upload session for large files
  /// [fileLength] The total length of the file in bytes
  /// [fileType] The type of the file (e.g., "image/jpeg", "video/mp4", "document/pdf")
  /// [fileName] The name of the file (optional)
  ///
  /// Returns a [WhatsAppResumableUploadResponse] containing the upload session details if the session was created successfully.
  Future<WhatsAppResumableUploadResponse> createResumableUploadSession({
    required int fileLength,
    required String fileType,
    String? fileName,
  }) async {
    return await _getResumableService.createResumableUploadSession(
      fileLength: fileLength,
      fileType: fileType,
      fileName: fileName,
    );
  }

  /// Upload a large file using a resumable upload session
  /// [uploadId] The ID of the resumable upload session
  /// [file] The file to upload
  /// [fileType] The type of the file (e.g., "image/jpeg", "video/mp4", "document/pdf")
  ///
  /// Returns a [WhatsAppResumableUploadResponse] indicating whether the file was uploaded successfully.
  Future<WhatsAppResumableUploadResponse> uploadResumableFile({
    required String uploadId,
    required dynamic file,
    required String fileType,
  }) async {
    return await _getResumableService.uploadResumableFile(
      uploadId: uploadId,
      file: file,
      fileType: fileType,
    );
  }

  /// Upload a large file using a resumable upload session by url
  /// [uploadId] The ID of the resumable upload session
  /// [fileUrl] The file to upload
  /// [fileType] The type of the file (e.g., "image/jpeg", "video/mp4", "document/pdf")
  ///
  /// Returns a [WhatsAppResumableUploadResponse] indicating whether the file was uploaded successfully.
  Future<WhatsAppResumableUploadResponse> uploadResumableFileByUrl({
    required String uploadId,
    required String fileUrl,
    required String fileType,
  }) async {
    return await _getResumableService.uploadResumableFileByUrl(
      uploadId: uploadId,
      fileUrl: fileUrl,
      fileType: fileType,
    );
  }

  /// Get the status of a resumable upload session
  /// [uploadId] The ID of the resumable upload session
  ///
  /// Returns a [WhatsAppResumableUploadResponse] containing the status of the upload session.
  Future<WhatsAppResumableUploadResponse> getResumableUploadSession({
    required String uploadId,
  }) async {
    return await _getResumableService.getResumableUploadSession(
        uploadId: uploadId);
  }

  /// Create and upload a file using a resumable upload session
  /// [fileLength] The total length of the file in bytes
  /// [file] The file to upload
  /// [fileUrl] The URL of the file to upload
  /// [fileType] The type of the file (e.g., "image/jpeg", "video/mp4", "document/pdf")
  /// [fileName] The name of the file (optional)
  ///
  /// Use either `file` or `fileUrl`—only one is allowed.
  /// Returns a [WhatsAppResumableUploadResponse] containing the upload session details if the file was created and uploaded successfully.
  Future<WhatsAppResumableUploadResponse> createUploadResumableFile(
      {required int fileLength,
      dynamic file,
      String fileUrl = '',
      required String fileType,
      String? fileName}) async {
    return await _getResumableService.createUploadResumableFile(
      fileLength: fileLength,
      file: file,
      fileUrl: fileUrl,
      fileType: fileType,
      fileName: fileName,
    );
  }
}
