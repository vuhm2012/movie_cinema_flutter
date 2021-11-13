import 'package:dartz/dartz.dart';
import 'package:movie_cinema_flutter/domain/entities/app_error.dart';
import 'package:movie_cinema_flutter/domain/entities/cast_entity.dart';
import 'package:movie_cinema_flutter/domain/entities/movie_entity.dart';
import 'package:movie_cinema_flutter/domain/entities/movie_params.dart';
import 'package:movie_cinema_flutter/domain/entities/no_params.dart';
import 'package:movie_cinema_flutter/domain/repositories/app_repository.dart';
import 'package:movie_cinema_flutter/domain/repositories/movie_repository.dart';
import 'package:movie_cinema_flutter/domain/usecases/usecase.dart';

class GetPreferredLanguage extends UseCase<String, NoParams> {
  final AppRepository repository;

  GetPreferredLanguage(this.repository);

  @override
  Future<Either<AppError, String>> call(NoParams params) async {
    return await repository.getPreferredLanguage();
  }
}
