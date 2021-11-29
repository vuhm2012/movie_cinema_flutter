import 'dart:io';

import 'package:movie_cinema_flutter/data/core/unauthorized_exception.dart';
import 'package:movie_cinema_flutter/data/data_sources/authentication_local_data_source.dart';
import 'package:movie_cinema_flutter/data/data_sources/authentication_remote_data_source.dart';
import 'package:movie_cinema_flutter/data/models/request_token_model.dart';
import 'package:movie_cinema_flutter/domain/entities/app_error.dart';
import 'package:dartz/dartz.dart';
import 'package:movie_cinema_flutter/domain/repositories/authentication_repository.dart';

class AuthenticationRepositoryImpl extends AuthenticationRepository {
  final AuthenticationRemoteDataSource _authenticationRemoteDataSource;
  final AuthenticationLocalDataSource _authenticationLocalDataSource;

  AuthenticationRepositoryImpl(
    this._authenticationRemoteDataSource,
    this._authenticationLocalDataSource,
  );

  Future<Either<AppError, RequestTokenModel>> _getRequestToken() async {
    try {
      final response = await _authenticationRemoteDataSource.getRequestToken();
      return Right(response);
    } on SocketException {
      return const Left(AppError(AppErrorType.network));
    } on Exception {
      return const Left(AppError(AppErrorType.api));
    }
  }

  @override
  Future<Either<AppError, bool>> loginUser(Map<String, dynamic> body) async {
    final requestTokenEitherResponse = await _getRequestToken();
    final token1 = requestTokenEitherResponse
            .getOrElse(() => RequestTokenModel())
            .requestToken ??
        '';
    try {
      body.putIfAbsent('request_token', () => token1);
      final validationWithLoginToken =
          await _authenticationRemoteDataSource.validateWithLogin(body);
      final sessionId = await _authenticationRemoteDataSource
          .createSession(validationWithLoginToken.toJson());
      if (sessionId != null) {
        await _authenticationLocalDataSource.saveSessionId(sessionId);
        print(sessionId);
        return const Right(true);
      }
      return const Left(AppError(AppErrorType.sessionDenied));
    } on SocketException {
      return const Left(AppError(AppErrorType.network));
    } on UnauthorizedException {
      return const Left(AppError(AppErrorType.unauthorized));
    } on Exception {
      return const Left(AppError(AppErrorType.api));
    }
  }

  @override
  Future<Either<AppError, void>> logoutUser() async {
    final sessionId = await _authenticationLocalDataSource.getSessionId();
    await Future.wait([
      _authenticationRemoteDataSource.deleteSession(sessionId),
      _authenticationLocalDataSource.deleteSessionId(),
    ]);
    return const Right(Unit);
  }

  @override
  Future<Either<AppError, bool>> guestLogin() async {
    try {
      final guestSessionId =
        await _authenticationRemoteDataSource.getGuestSessionId();
      if (guestSessionId != null) {
        await _authenticationLocalDataSource.saveSessionId(guestSessionId.guestSessionId.toString());
        return const Right(true);
      }
      return const Left(AppError(AppErrorType.sessionDenied));
    } on SocketException {
      return const Left(AppError(AppErrorType.network));
    } on UnauthorizedException {
      return const Left(AppError(AppErrorType.unauthorized));
    } on Exception {
      return const Left(AppError(AppErrorType.api));
    }
  }
}
