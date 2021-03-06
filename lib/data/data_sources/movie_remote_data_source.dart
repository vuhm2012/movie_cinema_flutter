import 'package:movie_cinema_flutter/data/core/api_client.dart';
import 'package:movie_cinema_flutter/data/models/account_detail.dart';
import 'package:movie_cinema_flutter/data/models/cast_crew_result_data_model.dart';
import 'package:movie_cinema_flutter/data/models/favorite_model.dart';
import 'package:movie_cinema_flutter/data/models/movie_detail.dart';
import 'package:movie_cinema_flutter/data/models/movie_model.dart';
import 'package:movie_cinema_flutter/data/models/movie_result_model.dart';
import 'package:movie_cinema_flutter/data/models/video_model.dart';
import 'package:movie_cinema_flutter/data/models/video_result_model.dart';

abstract class MovieRemoteDataSource {
  Future<List<MovieModel>> getTrending(int page);
  Future<List<MovieModel>> getPopular(int page);
  Future<List<MovieModel>> getPlayingNow(int page);
  Future<List<MovieModel>> getCommingSoon(int page);
  Future<MovieDetailModel> getMovieDetail(int id);
  Future<List<CastModel>> getCastCrew(int id);
  Future<List<VideoModel>> getVideos(int id);
  Future<List<MovieModel>> getSearchedMovies(String searchTerm);
  Future<List<MovieModel>> getFavoriteMovie(int accountId, String sessionId);
  Future<AccountDetail> getAccountDetails(String sessionId);
  Future<void> makeFavorite(int accountId, String sessionId, FavoriteModel favoriteModel);
}

class MovieRemoteDataSourceImpl extends MovieRemoteDataSource {
  final ApiClient _client;

  MovieRemoteDataSourceImpl(this._client);

  @override
  Future<List<MovieModel>> getTrending(int page) async {
    final response = await _client.get(
      'trending/movie/day',
      params: {'page': page},
    );
    final movies = MovieResultModel.fromJson(response).movies;
    return movies;
  }

  @override
  Future<List<MovieModel>> getPopular(int page) async {
    final response = await _client.get(
      'movie/popular',
      params: {'page': page},
    );
    final movies = MovieResultModel.fromJson(response).movies;
    return movies;
  }

  @override
  Future<List<MovieModel>> getCommingSoon(int page) async {
    final response = await _client.get(
      'movie/upcoming',
      params: {'page': page},
    );
    final movies = MovieResultModel.fromJson(response).movies;
    return movies;
  }

  @override
  Future<List<MovieModel>> getPlayingNow(int page) async {
    final response = await _client.get(
      'movie/now_playing',
      params: {'page': page},
    );
    final movies = MovieResultModel.fromJson(response).movies;
    return movies;
  }

  @override
  Future<MovieDetailModel> getMovieDetail(int id) async {
    final response = await _client.get('movie/$id');
    final movie = MovieDetailModel.fromJson(response);
    return movie;
  }

  @override
  Future<List<CastModel>> getCastCrew(int id) async {
    final response = await _client.get('movie/$id/credits');
    final castCrew = CastCrewResultModel.fromJson(response).cast;
    return castCrew;
  }

  @override
  Future<List<VideoModel>> getVideos(int id) async {
    final response = await _client.get('movie/$id/videos');
    final videos = VideoResultModel.fromJson(response).videos;
    return videos;
  }

  @override
  Future<List<MovieModel>> getSearchedMovies(String searchTerm) async {
    final response = await _client.get(
      'search/movie',
      params: {
        'query': searchTerm,
      },
    );
    final movies = MovieResultModel.fromJson(response).movies;
    return movies;
  }

  @override
  Future<List<MovieModel>> getFavoriteMovie(
      int accountId, String sessionId) async {
    final response = await _client.get(
      '/account/$accountId/favorite/movies',
      params: {'session_id': sessionId},
    );
    final movies = MovieResultModel.fromJson(response).movies;
    return movies;
  }

  @override
  Future<AccountDetail> getAccountDetails(String sessionId) async {
    final response = await _client.get(
      '/account',
      params: {'session_id': sessionId},
    );
    final accountDetail = AccountDetail.fromJson(response);
    return accountDetail;
  }

  @override
  Future<void> makeFavorite(int accountId, String sessionId, FavoriteModel favoriteModel) async {
    await _client.postWithParams(
      '/account/$accountId/favorite',
      body: {
        'media_type': favoriteModel.mediaType,
        'media_id': favoriteModel.mediaId,
        'favorite': favoriteModel.favorite,
      },
      params: {
        'session_id': sessionId,
      }
    );
  }
}
