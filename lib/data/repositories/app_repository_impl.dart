import 'package:movie_cinema_flutter/data/data_sources/language_local_data_source.dart';
import 'package:movie_cinema_flutter/data/data_sources/movie_local_data_source.dart';
import 'package:movie_cinema_flutter/domain/entities/app_error.dart';
import 'package:dartz/dartz.dart';
import 'package:movie_cinema_flutter/domain/repositories/app_repository.dart';

class AppRepositoryImpl extends AppRepository {
  final LanguageLocalDataSource languageLocalDataSource;

  AppRepositoryImpl(this.languageLocalDataSource);

  @override
  Future<Either<AppError, String>> getPreferredLanguage() async {
    try {
      final responese = await languageLocalDataSource.getPreferredLanguage();
      return Right(responese);
    } on Exception {
      return const Left(AppError(AppErrorType.database));
    }
  }

  @override
  Future<Either<AppError, void>> updateLanguage(String language) async {
    try {
      final response = await languageLocalDataSource.updateLanguage(language);
      return Right(response);
    } on Exception {
      return const Left(AppError(AppErrorType.database));
    }
  }
}
