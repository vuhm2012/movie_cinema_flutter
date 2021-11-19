import 'package:dartz/dartz.dart';
import 'package:movie_cinema_flutter/domain/entities/app_error.dart';
import 'package:movie_cinema_flutter/domain/entities/movie_entity.dart';
import 'package:movie_cinema_flutter/domain/entities/movie_params.dart';
import 'package:movie_cinema_flutter/domain/entities/no_params.dart';
import 'package:movie_cinema_flutter/domain/repositories/movie_repository.dart';
import 'package:movie_cinema_flutter/domain/usecases/usecase.dart';

class GetPlayingNow extends UseCase<List<MovieEntity>, MoviePageParams>{
  final MovieRepository repository;

  GetPlayingNow(this.repository);

  @override
  Future<Either<AppError, List<MovieEntity>>> call(MoviePageParams params) async {
    return await repository.getPlayingNow(params.page);
  }
}