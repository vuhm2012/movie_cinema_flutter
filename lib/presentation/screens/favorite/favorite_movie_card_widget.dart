import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_cinema_flutter/common/constants/route_constants.dart';
import 'package:movie_cinema_flutter/common/constants/size_constants.dart';
import 'package:movie_cinema_flutter/common/extensions/size_extensions.dart';
import 'package:movie_cinema_flutter/data/core/api_constants.dart';
import 'package:movie_cinema_flutter/domain/entities/movie_entity.dart';
import 'package:movie_cinema_flutter/presentation/blocs/favorite_movie/favorite_movie_bloc.dart';
import 'package:movie_cinema_flutter/presentation/screens/movie_detail/movie_detail_arguments.dart';
import 'package:movie_cinema_flutter/presentation/widgets/image_loading_placeholder.dart';

class FavoriteMovieCardWidget extends StatelessWidget {
  final MovieEntity movie;

  const FavoriteMovieCardWidget({Key? key, required this.movie})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: Sizes.dimen_8.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Sizes.dimen_8.w),
      ),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed(
            RouteList.movieDetail,
            arguments: MovieDetailArguments(movie.id),
          );
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(Sizes.dimen_8.w),
          child: Stack(
            children: [
              CachedNetworkImage(
                imageUrl: '${ApiConstants.baseImageUrl}${movie.posterPath}',
                fit: BoxFit.cover,
                width: Sizes.dimen_100.h,
                placeholder: (context, url) => ImageLoadingPlaceHolder(
                  loadingSize: Sizes.dimen_64.w,
                ),
                errorWidget: (context, url, error) => const Icon(
                  Icons.error,
                  color: Colors.red,
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: () => BlocProvider.of<FavoriteMovieBloc>(context)
                      .add(DeleteFavoriteMovieEvent(movie.id)),
                  child: Padding(
                    padding: EdgeInsets.all(Sizes.dimen_12.w),
                    child: Icon(
                      Icons.delete,
                      size: Sizes.dimen_12.h,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
