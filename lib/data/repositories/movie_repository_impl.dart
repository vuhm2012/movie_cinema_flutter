import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:movie_cinema_flutter/data/data_sources/authentication_local_data_source.dart';
import 'package:movie_cinema_flutter/data/data_sources/movie_local_data_source.dart';
import 'package:movie_cinema_flutter/data/data_sources/movie_remote_data_source.dart';
import 'package:movie_cinema_flutter/data/models/cast_crew_result_data_model.dart';
import 'package:movie_cinema_flutter/data/models/movie_detail.dart';
import 'package:movie_cinema_flutter/data/models/movie_model.dart';
import 'package:movie_cinema_flutter/data/models/video_model.dart';
import 'package:movie_cinema_flutter/data/tables/movie_table.dart';
import 'package:movie_cinema_flutter/domain/entities/app_error.dart';
import 'package:movie_cinema_flutter/domain/entities/movie_entity.dart';
import 'package:movie_cinema_flutter/domain/repositories/movie_repository.dart';

class MovieRepositoryImpl extends MovieRepository {
  final MovieRemoteDataSource remoteDataSource;
  final MovieLocalDataSource localDataSource;
  final AuthenticationLocalDataSource authenticationLocalDataSource;

  MovieRepositoryImpl(
    this.remoteDataSource,
    this.localDataSource,
    this.authenticationLocalDataSource,
  );

  @override
  Future<Either<AppError, List<MovieModel>>> getTrending(int page) async {
    try {
      final movies = await remoteDataSource.getTrending(page);
      return Right(movies);
    } on SocketException {
      return const Left(AppError(AppErrorType.network));
    } on Exception {
      return const Left(AppError(AppErrorType.api));
    }
  }

  @override
  Future<Either<AppError, List<MovieModel>>> getComingSoon(int page) async {
    try {
      final movies = await remoteDataSource.getCommingSoon(page);
      return Right(movies);
    } on SocketException {
      return const Left(AppError(AppErrorType.network));
    } on Exception {
      return const Left(AppError(AppErrorType.api));
    }
  }

  @override
  Future<Either<AppError, List<MovieModel>>> getPlayingNow(int page) async {
    try {
      final movies = await remoteDataSource.getPlayingNow(page);
      return Right(movies);
    } on SocketException {
      return const Left(AppError(AppErrorType.network));
    } on Exception {
      return const Left(AppError(AppErrorType.api));
    }
  }

  @override
  Future<Either<AppError, List<MovieModel>>> getPopular(int page) async {
    try {
      final movies = await remoteDataSource.getPopular(page);
      return Right(movies);
    } on SocketException {
      return const Left(AppError(AppErrorType.network));
    } on Exception {
      return const Left(AppError(AppErrorType.api));
    }
  }

  @override
  Future<Either<AppError, MovieDetailModel>> getMovieDetail(int id) async {
    try {
      final movies = await remoteDataSource.getMovieDetail(id);
      return Right(movies);
    } on SocketException {
      return const Left(AppError(AppErrorType.network));
    } on Exception {
      return const Left(AppError(AppErrorType.api));
    }
  }

  @override
  Future<Either<AppError, List<CastModel>>> getCastCrew(int id) async {
    try {
      final castCrew = await remoteDataSource.getCastCrew(id);
      return Right(castCrew);
    } on SocketException {
      return const Left(AppError(AppErrorType.network));
    } on Exception {
      return const Left(AppError(AppErrorType.api));
    }
  }

  @override
  Future<Either<AppError, List<VideoModel>>> getVideos(int id) async {
    try {
      final videos = await remoteDataSource.getVideos(id);
      return Right(videos);
    } on SocketException {
      return const Left(AppError(AppErrorType.network));
    } on Exception {
      return const Left(AppError(AppErrorType.api));
    }
  }

  @override
  Future<Either<AppError, List<MovieModel>>> getSearchedMovies(
      String searchTerm) async {
    try {
      final movies = await remoteDataSource.getSearchedMovies(searchTerm);
      return Right(movies);
    } on SocketException {
      return const Left(AppError(AppErrorType.network));
    } on Exception {
      return const Left(AppError(AppErrorType.api));
    }
  }

  @override
  Future<Either<AppError, void>> deleteFavoriteMovie(int movieId) async {
    try {
      final response = await localDataSource.deleteMovie(movieId);
      return Right(response);
    } on Exception {
      return const Left(AppError(AppErrorType.database));
    }
  }

  @override
  Future<Either<AppError, List<MovieEntity>>> getFavoriteMovies() async {
    try {
      final role = await localDataSource.getLoginRole();
      if (role) {
        final sessionId = await authenticationLocalDataSource.getSessionId();
        final accountDetail =
            await remoteDataSource.getAccountDetails(sessionId);
        final response = await remoteDataSource.getFavoriteMovie(
            accountDetail.id, sessionId);
        print(sessionId);
        return Right(response);
      } else {
        final response = await localDataSource.getMovies();
        return Right(response);
      }
    } on Exception {
      return const Left(AppError(AppErrorType.database));
    }
  }

  @override
  Future<Either<AppError, bool>> isFavoriteMovie(int movieId) async {
    try {
      final response = await localDataSource.isFavoriteMovie(movieId);
      return Right(response);
    } on Exception {
      return const Left(AppError(AppErrorType.database));
    }
  }

  @override
  Future<Either<AppError, void>> saveFavoriteMovie(
      MovieEntity movieEntity) async {
    try {
      final response = await localDataSource
          .saveMovie(MovieTable.fromMovieEntity(movieEntity));
      return Right(response);
    } on Exception {
      return const Left(AppError(AppErrorType.database));
    }
  }

  @override
  Future<Either<AppError, bool>> getLoginRole() async {
    try {
      final response = await localDataSource.getLoginRole();
      return Right(response);
    } on Exception {
      return const Left(AppError(AppErrorType.database));
    }
  }

  @override
  Future<Either<AppError, void>> setLoginRole(bool role) async {
    try {
      final response = await localDataSource.setLoginRole(role);
      return Right(response);
    } on Exception {
      return const Left(AppError(AppErrorType.database));
    }
  }
}
