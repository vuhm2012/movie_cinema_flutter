import 'movie_model.dart';

class MovieResultModel {
  late int page;
  late List<MovieModel> movies;
  late int totalPages;
  late int totalResults;

  MovieResultModel({
    required this.page,
    required this.movies,
    required this.totalPages,
    required this.totalResults,
  });

  MovieResultModel.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    if (json['results'] != null) {
      movies = <MovieModel>[];
      json['results'].forEach((v) {
        movies.add(MovieModel.fromJson(v));
      });
    }
    totalPages = json['total_pages'];
    totalResults = json['total_results'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['page'] = page;
    data['results'] = movies.map((v) => v.toJson()).toList();
    data['total_pages'] = totalPages;
    data['total_results'] = totalResults;
    return data;
  }
}
