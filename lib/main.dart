import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:movie_cinema_flutter/data/core/api_client.dart';
import 'package:movie_cinema_flutter/data/data_sources/movie_remote_data_source.dart';
import 'package:movie_cinema_flutter/data/repositories/movie_repository_impl.dart';
import 'package:movie_cinema_flutter/domain/entities/app_error.dart';
import 'package:movie_cinema_flutter/domain/entities/movie_entity.dart';
import 'package:movie_cinema_flutter/domain/entities/no_params.dart';
import 'package:movie_cinema_flutter/domain/repositories/movie_repository.dart';
import 'domain/usecases/get_trending.dart';
import 'package:pedantic/pedantic.dart';
import 'di/get_it.dart' as getIt;

Future<void> main() async {
  unawaited(getIt.init());
  GetTrending getTrending = getIt.getItInstance<GetTrending>();
  final Either<AppError, List<MovieEntity>> eitherResponse =
      await getTrending(NoParams());
  eitherResponse.fold((l) {
    print('error: $l');
  }, (r) {
    print('list of movie: $r');
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Container());
  }
}
