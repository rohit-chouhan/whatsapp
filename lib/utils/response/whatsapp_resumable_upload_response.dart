import 'whatsapp_base_response.dart';

class WhatsAppResumableUploadResponse extends WhatsAppBaseResponse {
  final String _id;
  final String _h;
  final int _fileOffset;

  /// Creates a [WhatsAppResumableUploadResponse] instance.
  ///
  /// This constructor is used to initialize the response object with the
  /// id, h and file offset, as well as the complete API response.
  WhatsAppResumableUploadResponse({
    required String id,
    required String h,
    required int fileOffset,
    required Map<String, dynamic> fullResponse,
  })  : _id = id,
        _h = h,
        _fileOffset = fileOffset,
        super(fullResponse);

  /// Factory constructor to create a [WhatsAppResumableUploadResponse] from a JSON map.
  ///
  /// It parses the JSON received from the WhatsApp API, extracting the
  /// id, h and file offset, as well as the complete API response.
  factory WhatsAppResumableUploadResponse.fromJson(Map<String, dynamic> json) {
    final String id = json['id'] ?? '';
    final String h = json['h'] ?? '';
    final int fileOffset = json['file_offset'] ?? 0;

    final Map<String, dynamic> fullResponse = json;

    return WhatsAppResumableUploadResponse(
      id: id,
      h: h,
      fileOffset: fileOffset,
      fullResponse: fullResponse,
    );
  }

  /// Gets the Resumable Upload ID.
  ///
  /// This ID is used to identify the upload session.
  String getId() {
    return _id;
  }

  /// Gets the Resumable Upload Hash (h).
  ///
  /// This hash is used for verifying the integrity of the uploaded file.
  String getH() {
    return _h;
  }

  /// Gets the current file offset (file size in bytes).
  ///
  /// This offset is used to track the progress of the upload.
  int getFileOffset() {
    return _fileOffset;
  }

  /// Checks if the message was successfully sent.
  ///
  /// Success is determined by the presence of both a contact ID and a message ID.
  @override
  bool isSuccess() {
    return _id.isNotEmpty || _h.isNotEmpty;
  }
}
