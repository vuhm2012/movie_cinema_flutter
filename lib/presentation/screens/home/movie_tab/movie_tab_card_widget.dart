import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_cinema_flutter/common/constants/size_constants.dart';
import 'package:movie_cinema_flutter/common/extensions/size_extensions.dart';
import 'package:movie_cinema_flutter/common/extensions/string_extensions.dart';
import 'package:movie_cinema_flutter/data/core/api_constants.dart';
import 'package:movie_cinema_flutter/presentation/screens/movie_detail/movie_detail_arguments.dart';
import 'package:movie_cinema_flutter/presentation/screens/movie_detail/movie_detail_screen.dart';

class MovieTabCardWidget extends StatelessWidget {
  final int movieId;
  final String title, posterPath;
  const MovieTabCardWidget(
      {Key? key,
      required this.movieId,
      required this.title,
      required this.posterPath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => MovieDetailScreen(
              movieDetailArguments: MovieDetailArguments(movieId),
            ),
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(Sizes.dimen_16.w),
              child: CachedNetworkImage(
                imageUrl: '${ApiConstants.baseImageUrl}$posterPath',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: Sizes.dimen_4.h),
            child: Text(
              title.intelliTrim(),
              maxLines: 1,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
        ],
      ),
    );
  }
}
