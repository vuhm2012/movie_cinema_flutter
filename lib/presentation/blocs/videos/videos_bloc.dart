import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_cinema_flutter/domain/entities/app_error.dart';
import 'package:movie_cinema_flutter/domain/entities/movie_entity.dart';
import 'package:movie_cinema_flutter/domain/entities/movie_params.dart';
import 'package:movie_cinema_flutter/domain/entities/video_entity.dart';
import 'package:movie_cinema_flutter/domain/usecases/get_videos.dart';

part 'videos_event.dart';
part 'videos_state.dart';

class VideosBloc extends Bloc<VideosEvent, VideosState> {
  final GetVideos getVideos;

  VideosBloc({required this.getVideos}) : super(VideosInitial());

  @override
  Stream<VideosState> mapEventToState(VideosEvent event) async* {
    if (event is LoadVideosEvent) {
      final Either<AppError, List<VideoEntity>> eitherResponse =
          await getVideos(MovieParams(event.movieId));

      yield eitherResponse.fold(
        (l) => NoVideos(),
        (videos) => VideosLoaded(videos: videos),
      );
    }
  }
}
