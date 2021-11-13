part of 'favorite_movie_bloc.dart';

abstract class FavoriteMovieState extends Equatable {
  const FavoriteMovieState();

  @override
  List<Object> get props => [];
}

class FavoriteMovieInitial extends FavoriteMovieState {}

class FavoriteMovieLoaded extends FavoriteMovieState {
  final List<MovieEntity> movies;

  const FavoriteMovieLoaded(this.movies);

  @override
  List<Object> get props => [movies];
}

class FavoriteMovieError extends FavoriteMovieState {}

class IsFavoriteMovieState extends FavoriteMovieState {
  final bool isFavoriteMovie;

  const IsFavoriteMovieState(this.isFavoriteMovie);

  @override
  List<Object> get props => [isFavoriteMovie];
}
