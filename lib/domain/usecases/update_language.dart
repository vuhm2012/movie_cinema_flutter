import 'package:dartz/dartz.dart';
import 'package:movie_cinema_flutter/domain/entities/app_error.dart';
import 'package:movie_cinema_flutter/domain/repositories/app_repository.dart';
import 'package:movie_cinema_flutter/domain/usecases/usecase.dart';

class UpdateLanguage extends UseCase<void, String> {
  final AppRepository repository;

  UpdateLanguage(this.repository);

  @override
  Future<Either<AppError, void>> call(String languageCode) async {
    return await repository.updateLanguage(languageCode);
  }
}
