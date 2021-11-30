import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:movie_cinema_flutter/data/core/api_client.dart';
import 'package:movie_cinema_flutter/data/data_sources/authentication_local_data_source.dart';
import 'package:movie_cinema_flutter/data/data_sources/authentication_remote_data_source.dart';
import 'package:movie_cinema_flutter/data/data_sources/language_local_data_source.dart';
import 'package:movie_cinema_flutter/data/data_sources/movie_local_data_source.dart';
import 'package:movie_cinema_flutter/data/data_sources/movie_remote_data_source.dart';
import 'package:movie_cinema_flutter/data/repositories/app_repository_impl.dart';
import 'package:movie_cinema_flutter/data/repositories/authentication_repository_impl.dart';
import 'package:movie_cinema_flutter/data/repositories/movie_repository_impl.dart';
import 'package:movie_cinema_flutter/domain/repositories/app_repository.dart';
import 'package:movie_cinema_flutter/domain/repositories/authentication_repository.dart';
import 'package:movie_cinema_flutter/domain/repositories/movie_repository.dart';
import 'package:movie_cinema_flutter/domain/usecases/delete_favorite_movie.dart';
import 'package:movie_cinema_flutter/domain/usecases/get_cast.dart';
import 'package:movie_cinema_flutter/domain/usecases/get_coming_soon.dart';
import 'package:movie_cinema_flutter/domain/usecases/get_favorite_movies.dart';
import 'package:movie_cinema_flutter/domain/usecases/get_movie_detail.dart';
import 'package:movie_cinema_flutter/domain/usecases/get_playing_now.dart';
import 'package:movie_cinema_flutter/domain/usecases/get_popular.dart';
import 'package:movie_cinema_flutter/domain/usecases/get_preferred_language.dart';
import 'package:movie_cinema_flutter/domain/usecases/get_trending.dart';
import 'package:movie_cinema_flutter/domain/usecases/get_videos.dart';
import 'package:movie_cinema_flutter/domain/usecases/guest_login_use_case.dart';
import 'package:movie_cinema_flutter/domain/usecases/is_favorite_movie.dart';
import 'package:movie_cinema_flutter/domain/usecases/login_user.dart';
import 'package:movie_cinema_flutter/domain/usecases/logout_user.dart';
import 'package:movie_cinema_flutter/domain/usecases/save_favorite_movie.dart';
import 'package:movie_cinema_flutter/domain/usecases/search_moives.dart';
import 'package:movie_cinema_flutter/domain/usecases/set_role_use_case.dart';
import 'package:movie_cinema_flutter/domain/usecases/update_language.dart';
import 'package:movie_cinema_flutter/presentation/blocs/cast/cast_bloc.dart';
import 'package:movie_cinema_flutter/presentation/blocs/favorite_movie/favorite_movie_bloc.dart';
import 'package:movie_cinema_flutter/presentation/blocs/language/language_bloc.dart';
import 'package:movie_cinema_flutter/presentation/blocs/loading/loading_bloc.dart';
import 'package:movie_cinema_flutter/presentation/blocs/login/login_bloc.dart';
import 'package:movie_cinema_flutter/presentation/blocs/movie_backdrop/movie_backdrop_bloc.dart';
import 'package:movie_cinema_flutter/presentation/blocs/movie_carousel/movie_carousel_bloc.dart';
import 'package:movie_cinema_flutter/presentation/blocs/movie_detail/movie_detail_bloc.dart';
import 'package:movie_cinema_flutter/presentation/blocs/movie_tab/movie_tab_bloc.dart';
import 'package:movie_cinema_flutter/presentation/blocs/search_movie/search_movie_bloc.dart';
import 'package:movie_cinema_flutter/presentation/blocs/videos/videos_bloc.dart';

final getItInstance = GetIt.I;

