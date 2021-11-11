import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_cinema_flutter/common/constants/size_constants.dart';
import 'package:movie_cinema_flutter/common/extensions/size_extensions.dart';
import 'package:movie_cinema_flutter/data/core/api_constants.dart';
import 'package:movie_cinema_flutter/presentation/screens/movie_detail/movie_detail_arguments.dart';
import 'package:movie_cinema_flutter/presentation/screens/movie_detail/movie_detail_screen.dart';

class MovieCardWidget extends StatelessWidget {
  final int movieiId;
  final String posterPath;

  const MovieCardWidget(
      {Key? key, required this.movieiId, required this.posterPath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 32,
      borderRadius: BorderRadius.circular(Sizes.dimen_16.w),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => MovieDetailScreen(
                  movieDetailArguments: MovieDetailArguments(movieiId)),
            ),
          );
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(Sizes.dimen_16.w),
          child: CachedNetworkImage(
            imageUrl: '${ApiConstants.baseImageUrl}$posterPath',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
