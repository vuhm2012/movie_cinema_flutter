import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_cinema_flutter/domain/entities/app_error.dart';
import 'package:movie_cinema_flutter/domain/entities/movie_entity.dart';
import 'package:movie_cinema_flutter/domain/entities/movie_search_params.dart';
import 'package:movie_cinema_flutter/domain/usecases/search_moives.dart';
import 'package:movie_cinema_flutter/presentation/blocs/loading/loading_bloc.dart';

part 'search_movie_event.dart';
part 'search_movie_state.dart';

class SearchMovieBloc extends Bloc<SearchMovieEvent, SearchMovieState> {
  final SearchMovies searchMovies;
  final LoadingBloc loadingBloc;

  SearchMovieBloc({
    required this.searchMovies,
    required this.loadingBloc,
  }) : super(SearchMovieInitial());

  @override
  Stream<SearchMovieState> mapEventToState(SearchMovieEvent event) async* {
    if (event is SearchTermChangeEvent) {
      loadingBloc.add(StartLoading());
      if (event.searchTerm.length > 2) {
        yield SearchMovieLoading();
        final Either<AppError, List<MovieEntity>> eitherResponse =
            await searchMovies(
          MovieSearchParams(searchTerm: event.searchTerm),
        );

        yield eitherResponse.fold(
          (errorType) => SearchMovieError(errorType.appErrorType),
          (movies) => SearchMovieLoaded(movies),
        );
      }
      loadingBloc.add(FinishLoading());
    }
  }
}
