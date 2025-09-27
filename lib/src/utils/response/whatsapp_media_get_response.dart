import 'whatsapp_base_response.dart';

class WhatsAppMediaGetResponse extends WhatsAppBaseResponse {
  final String _id;
  final String _url;
  final String _mimeType;
  final String _sha256;
  final int _fileSize;

  /// Creates a [WhatsAppMediaGetResponse] instance.
  ///
  /// This constructor is used to initialize the response object with the
  /// media details and the complete API response.
  WhatsAppMediaGetResponse({
    required String id,
    required String url,
    required String mimeType,
    required String sha256,
    required int fileSize,
    required Map<String, dynamic> fullResponse,
  })  : _id = id,
        _url = url,
        _mimeType = mimeType,
        _sha256 = sha256,
        _fileSize = fileSize,
        super(fullResponse);

  /// Factory constructor to create a [WhatsAppMediaGetResponse] from a JSON map.
  ///
  /// It parses the JSON received from the WhatsApp API, extracting the
  /// media information.
  factory WhatsAppMediaGetResponse.fromJson(Map<String, dynamic> json) {
    final String id = json['id'] ?? '';
    final String url = json['url'] ?? '';
    final String mimeType = json['mime_type'] ?? '';
    final String sha256 = json['sha256'] ?? '';
    final int fileSize = json['file_size'] ?? 0;

    final Map<String, dynamic> fullResponse = json;

    return WhatsAppMediaGetResponse(
        id: id,
        url: url,
        mimeType: mimeType,
        sha256: sha256,
        fileSize: fileSize,
        fullResponse: fullResponse);
  }

  /// Gets the WhatsApp ID of the uploaded image.
  ///
  /// This ID is retrieved from the upload media API response.
  String getMediaId() {
    return _id;
  }

  /// Gets the full URL of the media.
  String getMediaUrl() {
    return _url;
  }

  String getMediaMimeType() {
    return _mimeType;
  }

  String getMediaSha256() {
    return _sha256;
  }

  int getMediaFileSize() {
    return _fileSize;
  }

  /// Checks if the media information was retrieved successfully.
  ///
  /// Returns `true` if media information retrieved successfully.
  @override
  bool isSuccess() {
    return _id.isNotEmpty;
  }
}
