import 'package:flutter/material.dart';
import 'package:movie_cinema_flutter/common/constants/route_constants.dart';
import 'package:movie_cinema_flutter/presentation/screens/favorite/favorite_screen.dart';
import 'package:movie_cinema_flutter/presentation/screens/home/home_screen.dart';
import 'package:movie_cinema_flutter/presentation/screens/login/login_screen.dart';
import 'package:movie_cinema_flutter/presentation/screens/movie_detail/movie_detail_arguments.dart';
import 'package:movie_cinema_flutter/presentation/screens/movie_detail/movie_detail_screen.dart';
import 'package:movie_cinema_flutter/presentation/screens/watch_video/watch_video_arguments.dart';
import 'package:movie_cinema_flutter/presentation/screens/watch_video/watch_video_screen.dart';

class Routes {
  static Map<String, WidgetBuilder> getRoutes(RouteSettings settings) => {
    RouteList.initail: (context) => const LoginScreen(),
    RouteList.home: (context) => const HomeScreen(),
    RouteList.movieDetail: (context) => MovieDetailScreen(movieDetailArguments: settings.arguments as MovieDetailArguments,),
    RouteList.watchTrailer: (context) => WatchVideoScreen(watchVideoArguments: settings.arguments as WatchVideoArguments,),
    RouteList.favorite: (context) => const FavoriteScreen(),
  };
}
