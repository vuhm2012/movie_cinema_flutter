import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_cinema_flutter/domain/entities/app_error.dart';
import 'package:movie_cinema_flutter/domain/entities/movie_entity.dart';
import 'package:movie_cinema_flutter/domain/entities/movie_params.dart';
import 'package:movie_cinema_flutter/domain/entities/no_params.dart';
import 'package:movie_cinema_flutter/domain/usecases/delete_favorite_movie.dart';
import 'package:movie_cinema_flutter/domain/usecases/get_favorite_movies.dart';
import 'package:movie_cinema_flutter/domain/usecases/is_favorite_movie.dart';
import 'package:movie_cinema_flutter/domain/usecases/save_favorite_movie.dart';
import 'package:movie_cinema_flutter/presentation/blocs/loading/loading_bloc.dart';

part 'favorite_movie_event.dart';
part 'favorite_movie_state.dart';

class FavoriteMovieBloc extends Bloc<FavoriteMovieEvent, FavoriteMovieState> {
  final SaveFavoriteMovie saveFavoriteMovie;
  final DeleteFavoriteMovie deleteFavoriteMovie;
  final IsFavoriteMovie isFavoriteMovie;
  final GetFavoriteMovie getFavoriteMovie;
  final LoadingBloc loadingBloc;

  FavoriteMovieBloc({
    required this.saveFavoriteMovie,
    required this.deleteFavoriteMovie,
    required this.isFavoriteMovie,
    required this.getFavoriteMovie,
    required this.loadingBloc,
  }) : super(FavoriteMovieInitial());

  @override
  Stream<FavoriteMovieState> mapEventToState(FavoriteMovieEvent event) async* {
    if (event is ToggleFavoriteMovieEvent) {
      if (event.isFavoriteMovie) {
        loadingBloc.add(StartLoading());
        await deleteFavoriteMovie(MovieParams(event.movieEntity.id));
        loadingBloc.add(FinishLoading());
      } else {
        loadingBloc.add(StartLoading());
        await saveFavoriteMovie(event.movieEntity);
        loadingBloc.add(FinishLoading());
      }
      final response = await isFavoriteMovie(MovieParams(event.movieEntity.id));
      yield response.fold(
        (l) => FavoriteMovieError(),
        (movieId) => IsFavoriteMovieState(movieId),
      );
    } else if (event is LoadFavoriteMovieEvent) {
      yield* _fetchLoadFavoriteMovies();
    } else if (event is DeleteFavoriteMovieEvent) {
      await deleteFavoriteMovie(MovieParams(event.movieId));
      yield* _fetchLoadFavoriteMovies();
    } else if (event is IsFavoriteMovieEvent) {
      final response = await isFavoriteMovie(MovieParams(event.movieId));
      yield response.fold(
        (l) => FavoriteMovieError(),
        (movieId) => IsFavoriteMovieState(movieId),
      );
    }
  }

  Stream<FavoriteMovieState> _fetchLoadFavoriteMovies() async* {
    loadingBloc.add(StartLoading());
    final Either<AppError, List<MovieEntity>> response =
        await getFavoriteMovie(NoParams());

    yield response.fold(
      (l) => FavoriteMovieError(),
      (movies) => FavoriteMovieLoaded(movies),
    );
    loadingBloc.add(FinishLoading());
  }
}
