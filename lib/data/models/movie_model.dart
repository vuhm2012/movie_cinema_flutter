import 'package:movie_cinema_flutter/domain/entities/movie_entity.dart';

class MovieModel extends MovieEntity {
  final String originalLanguage;
  final String originalTitle;
  final String posterPath;
  final String title;
  final bool video;
  final double voteAverage;
  final String overview;
  final String releaseDate;
  final int voteCount;
  final bool adult;
  final String backdropPath;
  final int id;
  final List<int> genreIds;
  final double popularity;
  final String mediaType;

  const MovieModel(
      {required this.originalLanguage,
      required this.originalTitle,
      required this.posterPath,
      required this.title,
      required this.video,
      required this.voteAverage,
      required this.overview,
      required this.releaseDate,
      required this.voteCount,
      required this.adult,
      required this.backdropPath,
      required this.id,
      required this.genreIds,
      required this.popularity,
      required this.mediaType}) : super(
        id: id,
        title: title,
        backdropPath: backdropPath,
        posterPath: posterPath,
        releaseDate: releaseDate,
        voteEverage: voteAverage,
        overView: overview
      );

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
        originalLanguage: json['original_language'],
        originalTitle: json['original_title'],
        posterPath: json['poster_path'],
        title: json['title'],
        video: json['video'],
        voteAverage: json['vote_average']?.toDouble() ?? 0.0,
        overview: json['overview'],
        releaseDate: json['release_date'],
        voteCount: json['vote_count'],
        adult: json['adult'],
        backdropPath: json['backdrop_path'],
        id: json['id'],
        genreIds: json['genre_ids'].cast<int>(),
        popularity: json['popularity']?.toDouble() ?? 0.0,
        mediaType: json['media_type']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['original_language'] = originalLanguage;
    data['original_title'] = originalTitle;
    data['poster_path'] = posterPath;
    data['title'] = title;
    data['video'] = video;
    data['vote_average'] = voteAverage;
    data['overview'] = overview;
    data['release_date'] = releaseDate;
    data['vote_count'] = voteCount;
    data['adult'] = adult;
    data['backdrop_path'] = backdropPath;
    data['id'] = id;
    data['genre_ids'] = genreIds;
    data['popularity'] = popularity;
    data['media_type'] = mediaType;
    return data;
  }
}
