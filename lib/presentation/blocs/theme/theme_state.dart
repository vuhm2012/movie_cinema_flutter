part of 'theme_bloc.dart';

abstract class ThemeState extends Equatable {
  const ThemeState();
  
  @override
  List<Object> get props => [];
}

class ThemeLoaded extends ThemeState {
  final bool isDarkMode;

  const ThemeLoaded(this.isDarkMode);

  @override
  List<Object> get props => [isDarkMode];

}

class ThemeError extends ThemeState {}