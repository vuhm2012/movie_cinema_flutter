import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:movie_cinema_flutter/data/core/api_client.dart';
import 'package:movie_cinema_flutter/data/data_sources/movie_remote_data_source.dart';
import 'package:movie_cinema_flutter/data/repositories/movie_repository_impl.dart';
import 'package:movie_cinema_flutter/domain/repositories/movie_repository.dart';
import 'package:movie_cinema_flutter/domain/usecases/get_coming_soon.dart';
import 'package:movie_cinema_flutter/domain/usecases/get_playing_now.dart';
import 'package:movie_cinema_flutter/domain/usecases/get_popular.dart';
import 'package:movie_cinema_flutter/domain/usecases/get_trending.dart';
import 'package:movie_cinema_flutter/presentation/blocs/movie_backdrop/movie_backdrop_bloc.dart';
import 'package:movie_cinema_flutter/presentation/blocs/movie_carousel/movie_carousel_bloc.dart';

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

  getItInstance.registerLazySingleton<GetPlayingNow>(
      () => GetPlayingNow(getItInstance()));

  getItInstance.registerFactory(
    () => MovieCarouselBloc(
      getTrending: getItInstance(),
      movieBackdropBloc: getItInstance(),
    ),
  );

  getItInstance.registerLazySingleton(() => MovieBackdropBloc());
}