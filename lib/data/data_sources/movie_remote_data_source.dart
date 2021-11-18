import 'package:movie_cinema_flutter/data/core/api_client.dart';
import 'package:movie_cinema_flutter/data/models/cast_crew_result_data_model.dart';
import 'package:movie_cinema_flutter/data/models/movie_detail.dart';
import 'package:movie_cinema_flutter/data/models/movie_model.dart';
import 'package:movie_cinema_flutter/data/models/movie_result_model.dart';
import 'package:movie_cinema_flutter/data/models/video_model.dart';
import 'package:movie_cinema_flutter/data/models/video_result_model.dart';

abstract class MovieRemoteDataSource {
  Future<List<MovieModel>> getTrending();
  Future<List<MovieModel>> getPopular();
  Future<List<MovieModel>> getPlayingNow();
  Future<List<MovieModel>> getCommingSoon();
  Future<MovieDetailModel> getMovieDetail(int id);
  Future<List<CastModel>> getCastCrew(int id);
  Future<List<VideoModel>> getVideos(int id);
  Future<List<MovieModel>> getSearchedMovies(String searchTerm);
}

class MovieRemoteDataSourceImpl extends MovieRemoteDataSource {
  final ApiClient _client;

  MovieRemoteDataSourceImpl(this._client);

  @override
  Future<List<MovieModel>> getTrending() async {
    final response = await _client.get(
      'trending/movie/day',
    );
    final movies = MovieResultModel.fromJson(response).movies;
    return movies;
  }

  @override
  Future<List<MovieModel>> getPopular() async {
    final response = await _client.get('movie/popular');
    final movies = MovieResultModel.fromJson(response).movies;
    return movies;
  }

  @override
  Future<List<MovieModel>> getCommingSoon() async {
    final response = await _client.get('movie/upcoming');
    final movies = MovieResultModel.fromJson(response).movies;
    return movies;
  }

  @override
  Future<List<MovieModel>> getPlayingNow() async {
    final response = await _client.get('movie/now_playing');
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
}
