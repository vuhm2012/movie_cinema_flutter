import 'package:dartz/dartz.dart';
import 'package:movie_cinema_flutter/domain/entities/app_error.dart';
import 'package:movie_cinema_flutter/domain/entities/login_request_params.dart';
import 'package:movie_cinema_flutter/domain/repositories/authentication_repository.dart';
import 'package:movie_cinema_flutter/domain/usecases/usecase.dart';

class LoginUser extends UseCase<bool, LoginRequestParams> {
  final AuthenticationRepository _authenticationRepository;

  LoginUser(this._authenticationRepository);

  @override
  Future<Either<AppError, bool>> call(
      LoginRequestParams params) async {
    return await _authenticationRepository.loginUser(params.toJson());
  }
}
