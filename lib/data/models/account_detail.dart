class AccountDetail {
  late Avatar? avatar;
  late int id;
  late String iso6391;
  late String iso31661;
  late String name;
  late bool includeAdult;
  late String username;

  AccountDetail({
    required this.avatar,
    required this.id,
    required this.iso6391,
    required this.iso31661,
    required this.name,
    required this.includeAdult,
    required this.username,
  });

  AccountDetail.fromJson(Map<String, dynamic> json) {
    avatar = json['avatar'] != null ? Avatar.fromJson(json['avatar']) : null;
    id = json['id'];
    iso6391 = json['iso_639_1'];
    iso31661 = json['iso_3166_1'];
    name = json['name'];
    includeAdult = json['include_adult'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (avatar != null) {
      data['avatar'] = avatar?.toJson();
    }
    data['id'] = id;
    data['iso_639_1'] = iso6391;
    data['iso_3166_1'] = iso31661;
    data['name'] = name;
    data['include_adult'] = includeAdult;
    data['username'] = username;
    return data;
  }
}

class Avatar {
  late Gravatar? gravatar;
  late Tmdb? tmdb;

  Avatar({
    required this.gravatar,
    required this.tmdb,
  });

  Avatar.fromJson(Map<String, dynamic> json) {
    gravatar =
        json['gravatar'] != null ? Gravatar.fromJson(json['gravatar']) : null;
    tmdb = json['tmdb'] != null ? Tmdb.fromJson(json['tmdb']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (gravatar != null) {
      data['gravatar'] = gravatar?.toJson();
    }
    if (tmdb != null) {
      data['tmdb'] = tmdb?.toJson();
    }
    return data;
  }
}

class Gravatar {
  late String hash;

  Gravatar({
    required this.hash,
  });

  Gravatar.fromJson(Map<String, dynamic> json) {
    hash = json['hash'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['hash'] = hash;
    return data;
  }
}

class Tmdb {
  Null avatarPath;

  Tmdb({this.avatarPath});

  Tmdb.fromJson(Map<String, dynamic> json) {
    avatarPath = json['avatar_path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['avatar_path'] = avatarPath;
    return data;
  }
}
