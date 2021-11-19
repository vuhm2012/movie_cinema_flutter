part of 'movie_tab_bloc.dart';

abstract class MovieTabEvent extends Equatable {
  const MovieTabEvent();

  @override
  List<Object> get props => [];
}

class MovieTabChangedEvent extends MovieTabEvent {
  final int currentTabIndex;
  final bool isChangeCurrentPage;

  const MovieTabChangedEvent({
    this.currentTabIndex = 0,
    this.isChangeCurrentPage = false,
  });

  @override
  List<Object> get props => [currentTabIndex];
}
