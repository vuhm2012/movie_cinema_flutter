import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_cinema_flutter/common/constants/size_constants.dart';
import 'package:movie_cinema_flutter/common/extensions/size_extensions.dart';
import 'package:movie_cinema_flutter/domain/entities/movie_entity.dart';
import 'package:movie_cinema_flutter/presentation/screens/home/movie_tab/movie_tab_card_widget.dart';

class MovieListViewBuilder extends StatefulWidget {
  final List<MovieEntity> movies;
  final loadMore;

  const MovieListViewBuilder({
    Key? key,
    required this.movies,
    required this.loadMore,
  }) : super(key: key);

  @override
  State<MovieListViewBuilder> createState() => _MovieListViewBuilderState();
}

class _MovieListViewBuilderState extends State<MovieListViewBuilder> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        setState(() {
          // widget.movies.add(MovieModel(
          //   originalLanguage: 'p',
          //   originalTitle: 'ppp',
          //   posterPath: widget.movies[0].posterPath,
          //   title: 'title',
          //   video: false,
          //   voteAverage: 21,
          //   overview: 'overview',
          //   releaseDate: 'releaseDate',
          //   voteCount: 23,
          //   adult: true,
          //   backdropPath: 'backdropPath',
          //   id: 1,
          //   genreIds: [],
          //   popularity: 20,
          //   mediaType: 'mediaType',
          // ));
          widget.loadMore();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: Sizes.dimen_6.h),
      child: ListView.separated(
        shrinkWrap: true,
        controller: _scrollController,
        itemCount: widget.movies.length,
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) {
          return SizedBox(
            width: Sizes.dimen_14.w,
          );
        },
        itemBuilder: (context, index) {
          final MovieEntity movie = widget.movies[index];
          return MovieTabCardWidget(
              movieId: movie.id,
              title: movie.title,
              posterPath: movie.posterPath);
        },
      ),
    );
  }
}
