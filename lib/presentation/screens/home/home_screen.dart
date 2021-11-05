import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_cinema_flutter/di/get_it.dart';
import 'package:movie_cinema_flutter/presentation/blocs/movie_backdrop/movie_backdrop_bloc.dart';
import 'package:movie_cinema_flutter/presentation/blocs/movie_carousel/movie_carousel_bloc.dart';

import 'movie_carousel/movie_carousel_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late MovieCarouselBloc movieCarouselBloc;
  late MovieBackdropBloc movieBackdropBloc;

  @override
  void initState() {
    super.initState();
    movieCarouselBloc = getItInstance<MovieCarouselBloc>();
    movieBackdropBloc = movieCarouselBloc.movieBackdropBloc;
    movieCarouselBloc.add(const CarouselLoadEvent());
  }

  @override
  void dispose() {
    super.dispose();
    movieCarouselBloc.close();
    movieBackdropBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => movieCarouselBloc,
        ),
        BlocProvider(
          create: (context) => movieBackdropBloc,
        ),
      ],
      child: Scaffold(
        body: BlocBuilder(
          bloc: movieCarouselBloc,
          builder: (context, state) {
            if (state is MovieCarouselLoaded) {
              return Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  FractionallySizedBox(
                    alignment: Alignment.topCenter,
                    heightFactor: 0.6,
                    child: MovieCarouselWidget(
                      movies: state.movies,
                      defaultIndex: state.defaultIndex,
                    ),
                  ),
                  const FractionallySizedBox(
                    alignment: Alignment.bottomCenter,
                    heightFactor: 0.4,
                    child: Placeholder(color: Colors.white),
                  ),
                ],
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}