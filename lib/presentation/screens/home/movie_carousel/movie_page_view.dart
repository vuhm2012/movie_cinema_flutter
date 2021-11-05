import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_cinema_flutter/common/constants/size_constants.dart';
import 'package:movie_cinema_flutter/common/extensions/size_extensions.dart';
import 'package:movie_cinema_flutter/common/screenutil/screenutil.dart';
import 'package:movie_cinema_flutter/domain/entities/movie_entity.dart';
import 'package:movie_cinema_flutter/presentation/blocs/movie_backdrop/movie_backdrop_bloc.dart';
import 'package:movie_cinema_flutter/presentation/screens/home/movie_carousel/movie_card_widget.dart';

import 'animated_movie_card_widget.dart';

class MoviePageView extends StatefulWidget {
  final List<MovieEntity> movies;
  final int initialPage;

  const MoviePageView(
      {Key? key, required this.movies, required this.initialPage})
      : assert(initialPage >= 0, 'initialPage cannot be less than 0'),
        super(key: key);

  @override
  _MoviePageWidgetState createState() => _MoviePageWidgetState();
}

class _MoviePageWidgetState extends State<MoviePageView> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: widget.initialPage,
      keepPage: false,
      viewportFraction: 0.7,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: Sizes.dimen_10.h),
      height: ScreenUtil.screenHeight * 0.35,
      child: PageView.builder(
        controller: _pageController,
        itemBuilder: (context, index) {
          final MovieEntity movieEntity = widget.movies[index];
          return AnimatedMovieCardWidget(
            index: index,
            pageController: _pageController,
            movieId: movieEntity.id,
            posterPath: movieEntity.posterPath,
          );
        },
        pageSnapping: true,
        itemCount: widget.movies.length,
        onPageChanged: (index) {
          BlocProvider.of<MovieBackdropBloc>(context)
              .add(MovieBackdropChangeEvent(widget.movies[index]));
        },
      ),
    );
  }
}
