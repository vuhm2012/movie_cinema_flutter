import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_cinema_flutter/common/constants/size_constants.dart';
import 'package:movie_cinema_flutter/common/constants/translation_constants.dart';
import 'package:movie_cinema_flutter/common/extensions/size_extensions.dart';
import 'package:movie_cinema_flutter/common/extensions/string_extensions.dart';
import 'package:movie_cinema_flutter/presentation/blocs/movie_tab/movie_tab_bloc.dart';
import 'package:movie_cinema_flutter/presentation/screens/home/movie_tab/movie_list_view_builder.dart';
import 'package:movie_cinema_flutter/presentation/screens/home/movie_tab/movie_tab_constants.dart';
import 'package:movie_cinema_flutter/presentation/screens/home/movie_tab/movie_tab_title_widget.dart';
import 'package:movie_cinema_flutter/presentation/screens/loading/loading_circle.dart';
import 'package:movie_cinema_flutter/presentation/widgets/app_error_widget.dart';

class MovieTabWidget extends StatefulWidget {
  const MovieTabWidget({Key? key}) : super(key: key);

  @override
  _MovieTabWidgetState createState() => _MovieTabWidgetState();
}

class _MovieTabWidgetState extends State<MovieTabWidget> {
  late MovieTabBloc movieTabBloc;
  int currentTabIndex = 0;

  @override
  void initState() {
    super.initState();
    movieTabBloc = BlocProvider.of<MovieTabBloc>(context);
    movieTabBloc.add(MovieTabChangedEvent(currentTabIndex: currentTabIndex));
  }

  @override
  void dispose() {
    super.dispose();
    movieTabBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieTabBloc, MovieTabState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.only(top: Sizes.dimen_4.h),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  for (var i = 0; i < MovieTabConstants.movieTabs.length; i++)
                    TabTitleWidget(
                      title: MovieTabConstants.movieTabs[i].title,
                      onTap: () => _onTabTapped(i),
                      isSelected: MovieTabConstants.movieTabs[i].index ==
                          state.currentTabIndex,
                    )
                ],
              ),
              if (state is MovieTabChanged)
                state.movies.isEmpty
                    ? Expanded(
                        child: Center(
                          child: Text(
                            TranslationConstants.noMovies.t(context),
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                        ),
                      )
                    : Expanded(
                        child: MovieListViewBuilder(
                          movies: state.movies,
                          loadMore: loadMore,
                        ),
                      ),
              if (state is MovieTabLoadEroor)
                Expanded(
                  child: AppErrorWidget(
                    appErrorType: state.appErrorType,
                    onPressed: () => movieTabBloc.add(
                      MovieTabChangedEvent(
                          currentTabIndex: state.currentTabIndex),
                    ),
                  ),
                ),
              if (state is MovieTabLoading)
                Expanded(
                  child: Center(
                    child: LoadingCircle(size: Sizes.dimen_100.w),
                  ),
                )
            ],
          ),
        );
      },
    );
  }

  void _onTabTapped(int index) {
    movieTabBloc.add(MovieTabChangedEvent(
        currentTabIndex: index, isChangeCurrentPage: true));
    currentTabIndex = index;
  }

  void loadMore() {
    movieTabBloc.add(MovieTabChangedEvent(currentTabIndex: currentTabIndex));
  }
}
