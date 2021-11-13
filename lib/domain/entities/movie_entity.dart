import 'package:equatable/equatable.dart';

import 'movie_detail_entity.dart';

class MovieEntity extends Equatable {
  final String posterPath;
  final int id;
  final String backdropPath;
  final String title;
  final num? voteEverage;
  final String? releaseDate;
  final String? overView;

  const MovieEntity(
      {required this.posterPath,
      required this.id,
      required this.backdropPath,
      required this.title,
      required this.voteEverage,
      required this.releaseDate,
      required this.overView})
      : assert(id != null, 'Movie id must not be null');

  // Props is what will return?
  @override
  List<Object> get props => [id, title];

  @override
  bool get stringify => true;

  factory MovieEntity.fromMovieDetailEntity(
      MovieDetailEntity movieDetailEntity) {
    return MovieEntity(
      posterPath: movieDetailEntity.posterPath,
      id: movieDetailEntity.id,
      backdropPath: movieDetailEntity.backdropPath ?? '-',
      title: movieDetailEntity.title,
      voteEverage: movieDetailEntity.voteAverage,
      releaseDate: movieDetailEntity.releaseDate,
      overView: movieDetailEntity.overview,
    );
  }
}
