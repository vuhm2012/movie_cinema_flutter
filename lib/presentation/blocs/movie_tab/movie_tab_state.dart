part of 'movie_tab_bloc.dart';

abstract class MovieTabState extends Equatable {
  final int currentTabIndex;

  const MovieTabState({this.currentTabIndex = 0});

  @override
  List<Object> get props => [currentTabIndex];
}

class MovieTabInitial extends MovieTabState {}

class MovieTabChanged extends MovieTabState {
  final List<MovieEntity> movies;

  const MovieTabChanged({
    int currentTabIndex = 0,
    required this.movies,
  }) : super(currentTabIndex: currentTabIndex);

  @override
  List<Object> get props => [currentTabIndex, movies];
}

class MovieTabLoadEroor extends MovieTabState {
  final AppErrorType appErrorType;

  const MovieTabLoadEroor({
    int currentTabIndex = 0,
    required this.appErrorType,
  }) : super(currentTabIndex: currentTabIndex);
}

class MovieTabLoading extends MovieTabState {}