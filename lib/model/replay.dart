class Replay {
  text(String text, bool? previewUrl) {
    dynamic replayObject = {
      "type": "text",
      "text": {
        "body": text,
      }
    };

    if (previewUrl!) {
      replayObject['text']['preview_url'];
    }

    return replayObject;
  }

  imageById(String imageId) {
    var replayObject = {
      "type": "image",
      "image": {"id": imageId}
    };
    return replayObject;
  }

  imageByUrl(String imageUrl) {
    var replayObject = {
      "type": "image",
      "image": {"link": imageUrl}
    };
    return replayObject;
  }

  audioById(String audioId) {
    var replayObject = {
      "type": "audio",
      "audio": {"id": audioId}
    };
    return replayObject;
  }

  audioByUrl(String audioUrl) {
    var replayObject = {
      "type": "audio",
      "audio": {"link": audioUrl}
    };
    return replayObject;
  }

  videoById(String videoId) {
    var replayObject = {
      "type": "video",
      "video": {"id": videoId}
    };
    return replayObject;
  }

  videoByUrl(String videoUrl) {
    var replayObject = {
      "type": "video",
      "video": {"link": videoUrl}
    };
    return replayObject;
  }

  documentById(String documentId) {
    var replayObject = {
      "type": "document",
      "document": {"id": documentId}
    };
    return replayObject;
  }

  documentByUrl(String documentUrl) {
    var replayObject = {
      "type": "document",
      "document": {"link": documentUrl}
    };
    return replayObject;
  }
}
