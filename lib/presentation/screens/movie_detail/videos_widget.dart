import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_cinema_flutter/common/constants/route_constants.dart';
import 'package:movie_cinema_flutter/common/constants/translation_constants.dart';
import 'package:movie_cinema_flutter/common/extensions/string_extensions.dart';
import 'package:movie_cinema_flutter/presentation/blocs/videos/videos_bloc.dart';
import 'package:movie_cinema_flutter/presentation/screens/watch_video/watch_video_arguments.dart';
import 'package:movie_cinema_flutter/presentation/screens/watch_video/watch_video_screen.dart';
import 'package:movie_cinema_flutter/presentation/widgets/button.dart';

class VideosWidget extends StatelessWidget {
  final VideosBloc? videosBloc;
  const VideosWidget({
    Key? key,
    this.videosBloc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: videosBloc,
      builder: (context, state) {
        if (state is VideosLoaded && state.videos.iterator.moveNext()) {
          final _videos = state.videos;
          return Button(
            text: TranslationConstants.watchTrailers,
            onPressed: () {
              Navigator.of(context).pushNamed(
                RouteList.watchTrailer,
                arguments:WatchVideoArguments(videos: _videos),
              );
            },
          );
        } else {
          return SizedBox.shrink();
        }
      },
    );
  }
}
