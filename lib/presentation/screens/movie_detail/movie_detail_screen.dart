import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_cinema_flutter/common/constants/size_constants.dart';
import 'package:movie_cinema_flutter/common/constants/translation_constants.dart';
import 'package:movie_cinema_flutter/common/extensions/size_extensions.dart';
import 'package:movie_cinema_flutter/common/extensions/string_extensions.dart';
import 'package:movie_cinema_flutter/di/get_it.dart';
import 'package:movie_cinema_flutter/presentation/blocs/cast/cast_bloc.dart';
import 'package:movie_cinema_flutter/presentation/blocs/favorite_movie/favorite_movie_bloc.dart';
import 'package:movie_cinema_flutter/presentation/blocs/movie_detail/movie_detail_bloc.dart';
import 'package:movie_cinema_flutter/presentation/blocs/videos/videos_bloc.dart';
import 'package:movie_cinema_flutter/presentation/screens/movie_detail/movie_detail_arguments.dart';
import 'package:movie_cinema_flutter/presentation/screens/movie_detail/videos_widget.dart';

import 'big_poster.dart';
import 'cast_widget.dart';

class MovieDetailScreen extends StatefulWidget {
  final MovieDetailArguments movieDetailArguments;

  const MovieDetailScreen({
    Key? key,
    required this.movieDetailArguments,
  }) : super(key: key);

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  late MovieDetailBloc _movieDetailBloc;
  late CastBloc _castBloc;
  late VideosBloc _videosBloc;
  late FavoriteMovieBloc _favoriteMovieBloc;

  @override
  void initState() {
    super.initState();
    _movieDetailBloc = getItInstance<MovieDetailBloc>();
    _castBloc = _movieDetailBloc.castBloc;
    _videosBloc = _movieDetailBloc.videosBloc;
    _favoriteMovieBloc = _movieDetailBloc.favoriteMovieBloc;
    _movieDetailBloc
        .add(MovieDetailLoadEvent(widget.movieDetailArguments.movieId));
  }

  @override
  void dispose() {
    super.dispose();
    _movieDetailBloc.close();
    _castBloc.close();
    _videosBloc.close();
    _favoriteMovieBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider.value(value: _movieDetailBloc),
          BlocProvider.value(value: _castBloc),
          BlocProvider.value(value: _videosBloc),
          BlocProvider.value(value: _favoriteMovieBloc),
        ],
        child: BlocBuilder<MovieDetailBloc, MovieDetailState>(
          builder: (context, state) {
            print('statedetail: ${state.toString()}');
            if (state is MovieDetailLoaded) {
              final movieDetail = state.movieDetailEntity;
              print(movieDetail);
              return SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    BigPoster(
                      movie: movieDetail,
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: Sizes.dimen_16.w),
                      child: Text(
                        movieDetail.overview.toString(),
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: Sizes.dimen_16.w,
                        vertical: Sizes.dimen_8.h,
                      ),
                      child: Text(
                        TranslationConstants.cast.t(context),
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                    CastWidget(),
                    VideosWidget(videosBloc: _videosBloc),
                  ],
                ),
              );
            } else if (state is MovieDetailError) {
              return Center(
                child: Text(
                  'error',
                  style: Theme.of(context).textTheme.bodyText2,
                ),
              );
            }
            return SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
