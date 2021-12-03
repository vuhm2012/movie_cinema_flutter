import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_cinema_flutter/common/constants/themes.dart';
import 'package:movie_cinema_flutter/domain/entities/no_params.dart';
import 'package:movie_cinema_flutter/domain/usecases/get_preferred_theme_use_case.dart';
import 'package:movie_cinema_flutter/domain/usecases/toggle_theme_use_case.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  final GetPreferredThemeUseCase getPreferredThemeUseCase;
  final ToggleThemeUseCase toggleThemeUseCase;

  ThemeBloc({
    required this.getPreferredThemeUseCase,
    required this.toggleThemeUseCase,
  }) : super(
          ThemeLoaded(Themes.themes[0]),
        );

  @override
  Stream<ThemeState> mapEventToState(ThemeEvent event) async* {
    if (event is ToggleThemeEvent) {
      await toggleThemeUseCase(event.isDarkMode);
      add(LoadPreferredThemeEvent());
    } else if (event is LoadPreferredThemeEvent) {
      final response = await getPreferredThemeUseCase(NoParams());
      yield response.fold(
        (l) => ThemeError(),
        (isDarkMode) => ThemeLoaded(isDarkMode),
      );
    }
  }
}
