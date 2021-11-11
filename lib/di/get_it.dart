import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:movie_cinema_flutter/data/core/api_client.dart';
import 'package:movie_cinema_flutter/data/data_sources/movie_remote_data_source.dart';
import 'package:movie_cinema_flutter/data/repositories/movie_repository_impl.dart';
import 'package:movie_cinema_flutter/domain/repositories/movie_repository.dart';
import 'package:movie_cinema_flutter/domain/usecases/get_cast.dart';
import 'package:movie_cinema_flutter/domain/usecases/get_coming_soon.dart';
import 'package:movie_cinema_flutter/domain/usecases/get_movie_detail.dart';
import 'package:movie_cinema_flutter/domain/usecases/get_playing_now.dart';
import 'package:movie_cinema_flutter/domain/usecases/get_popular.dart';
import 'package:movie_cinema_flutter/domain/usecases/get_trending.dart';
import 'package:movie_cinema_flutter/domain/usecases/get_videos.dart';
import 'package:movie_cinema_flutter/presentation/blocs/cast/cast_bloc.dart';
import 'package:movie_cinema_flutter/presentation/blocs/language/language_bloc.dart';
import 'package:movie_cinema_flutter/presentation/blocs/movie_backdrop/movie_backdrop_bloc.dart';
import 'package:movie_cinema_flutter/presentation/blocs/movie_carousel/movie_carousel_bloc.dart';
import 'package:movie_cinema_flutter/presentation/blocs/movie_detail/movie_detail_bloc.dart';
import 'package:movie_cinema_flutter/presentation/blocs/movie_tab/movie_tab_bloc.dart';
import 'package:movie_cinema_flutter/presentation/blocs/videos/videos_bloc.dart';

final getItInstance = GetIt.I;

Future init() async {
  getItInstance.registerLazySingleton<Client>(() => Client());

  getItInstance
      .registerLazySingleton<ApiClient>(() => ApiClient(getItInstance()));

  getItInstance.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(getItInstance()));

  getItInstance.registerLazySingleton<MovieRepository>(
      () => MovieRepositoryImpl(getItInstance()));

  getItInstance
      .registerLazySingleton<GetTrending>(() => GetTrending(getItInstance()));

  getItInstance
      .registerLazySingleton<GetPopular>(() => GetPopular(getItInstance()));

  getItInstance.registerLazySingleton<GetMovieDetail>(
      () => GetMovieDetail(getItInstance()));

  getItInstance.registerLazySingleton<GetPlayingNow>(
      () => GetPlayingNow(getItInstance()));

  getItInstance.registerLazySingleton<GetCast>(() => GetCast(getItInstance()));
  getItInstance.registerLazySingleton<GetVideos>(() => GetVideos(getItInstance()));

  getItInstance.registerFactory(
    () => MovieCarouselBloc(
      getTrending: getItInstance(),
      movieBackdropBloc: getItInstance(),
    ),
  );

  getItInstance.registerFactory(() => MovieBackdropBloc());

  getItInstance.registerFactory(() => MovieTabBloc(
        getPopular: GetPopular(getItInstance()),
        getComingSoon: GetComingSoon(getItInstance()),
        getPlayingNow: GetPlayingNow(getItInstance()),
      ));

  getItInstance.registerFactory(() => MovieDetailBloc(
        getMovieDetail: getItInstance(),
        castBloc: getItInstance(),
        videosBloc: getItInstance()
      ));

  getItInstance.registerFactory(
    () => CastBloc(
      getCast: getItInstance(),
    ),
  );

  getItInstance.registerFactory(
    () => VideosBloc(
      getVideos: getItInstance(),
    ),
  );

  getItInstance.registerSingleton<LanguageBloc>(LanguageBloc());
}
