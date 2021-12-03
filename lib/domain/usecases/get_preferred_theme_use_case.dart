import 'package:dartz/dartz.dart';
import 'package:movie_cinema_flutter/domain/entities/app_error.dart';
import 'package:movie_cinema_flutter/domain/entities/no_params.dart';
import 'package:movie_cinema_flutter/domain/repositories/app_repository.dart';
import 'package:movie_cinema_flutter/domain/usecases/usecase.dart';

class GetPreferredThemeUseCase extends UseCase<bool, NoParams> {
  final AppRepository repository;

  GetPreferredThemeUseCase(this.repository);

  @override
  Future<Either<AppError, bool>> call(NoParams params) async {
    return await repository.getPreferredTheme();
  }
}
