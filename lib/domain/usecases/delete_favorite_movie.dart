import 'package:dartz/dartz.dart';
import 'package:movie_cinema_flutter/domain/entities/app_error.dart';
import 'package:movie_cinema_flutter/domain/entities/cast_entity.dart';
import 'package:movie_cinema_flutter/domain/entities/movie_entity.dart';
import 'package:movie_cinema_flutter/domain/entities/movie_params.dart';
import 'package:movie_cinema_flutter/domain/repositories/movie_repository.dart';
import 'package:movie_cinema_flutter/domain/usecases/usecase.dart';

class DeleteFavoriteMovie extends UseCase<void, MovieParams> {
  final MovieRepository repository;

  DeleteFavoriteMovie(this.repository);

  @override
  Future<Either<AppError, void>> call(MovieParams params) async {
    return await repository.deleteFavoriteMovie(params.id);
  }
}