Future init() async {
  getItInstance.registerLazySingleton<Client>(() => Client());

  getItInstance
      .registerLazySingleton<ApiClient>(() => ApiClient(getItInstance()));

  getItInstance.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(getItInstance()));

  getItInstance.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl());

  getItInstance.registerLazySingleton<LanguageLocalDataSource>(
      () => LanguageLocalDataSourceImpl());

  getItInstance.registerLazySingleton<AuthenticationRemoteDataSource>(
      () => AuthenticationRemoteDataSourceImpl(getItInstance()));

  getItInstance.registerLazySingleton<AuthenticationLocalDataSource>(
      () => AuthenticationLocalDataSourceImpl());

  getItInstance.registerLazySingleton<MovieRepository>(
      () => MovieRepositoryImpl(getItInstance(), getItInstance(), getItInstance()));

  getItInstance.registerLazySingleton<AppRepository>(
      () => AppRepositoryImpl(getItInstance()));

  getItInstance.registerLazySingleton<AuthenticationRepository>(
      () => AuthenticationRepositoryImpl(getItInstance(), getItInstance()));

  getItInstance.registerLazySingleton<UpdateLanguage>(
      () => UpdateLanguage(getItInstance()));

  getItInstance.registerLazySingleton<GetPreferredLanguage>(
      () => GetPreferredLanguage(getItInstance()));

  getItInstance
      .registerLazySingleton<GetTrending>(() => GetTrending(getItInstance()));

  getItInstance
      .registerLazySingleton<GetPopular>(() => GetPopular(getItInstance()));

  getItInstance.registerLazySingleton<GetMovieDetail>(
      () => GetMovieDetail(getItInstance()));

  getItInstance.registerLazySingleton<GetPlayingNow>(
      () => GetPlayingNow(getItInstance()));

  getItInstance.registerLazySingleton<GetCast>(() => GetCast(getItInstance()));

  getItInstance
      .registerLazySingleton<GetVideos>(() => GetVideos(getItInstance()));

  getItInstance
      .registerLazySingleton<SearchMovies>(() => SearchMovies(getItInstance()));

  getItInstance.registerLazySingleton<GetFavoriteMovie>(
      () => GetFavoriteMovie(getItInstance()));

  getItInstance.registerLazySingleton<SaveFavoriteMovie>(
      () => SaveFavoriteMovie(getItInstance()));

  getItInstance.registerLazySingleton<DeleteFavoriteMovie>(
      () => DeleteFavoriteMovie(getItInstance()));

  getItInstance.registerLazySingleton<IsFavoriteMovie>(
      () => IsFavoriteMovie(getItInstance()));

  getItInstance
      .registerLazySingleton<LoginUser>(() => LoginUser(getItInstance()));

  getItInstance
      .registerLazySingleton<LogoutUser>(() => LogoutUser(getItInstance()));

  getItInstance.registerLazySingleton<GuestLoginUseCase>(
      () => GuestLoginUseCase(getItInstance()));

  getItInstance.registerLazySingleton<SetRoleUseCase>(
      () => SetRoleUseCase(getItInstance()));

  getItInstance.registerFactory(
    () => MovieCarouselBloc(
      loadingBloc: getItInstance(),
      getTrending: getItInstance(),
      movieBackdropBloc: getItInstance(),
    ),
  );

  getItInstance.registerFactory(() => MovieBackdropBloc());

  getItInstance.registerFactory(() => MovieTabBloc(
        getPopular: GetPopular(getItInstance()),
        getComingSoon: GetComingSoon(getItInstance()),
        getPlayingNow: GetPlayingNow(getItInstance()),
        loadingBloc: getItInstance(),
      ));

  getItInstance.registerFactory(() => MovieDetailBloc(
        loadingBloc: getItInstance(),
        getMovieDetail: getItInstance(),
        castBloc: getItInstance(),
        videosBloc: getItInstance(),
        favoriteMovieBloc: getItInstance(),
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

  getItInstance.registerFactory(
    () => SearchMovieBloc(
      loadingBloc: getItInstance(),
      searchMovies: getItInstance(),
    ),
  );

  getItInstance.registerFactory(
    () => LoginBloc(
      loginUser: getItInstance(),
      logoutUser: getItInstance(),
      loadingBloc: getItInstance(),
      setRoleUseCase: getItInstance(),
      guestLoginUseCase: getItInstance(),
    ),
  );

  getItInstance.registerFactory(
    () => FavoriteMovieBloc(
      saveFavoriteMovie: getItInstance(),
      getFavoriteMovie: getItInstance(),
      deleteFavoriteMovie: getItInstance(),
      isFavoriteMovie: getItInstance(),
      loadingBloc: getItInstance(),
    ),
  );

  getItInstance.registerSingleton<LanguageBloc>(LanguageBloc(
    getPreferredLanguage: getItInstance(),
    updateLanguage: getItInstance(),
  ));

  getItInstance.registerSingleton<LoadingBloc>(LoadingBloc());
}
