part of 'favorite_movie_bloc.dart';

abstract class FavoriteMovieEvent extends Equatable {
  const FavoriteMovieEvent();

  @override
  List<Object> get props => [];
}

class LoadFavoriteMovieEvent extends FavoriteMovieEvent {
  @override
  List<Object> get props => [];
}

class DeleteFavoriteMovieEvent extends FavoriteMovieEvent {
  final int movieId;

  const DeleteFavoriteMovieEvent(this.movieId);

  @override
  List<Object> get props => [movieId];
}

class ToggleFavoriteMovieEvent extends FavoriteMovieEvent {
  final MovieEntity movieEntity;
  final bool isFavoriteMovie;

  const ToggleFavoriteMovieEvent(
    this.movieEntity,
    this.isFavoriteMovie,
  );

  @override
  List<Object> get props => [movieEntity, isFavoriteMovie];
}

class IsFavoriteMovieEvent extends FavoriteMovieEvent {
  final int movieId;

  const IsFavoriteMovieEvent(this.movieId);

  @override
  List<Object> get props => [movieId];
}
