import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart';
import 'package:movie_cinema_flutter/data/core/api_client.dart';
import 'package:movie_cinema_flutter/data/data_sources/movie_remote_data_source.dart';
import 'package:movie_cinema_flutter/data/repositories/movie_repository_impl.dart';
import 'package:movie_cinema_flutter/data/tables/movie_table.dart';
import 'package:movie_cinema_flutter/domain/entities/app_error.dart';
import 'package:movie_cinema_flutter/domain/entities/movie_entity.dart';
import 'package:movie_cinema_flutter/domain/entities/no_params.dart';
import 'package:movie_cinema_flutter/domain/repositories/movie_repository.dart';
import 'package:movie_cinema_flutter/presentation/movie_app.dart';
import 'domain/usecases/get_trending.dart';
import 'package:pedantic/pedantic.dart';
import 'di/get_it.dart' as getIt;
import 'package:path_provider/path_provider.dart' as path_provider;

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  unawaited(
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]));
  final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  Hive.registerAdapter(MovieTableAdapter());
  unawaited(getIt.init());
  runApp(const MovieApp());
}
