class GuestSessionModel {
  final bool success;
  late final String? guestSessionId;
  late final String? expiresAt;

  GuestSessionModel({
    required this.success,
    this.expiresAt,
    this.guestSessionId,
  });

  factory GuestSessionModel.fromJson(Map<String, dynamic> json) {
    return GuestSessionModel(
      success: json['success'],
      expiresAt: json['expires_at'],
      guestSessionId: json['guest_session_id'],
    );
  }

  Map<String, dynamic> toJson() => {
        'guest_session_id': guestSessionId,
      };
}
