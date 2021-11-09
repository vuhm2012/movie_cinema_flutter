import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:movie_cinema_flutter/app_localizations.dart';
import 'package:movie_cinema_flutter/common/constants/size_constants.dart';
import 'package:movie_cinema_flutter/common/extensions/size_extensions.dart';
import 'package:movie_cinema_flutter/presentation/themes/app_color.dart';
import 'package:movie_cinema_flutter/presentation/themes/theme_text.dart';

class TabTitleWidget extends StatelessWidget {
  final String title;
  final Function() onTap;
  final bool isSelected;

  const TabTitleWidget(
      {Key? key,
      required this.title,
      required this.onTap,
      required this.isSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border(
            bottom: BorderSide(
              color: isSelected ? AppColor.royalBlue : Colors.transparent,
              width: Sizes.dimen_1.h,
            ),
          ),
        ),
        child: Text(
          AppLocalizations.of(context)?.translate(title) ?? '',
          style: isSelected
              ? Theme.of(context).textTheme.royalBlueSubTitle
              : Theme.of(context).textTheme.subtitle1,
        ),
      ),
    );
  }
}
