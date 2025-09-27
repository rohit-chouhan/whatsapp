/// Utility class for creating reply message objects for WhatsApp API.
///
/// This class provides methods to generate structured maps representing
/// different types of reply messages that can be sent via the WhatsApp Cloud API.
class Reply {
  /// Creates a text reply object.
  ///
  /// [text] The text content of the reply.
  /// [previewUrl] Whether to include a preview URL in the text message (optional).
  ///
  /// Returns a map representing the text reply structure.
  Map<String, dynamic> text(String text, {bool? previewUrl}) {
    Map<String, dynamic> replyObject = {
      "type": "text",
      "text": {
        "body": text,
      }
    };

    if (previewUrl == true) {
      replyObject['text']['preview_url'] = true;
    }

    return replyObject;
  }

  /// Creates an image reply object using media ID.
  ///
  /// [imageId] The ID of the uploaded image media.
  ///
  /// Returns a map representing the image reply structure.
  Map<String, dynamic> imageById(String imageId) {
    return {
      "type": "image",
      "image": {"id": imageId}
    };
  }

  /// Creates an image reply object using URL.
  ///
  /// [imageUrl] The direct URL of the image.
  ///
  /// Returns a map representing the image reply structure.
  Map<String, dynamic> imageByUrl(String imageUrl) {
    return {
      "type": "image",
      "image": {"link": imageUrl}
    };
  }

  /// Creates an audio reply object using media ID.
  ///
  /// [audioId] The ID of the uploaded audio media.
  ///
  /// Returns a map representing the audio reply structure.
  Map<String, dynamic> audioById(String audioId) {
    return {
      "type": "audio",
      "audio": {"id": audioId}
    };
  }

  /// Creates an audio reply object using URL.
  ///
  /// [audioUrl] The direct URL of the audio file.
  ///
  /// Returns a map representing the audio reply structure.
  Map<String, dynamic> audioByUrl(String audioUrl) {
    return {
      "type": "audio",
      "audio": {"link": audioUrl}
    };
  }

  /// Creates a video reply object using media ID.
  ///
  /// [videoId] The ID of the uploaded video media.
  ///
  /// Returns a map representing the video reply structure.
  Map<String, dynamic> videoById(String videoId) {
    return {
      "type": "video",
      "video": {"id": videoId}
    };
  }

  /// Creates a video reply object using URL.
  ///
  /// [videoUrl] The direct URL of the video file.
  ///
  /// Returns a map representing the video reply structure.
  Map<String, dynamic> videoByUrl(String videoUrl) {
    return {
      "type": "video",
      "video": {"link": videoUrl}
    };
  }

  /// Creates a document reply object using media ID.
  ///
  /// [documentId] The ID of the uploaded document media.
  ///
  /// Returns a map representing the document reply structure.
  Map<String, dynamic> documentById(String documentId) {
    return {
      "type": "document",
      "document": {"id": documentId}
    };
  }

  /// Creates a document reply object using URL.
  ///
  /// [documentUrl] The direct URL of the document file.
  ///
  /// Returns a map representing the document reply structure.
  Map<String, dynamic> documentByUrl(String documentUrl) {
    return {
      "type": "document",
      "document": {"link": documentUrl}
    };
  }
}
