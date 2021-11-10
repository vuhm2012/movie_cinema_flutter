import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_cinema_flutter/domain/entities/app_error.dart';
import 'package:movie_cinema_flutter/domain/entities/movie_entity.dart';
import 'package:movie_cinema_flutter/domain/entities/no_params.dart';
import 'package:movie_cinema_flutter/domain/usecases/get_coming_soon.dart';
import 'package:movie_cinema_flutter/domain/usecases/get_playing_now.dart';
import 'package:movie_cinema_flutter/domain/usecases/get_popular.dart';

part 'movie_tab_event.dart';
part 'movie_tab_state.dart';

class MovieTabBloc extends Bloc<MovieTabEvent, MovieTabState> {
  final GetPopular getPopular;
  final GetComingSoon getComingSoon;
  final GetPlayingNow getPlayingNow;

  MovieTabBloc({
    required this.getPopular,
    required this.getComingSoon,
    required this.getPlayingNow,
  }) : super(MovieTabInitial());

  @override
  Stream<MovieTabState> mapEventToState(MovieTabEvent event) async* {
    if (event is MovieTabChangedEvent) {
      Either<AppError, List<MovieEntity>> movieEither;
      switch (event.currentTabIndex) {
        case 0:
          movieEither = await getPopular(NoParams());
          break;
        case 1:
          movieEither = await getPlayingNow(NoParams());
          break;
        case 2:
          movieEither = await getComingSoon(NoParams());
          break;
        default:
          movieEither = await getPopular(NoParams());
      }

      yield movieEither.fold(
        (l) => MovieTabLoadEroor(
          currentTabIndex: event.currentTabIndex,
          appErrorType: l.appErrorType,
        ),
        (movies) {
          return MovieTabChanged(
            currentTabIndex: event.currentTabIndex,
            movies: movies,
          );
        },
      );
    }
  }
}
