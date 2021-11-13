import 'package:flutter/material.dart';
import 'package:movie_cinema_flutter/common/constants/size_constants.dart';
import 'package:movie_cinema_flutter/common/constants/translation_constants.dart';
import 'package:movie_cinema_flutter/common/extensions/size_extensions.dart';
import 'package:movie_cinema_flutter/common/extensions/string_extensions.dart';
import 'package:movie_cinema_flutter/domain/entities/app_error.dart';
import 'package:movie_cinema_flutter/presentation/blocs/movie_carousel/movie_carousel_bloc.dart';
import 'package:movie_cinema_flutter/presentation/widgets/button.dart';
import 'package:wiredash/wiredash.dart';

class AppErrorWidget extends StatelessWidget {
  final AppErrorType appErrorType;
  final Function() onPressed;

  const AppErrorWidget({
    Key? key,
    required this.appErrorType,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Sizes.dimen_32.w),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            appErrorType == AppErrorType.api
                ? TranslationConstants.somethingWentWrong.t(context)
                : TranslationConstants.checkNetwork.t(context),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.subtitle1,
          ),
          ButtonBar(
            children: [
              Button(
                text: TranslationConstants.retry,
                onPressed: onPressed,
              ),
              Button(
                text: TranslationConstants.feedback,
                onPressed: () => Wiredash.of(context)?.show(),
              ),
            ],
          )
        ],
      ),
    );
  }
}
