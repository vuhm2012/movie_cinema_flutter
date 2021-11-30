import 'package:dartz/dartz.dart';
import 'package:movie_cinema_flutter/domain/entities/app_error.dart';
import 'package:movie_cinema_flutter/domain/repositories/movie_repository.dart';
import 'package:movie_cinema_flutter/domain/usecases/usecase.dart';

class SetRoleUseCase extends UseCase<void, bool> {
  final MovieRepository repository;

  SetRoleUseCase(this.repository);

  @override
  Future<Either<AppError, void>> call(bool params) async {
    return await repository.setLoginRole(params);
  }
}