import 'package:movie_cinema_flutter/data/data_sources/language_local_data_source.dart';
import 'package:movie_cinema_flutter/data/data_sources/theme_local_data_source.dart';
import 'package:movie_cinema_flutter/domain/entities/app_error.dart';
import 'package:dartz/dartz.dart';
import 'package:movie_cinema_flutter/domain/repositories/app_repository.dart';

class AppRepositoryImpl extends AppRepository {
  final LanguageLocalDataSource languageLocalDataSource;
  final ThemeLocalDataSource themeLocalDataSource;

  AppRepositoryImpl(
    this.languageLocalDataSource,
    this.themeLocalDataSource,
  );

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

  @override
  Future<Either<AppError, bool>> getPreferredTheme() async {
    try {
      final responese = await themeLocalDataSource.getPreferredTheme();
      return Right(responese);
    } on Exception {
      return const Left(AppError(AppErrorType.database));
    }
  }

  @override
  Future<Either<AppError, void>> toggleTheme(bool isDarkMode) async {
    try {
      final response = await themeLocalDataSource.toggleTheme(isDarkMode);
      return Right(response);
    } on Exception {
      return const Left(AppError(AppErrorType.database));
    }
  }
}
