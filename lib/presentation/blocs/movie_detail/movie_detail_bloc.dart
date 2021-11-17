import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_cinema_flutter/domain/entities/app_error.dart';
import 'package:movie_cinema_flutter/domain/entities/movie_detail_entity.dart';
import 'package:movie_cinema_flutter/domain/entities/movie_params.dart';
import 'package:movie_cinema_flutter/domain/usecases/get_movie_detail.dart';
import 'package:movie_cinema_flutter/presentation/blocs/cast/cast_bloc.dart';
import 'package:movie_cinema_flutter/presentation/blocs/favorite_movie/favorite_movie_bloc.dart';
import 'package:movie_cinema_flutter/presentation/blocs/loading/loading_bloc.dart';
import 'package:movie_cinema_flutter/presentation/blocs/videos/videos_bloc.dart';

part 'movie_detail_event.dart';
part 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final GetMovieDetail getMovieDetail;
  final CastBloc castBloc;
  final VideosBloc videosBloc;
  final FavoriteMovieBloc favoriteMovieBloc;
  final LoadingBloc loadingBloc;

  MovieDetailBloc({
    required this.loadingBloc,
    required this.getMovieDetail,
    required this.castBloc,
    required this.videosBloc,
    required this.favoriteMovieBloc,
  }) : super(MovieDetailInitial());

  @override
  Stream<MovieDetailState> mapEventToState(MovieDetailEvent event) async* {
    if (event is MovieDetailLoadEvent) {
      loadingBloc.add(StartLoading());
      final Either<AppError, MovieDetailEntity> eitherResponse =
          await getMovieDetail(
        MovieParams(event.movieId),
      );

      yield eitherResponse.fold(
        (l) => MovieDetailError(),
        (movie) => MovieDetailLoaded(movie),
      );

      castBloc.add(
        LoadCastEvent(movieId: event.movieId),
      );

      videosBloc.add(
        LoadVideosEvent(movieId: event.movieId),
      );

      favoriteMovieBloc.add(
        IsFavoriteMovieEvent(event.movieId),
      );
      loadingBloc.add(FinishLoading());
    }
  }
}
