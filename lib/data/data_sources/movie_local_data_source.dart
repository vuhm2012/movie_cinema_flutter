import 'package:hive/hive.dart';
import 'package:movie_cinema_flutter/data/tables/movie_table.dart';

abstract class MovieLocalDataSource {
  Future<void> saveMovie(MovieTable movieTable);
  Future<List<MovieTable>> getMovies();
  Future<void> deleteMovie(int movieId);
  Future<bool> isFavoriteMovie(int movieId);
  Future<void> setLoginRole(bool role);
  Future<bool> getLoginRole();
}

class MovieLocalDataSourceImpl extends MovieLocalDataSource {
  @override
  Future<void> deleteMovie(int movieId) async {
    final movieBox = await Hive.openBox('movieBox');
    movieBox.delete(movieId);
  }

  @override
  Future<List<MovieTable>> getMovies() async {
    final movieBox = await Hive.openBox('movieBox');
    final movieIds = movieBox.keys;
    List<MovieTable> movies = [];
    for (var movieId in movieIds) {
      movies.add(movieBox.get(movieId));
    }
    return movies;
  }

  @override
  Future<bool> isFavoriteMovie(int movieId) async {
    final movieBox = await Hive.openBox('movieBox');
    return movieBox.containsKey(movieId);
  }

  @override
  Future<void> saveMovie(MovieTable movieTable) async {
    final movieBox = await Hive.openBox('movieBox');
    await movieBox.put(movieTable.id, movieTable);
  }

  @override
  Future<void> setLoginRole(bool role) async {
    final loginRole = await Hive.openBox('loginRole');
    await loginRole.put('role', role);
  }

  @override
  Future<bool> getLoginRole() async {
    final loginRole = await Hive.openBox('loginRole');
    return await loginRole.get('role');
  }
}
