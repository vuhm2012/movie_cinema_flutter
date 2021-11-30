class FavoriteModel {
  late String mediaType;
  late int mediaId;
  late bool favorite;

  FavoriteModel({
    required this.mediaType,
    required this.mediaId,
    required this.favorite,
  });

  FavoriteModel.fromJson(Map<String, dynamic> json) {
    mediaType = json['media_type'];
    mediaId = json['media_id'];
    favorite = json['favorite'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['media_type'] = mediaType;
    data['media_id'] = mediaId;
    data['favorite'] = favorite;
    return data;
  }
}
