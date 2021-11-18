part of 'search_movie_bloc.dart';

abstract class SearchMovieEvent extends Equatable {
  const SearchMovieEvent();

  @override
  List<Object> get props => [];
}

class SearchTermChangeEvent extends SearchMovieEvent {
  final String searchTerm;

  const SearchTermChangeEvent(this.searchTerm);

  @override
  List<Object> get props => [searchTerm];
}
