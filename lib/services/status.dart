import 'package:whatsapp/utils/request.dart';

class StatusService {
  final String accessToken;
  final String fromNumberId;
  final Request request;

  StatusService(this.accessToken, this.fromNumberId, this.request);

  /// Get message status by message ID
  /// [messageId] The message ID to get status for
  ///
  /// return Request The response object containing the HTTP response code, error message, and message status
  // Future<Request> getMessageStatus(String messageId) async {
  //   final Map<String, String> headers = {
  //     'Authorization': 'Bearer $accessToken',
  //   };

  //   await request.get('$fromNumberId/messages/$messageId', headers);
  //   return request;
  // }

  /// Mark message as read
  /// [messageId] The message ID to mark as read
  ///
  /// return Request The response object containing the HTTP response code, error message, and message ID if the
  Future<Request> markAsRead(String messageId) async {
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };

    final Map<String, dynamic> body = {
      "messaging_product": "whatsapp",
      "status": "read",
      "message_id": messageId,
    };

    await request.post('$fromNumberId/messages', headers, body);
    return request;
  }

  /// Mark message as delivered
  /// [messageId] The message ID to mark as delivered
  ///
  /// return Request The response object containing the HTTP response code, error message, and message ID if the
  // Future<Request> markAsDelivered(String messageId) async {
  //   final Map<String, String> headers = {
  //     'Content-Type': 'application/json',
  //     'Authorization': 'Bearer $accessToken',
  //   };

  //   final Map<String, dynamic> body = {
  //     "messaging_product": "whatsapp",
  //     "status": "delivered",
  //     "message_id": messageId,
  //   };

  //   await request.post('$fromNumberId/messages', headers, body);
  //   return request;
  // }

  /// New Method for Typing Indicators
  /// Send typing indicators
  /// [messageId] The message ID to send typing indicators for
  Future<Request> sendTypingIndicator(String messageId) async {
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };

    final Map<String, dynamic> body = {
      "messaging_product": "whatsapp",
      "status": "read",
      "message_id": messageId,
      "typing_indicator": {"type": "text"}
    };

    await request.post('$fromNumberId/messages', headers, body);
    return request;
  }
}
