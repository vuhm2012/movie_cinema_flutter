import 'package:dartz/dartz.dart';
import 'package:movie_cinema_flutter/domain/entities/app_error.dart';
import 'package:movie_cinema_flutter/domain/entities/no_params.dart';
import 'package:movie_cinema_flutter/domain/repositories/authentication_repository.dart';
import 'package:movie_cinema_flutter/domain/usecases/usecase.dart';

class GuestLoginUseCase extends UseCase<bool, NoParams> {
  final AuthenticationRepository _authenticationRepository;

  GuestLoginUseCase(this._authenticationRepository);

  @override
  Future<Either<AppError, bool>> call(
      NoParams params) async {
    return await _authenticationRepository.guestLogin();
  }
}