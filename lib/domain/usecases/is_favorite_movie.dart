import 'package:dartz/dartz.dart';
import 'package:movie_cinema_flutter/domain/entities/app_error.dart';
import 'package:movie_cinema_flutter/domain/entities/movie_params.dart';
import 'package:movie_cinema_flutter/domain/repositories/movie_repository.dart';
import 'package:movie_cinema_flutter/domain/usecases/usecase.dart';

class IsFavoriteMovie extends UseCase<bool, MovieParams> {
  final MovieRepository repository;

  IsFavoriteMovie(this.repository);

  @override
  Future<Either<AppError, bool>> call(MovieParams params) async {
    return await repository.isFavoriteMovie(params.id);
  }
}
