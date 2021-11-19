import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_cinema_flutter/common/constants/size_constants.dart';
import 'package:movie_cinema_flutter/common/extensions/size_extensions.dart';
import 'package:movie_cinema_flutter/common/extensions/string_extensions.dart';
import 'package:movie_cinema_flutter/data/core/api_constants.dart';
import 'package:movie_cinema_flutter/presentation/blocs/cast/cast_bloc.dart';
import 'package:movie_cinema_flutter/presentation/themes/theme_text.dart';
import 'package:movie_cinema_flutter/presentation/widgets/image_loading_placeholder.dart';

class CastWidget extends StatelessWidget {
  const CastWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CastBloc, CastState>(
      builder: (context, state) {
        if (state is CastLoaded) {
          return SizedBox(
            height: Sizes.dimen_105.h,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: state.casts.length,
              itemBuilder: (context, index) {
                final castEntity = state.casts[index];
                return Card(
                  elevation: 1,
                  margin: EdgeInsets.symmetric(
                    horizontal: Sizes.dimen_8.w,
                    vertical: Sizes.dimen_4.h,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(Sizes.dimen_8.w),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(Sizes.dimen_8.w),
                          ),
                          child: CachedNetworkImage(
                            height: Sizes.dimen_105.h,
                            imageUrl:
                                '${ApiConstants.baseImageUrl}${castEntity.posterPath}',
                            fit: BoxFit.fill,
                            placeholder: (context, url) =>
                                ImageLoadingPlaceHolder(
                              loadingSize: Sizes.dimen_64.w,
                            ),
                            errorWidget: (context, url, error) => Image.asset(
                              'assets/pngs/error_image.png',
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: Sizes.dimen_8.w),
                        child: Text(
                          castEntity.name.intelliTrim(),
                          overflow: TextOverflow.fade,
                          maxLines: 1,
                          style: Theme.of(context).textTheme.vulcanBodyText2,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: Sizes.dimen_8.w,
                          right: Sizes.dimen_8.w,
                          bottom: Sizes.dimen_2.h,
                        ),
                        child: Text(
                          castEntity.name,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
