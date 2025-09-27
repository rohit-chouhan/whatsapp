import 'whatsapp_base_response.dart';

class WhatsAppBusinessAccountResponse extends WhatsAppBaseResponse {
  // Additional fields from business account response
  final String? _about;
  final String? _address;
  final String? _description;
  final String? _email;
  final String? _profilePictureUrl;
  final String? _vertical;
  final List<String> _websites;

  WhatsAppBusinessAccountResponse({
    required Map<String, dynamic> fullResponse,
    String? about,
    String? address,
    String? description,
    String? email,
    String? profilePictureUrl,
    String? vertical,
    List<String>? websites,
  })  : _about = about,
        _address = address,
        _description = description,
        _email = email,
        _profilePictureUrl = profilePictureUrl,
        _vertical = vertical,
        _websites = websites ?? [],
        super(fullResponse);

  /// Factory constructor to create response from JSON
  factory WhatsAppBusinessAccountResponse.fromJson(Map<String, dynamic> json) {
    // Pull the first record inside "data" array
    final data = (json['data'] is List && json['data'].isNotEmpty)
        ? json['data'][0] as Map<String, dynamic>
        : {};

    return WhatsAppBusinessAccountResponse(
      fullResponse: json,
      about: data['about'] as String?,
      address: data['address'] as String?,
      description: data['description'] as String?,
      email: data['email'] as String?,
      profilePictureUrl: data['profile_picture_url'] as String?,
      vertical: data['vertical'] as String?,
      websites: (data['websites'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
    );
  }

  /// Checks if the business account information was retrieved successfully.
  ///
  /// Returns `true` if no error is present in the response.
  @override
  bool isSuccess() => getFullResponse()['error'] == null;

  /// New getters for business account fields
  String getAbout() => _about ?? '';
  String getAddress() => _address ?? '';
  String getDescription() => _description ?? '';
  String getEmail() => _email ?? '';
  String getProfilePictureUrl() => _profilePictureUrl ?? '';
  String getVertical() => _vertical ?? '';
  List<String> getWebsites() => _websites;
}
