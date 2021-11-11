import 'dart:convert';

import 'package:http/http.dart';
import 'package:movie_cinema_flutter/data/core/api_client.dart';
import 'package:movie_cinema_flutter/data/core/api_constants.dart';
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
}

class MovieRemoteDataSourceImpl extends MovieRemoteDataSource {
  final ApiClient _client;

  MovieRemoteDataSourceImpl(this._client);

  @override
  Future<List<MovieModel>> getTrending() async {
    final response = await _client.get('trending/movie/day', );
    final movies = MovieResultModel.fromJson(response).movies;
    print('Trending: $movies');
    return movies;
  }

  @override
  Future<List<MovieModel>> getPopular() async {
    final response = await _client.get('movie/popular');
    final movies = MovieResultModel.fromJson(response).movies;
    print('Popular: $movies');
    return movies;
  }

  @override
  Future<List<MovieModel>> getCommingSoon() async {
    final response = await _client.get('movie/upcoming');
    final movies = MovieResultModel.fromJson(response).movies;
    print('Comming Soon: $movies');
    return movies;
  }

  @override
  Future<List<MovieModel>> getPlayingNow() async {
    final response = await _client.get('movie/now_playing');
    final movies = MovieResultModel.fromJson(response).movies;
    print('Now Playing: $movies');
    return movies;
  }

  @override
  Future<MovieDetailModel> getMovieDetail(int id) async {
    final response = await _client.get('movie/$id');
    final movie = MovieDetailModel.fromJson(response);
    print('Movie detail: $movie');
    return movie;
  }

  @override
  Future<List<CastModel>> getCastCrew(int id) async {
    final response = await _client.get('movie/$id/credits');
    final castCrew = CastCrewResultModel.fromJson(response).cast;
    print('Movie detail: $castCrew');
    return castCrew;
  }

  @override
  Future<List<VideoModel>> getVideos(int id) async {
    final response = await _client.get('movie/$id/videos');
    final videos = VideoResultModel.fromJson(response).videos;
    print('Movie detail: $videos');
    return videos;
  }
}
