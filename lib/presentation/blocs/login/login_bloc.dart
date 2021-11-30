import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_cinema_flutter/common/constants/translation_constants.dart';
import 'package:movie_cinema_flutter/domain/entities/app_error.dart';
import 'package:movie_cinema_flutter/domain/entities/login_request_params.dart';
import 'package:movie_cinema_flutter/domain/entities/no_params.dart';
import 'package:movie_cinema_flutter/domain/usecases/guest_login_use_case.dart';
import 'package:movie_cinema_flutter/domain/usecases/login_user.dart';
import 'package:movie_cinema_flutter/domain/usecases/logout_user.dart';
import 'package:movie_cinema_flutter/domain/usecases/set_role_use_case.dart';
import 'package:movie_cinema_flutter/presentation/blocs/loading/loading_bloc.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUser loginUser;
  final LogoutUser logoutUser;
  final SetRoleUseCase setRoleUseCase;
  final GuestLoginUseCase guestLoginUseCase;
  final LoadingBloc loadingBloc;

  LoginBloc({
    required this.loginUser,
    required this.logoutUser,
    required this.setRoleUseCase,
    required this.guestLoginUseCase,
    required this.loadingBloc,
  }) : super(LoginInitial());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginInitiateEvent) {
      loadingBloc.add(StartLoading());
      final Either<AppError, bool> eitherResponse = await loginUser(
        LoginRequestParams(
          userName: event.username,
          password: event.password,
        ),
      );
      yield eitherResponse.fold(
        (l) {
          var message = getErrorMessage(l.appErrorType);
          return LoginError(message);
        },
        (r) {
          setRoleUseCase(true);
          return LoginSuccess();
        },
      );
      loadingBloc.add(FinishLoading());
    } else if (event is GuestLoginEvent) {
      final Either<AppError, bool> eitherResponse =
          await guestLoginUseCase(NoParams());
      yield eitherResponse.fold(
        (l) {
          var message = getErrorMessage(l.appErrorType);
          return LoginError(message);
        },
        (r) {
          setRoleUseCase(false);
          return LoginSuccess();
        },
      );
    } else if (event is LogoutEvent) {
      await logoutUser(NoParams());
      yield LogoutSuccess();
    }
  }

  String getErrorMessage(AppErrorType appErrorType) {
    switch (appErrorType) {
      case AppErrorType.network:
        return TranslationConstants.noNetwork;
      case AppErrorType.api:
      case AppErrorType.database:
        return TranslationConstants.somethingWentWrong;
      case AppErrorType.sessionDenied:
        return TranslationConstants.sessionDenied;
      default:
        return TranslationConstants.wrongUsernamePassword;
    }
  }
}
