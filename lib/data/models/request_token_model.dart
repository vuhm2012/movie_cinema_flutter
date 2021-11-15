class RequestTokenModel {
  final bool success;
  late final String? requestToken;
  late final String? expiresAt;

  RequestTokenModel({
    this.success = false,
    this.expiresAt,
    this.requestToken,
  });

  factory RequestTokenModel.fromJson(Map<String, dynamic> json) {
    return RequestTokenModel(
      success: json['success'],
      expiresAt: json['expires_at'],
      requestToken: json['request_token'],
    );
  }

  Map<String, dynamic> toJson() => {
        'request_token': requestToken,
      };
}
