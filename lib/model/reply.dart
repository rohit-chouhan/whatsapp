class Reply {
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

  Map<String, dynamic> imageById(String imageId) {
    return {
      "type": "image",
      "image": {"id": imageId}
    };
  }

  Map<String, dynamic> imageByUrl(String imageUrl) {
    return {
      "type": "image",
      "image": {"link": imageUrl}
    };
  }

  Map<String, dynamic> audioById(String audioId) {
    return {
      "type": "audio",
      "audio": {"id": audioId}
    };
  }

  Map<String, dynamic> audioByUrl(String audioUrl) {
    return {
      "type": "audio",
      "audio": {"link": audioUrl}
    };
  }

  Map<String, dynamic> videoById(String videoId) {
    return {
      "type": "video",
      "video": {"id": videoId}
    };
  }

  Map<String, dynamic> videoByUrl(String videoUrl) {
    return {
      "type": "video",
      "video": {"link": videoUrl}
    };
  }

  Map<String, dynamic> documentById(String documentId) {
    return {
      "type": "document",
      "document": {"id": documentId}
    };
  }

  Map<String, dynamic> documentByUrl(String documentUrl) {
    return {
      "type": "document",
      "document": {"link": documentUrl}
    };
  }
}
