import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_cinema_flutter/common/screenutil/screenutil.dart';
import 'package:movie_cinema_flutter/data/core/api_constants.dart';
import 'package:movie_cinema_flutter/domain/entities/movie_detail_entity.dart';

class BigPoster extends StatelessWidget {
  final MovieDetailEntity movie;

  const BigPoster({
    Key? key,
    required this.movie,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: '${ApiConstants.baseImageUrl}${movie.posterPath}',
      width: ScreenUtil.screenWidth,
    );
  }
}
