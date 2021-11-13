import 'package:dartz/dartz.dart';
import 'package:movie_cinema_flutter/domain/entities/app_error.dart';
import 'package:movie_cinema_flutter/domain/entities/cast_entity.dart';
import 'package:movie_cinema_flutter/domain/entities/movie_detail_entity.dart';
import 'package:movie_cinema_flutter/domain/entities/movie_entity.dart';
import 'package:movie_cinema_flutter/domain/entities/video_entity.dart';

abstract class MovieRepository {
  Future<Either<AppError, List<MovieEntity>>> getTrending();
  Future<Either<AppError, List<MovieEntity>>> getPopular();
  Future<Either<AppError, List<MovieEntity>>> getPlayingNow();
  Future<Either<AppError, List<MovieEntity>>> getComingSoon();
  Future<Either<AppError, MovieDetailEntity>> getMovieDetail(int id);
  Future<Either<AppError, List<CastEntity>>> getCastCrew(int id);
  Future<Either<AppError, List<VideoEntity>>> getVideos(int id);
  Future<Either<AppError, List<MovieEntity>>> getSearchedMovies(String searchTerm);
  Future<Either<AppError, List<MovieEntity>>> getFavoriteMovies();
  Future<Either<AppError, void>> saveFavoriteMovie(MovieEntity movieEntity);
  Future<Either<AppError, void>> deleteFavoriteMovie(int movieId);
  Future<Either<AppError, bool>> isFavoriteMovie(int movieId);
}
