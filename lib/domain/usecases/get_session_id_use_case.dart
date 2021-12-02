import 'package:dartz/dartz.dart';
import 'package:movie_cinema_flutter/domain/entities/app_error.dart';
import 'package:movie_cinema_flutter/domain/entities/login_request_params.dart';
import 'package:movie_cinema_flutter/domain/entities/no_params.dart';
import 'package:movie_cinema_flutter/domain/repositories/authentication_repository.dart';
import 'package:movie_cinema_flutter/domain/usecases/usecase.dart';

class GetSessionIdUseCase extends UseCase<String, NoParams> {
  final AuthenticationRepository _authenticationRepository;

  GetSessionIdUseCase(this._authenticationRepository);

  @override
  Future<Either<AppError, String>> call(
      NoParams params) async {
    return await _authenticationRepository.getSessionId();
  }
}
