import 'package:dartz/dartz.dart';
import 'package:movie_cinema_flutter/domain/entities/app_error.dart';
import 'package:movie_cinema_flutter/domain/repositories/app_repository.dart';
import 'package:movie_cinema_flutter/domain/usecases/usecase.dart';

class ToggleThemeUseCase extends UseCase<void, bool> {
  final AppRepository repository;

  ToggleThemeUseCase(this.repository);

  @override
  Future<Either<AppError, void>> call(bool params) async {
    return await repository.toggleTheme(params);
  }
}
