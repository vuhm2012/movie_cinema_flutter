import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_cinema_flutter/common/constants/size_constants.dart';
import 'package:movie_cinema_flutter/common/extensions/size_extensions.dart';
import 'package:movie_cinema_flutter/presentation/themes/app_color.dart';

class ThemeText {
  const ThemeText._();

  static TextTheme get _poppinsTextTheme => GoogleFonts.poppinsTextTheme();
  static TextStyle get _whiteHeadline6 => _poppinsTextTheme.headline6!.copyWith(
        fontSize: Sizes.dimen_20.sp,
        color: Colors.white,
      );

  static TextStyle get whiteSubTitle => _poppinsTextTheme.subtitle1!
      .copyWith(fontSize: Sizes.dimen_16, color: Colors.white);

  static TextStyle get whiteBodyText => _poppinsTextTheme.subtitle1!.copyWith(
      fontSize: Sizes.dimen_14,
      color: Colors.white,
      wordSpacing: 0.25,
      letterSpacing: 0.25,
      height: 1.5);

  static getTextTheme() => TextTheme(
      headline6: _whiteHeadline6,
      subtitle1: whiteSubTitle,
      subtitle2: whiteBodyText);
}

extension TextThemeExtension on TextTheme {
  TextStyle get royalBlueSubTitle => subtitle1!.copyWith(
        color: AppColor.royalBlue,
        fontWeight: FontWeight.w600,
      );
}
