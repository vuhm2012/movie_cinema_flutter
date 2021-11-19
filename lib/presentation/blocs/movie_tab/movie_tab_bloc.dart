import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_cinema_flutter/domain/entities/app_error.dart';
import 'package:movie_cinema_flutter/domain/entities/movie_entity.dart';
import 'package:movie_cinema_flutter/domain/entities/movie_params.dart';
import 'package:movie_cinema_flutter/domain/usecases/get_coming_soon.dart';
import 'package:movie_cinema_flutter/domain/usecases/get_playing_now.dart';
import 'package:movie_cinema_flutter/domain/usecases/get_popular.dart';
import 'package:movie_cinema_flutter/presentation/blocs/loading/loading_bloc.dart';

part 'movie_tab_event.dart';
part 'movie_tab_state.dart';

class MovieTabBloc extends Bloc<MovieTabEvent, MovieTabState> {
  final GetPopular getPopular;
  final GetComingSoon getComingSoon;
  final GetPlayingNow getPlayingNow;
  final LoadingBloc loadingBloc;

  List<MovieEntity> movieList = [];
  int page = 1;

  MovieTabBloc({
    required this.getPopular,
    required this.getComingSoon,
    required this.getPlayingNow,
    required this.loadingBloc,
  }) : super(MovieTabInitial());

  @override
  Stream<MovieTabState> mapEventToState(MovieTabEvent event) async* {
    if (event is MovieTabChangedEvent) {
      if (event.isChangeCurrentPage) {
        yield MovieTabLoading();
        movieList = [];
        page = 1;
      } else {
        loadingBloc.add(StartLoading());
      }
      Either<AppError, List<MovieEntity>> movieEither;
      switch (event.currentTabIndex) {
        case 0:
          movieEither = await getPopular(MoviePageParams(page));
          break;
        case 1:
          movieEither = await getPlayingNow(MoviePageParams(page));
          break;
        case 2:
          movieEither = await getComingSoon(MoviePageParams(page));
          break;
        default:
          movieEither = await getPopular(MoviePageParams(page));
      }

      yield movieEither.fold(
        (l) => MovieTabLoadEroor(
          currentTabIndex: event.currentTabIndex,
          appErrorType: l.appErrorType,
        ),
        (movies) {
          movieList.addAll(movies);
          page++;
          return MovieTabChanged(
            currentTabIndex: event.currentTabIndex,
            movies: movieList,
          );
        },
      );
      loadingBloc.add(FinishLoading());
    }
  }
}
