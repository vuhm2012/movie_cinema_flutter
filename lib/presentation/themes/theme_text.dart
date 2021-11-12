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
  static TextStyle get _whiteHeadline5 => _poppinsTextTheme.headline5!.copyWith(
        fontSize: Sizes.dimen_24.sp,
        color: Colors.white,
      );

  static TextStyle get whiteSubTitle => _poppinsTextTheme.subtitle1!.copyWith(
        fontSize: Sizes.dimen_16.sp,
        color: Colors.white,
      );
  static TextStyle get _whiteButton => _poppinsTextTheme.button!.copyWith(
        fontSize: Sizes.dimen_14.sp,
        color: Colors.white,
      );

  static TextStyle get whiteBodyText => _poppinsTextTheme.subtitle1!.copyWith(
        fontSize: Sizes.dimen_14.sp,
        color: Colors.white,
        wordSpacing: 0.25,
        letterSpacing: 0.25,
        height: 1.5,
      );

  static getTextTheme() => TextTheme(
        headline5: _whiteHeadline5,
        headline6: _whiteHeadline6,
        subtitle1: whiteSubTitle,
        bodyText2: whiteBodyText,
        button: _whiteButton,
      );
}

extension TextThemeExtension on TextTheme {
  TextStyle get royalBlueSubTitle => subtitle1!.copyWith(
        color: AppColor.royalBlue,
        fontWeight: FontWeight.w600,
      );
  TextStyle get greySubtitle1 => subtitle1!.copyWith(
        color: Colors.grey,
      );
  TextStyle get violetHeadLine6 => headline6!.copyWith(
        color: AppColor.violet,
      );
  TextStyle get vulcanBodyText2 => bodyText2!.copyWith(
        color: AppColor.vulcan,
        fontWeight: FontWeight.w600,
      );
  TextStyle get greyCaption => caption!.copyWith(
        color: Colors.grey,
      );
}
