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

  static TextStyle get _whiteSubTitle => _poppinsTextTheme.subtitle1!.copyWith(
        fontSize: Sizes.dimen_16.sp,
        color: Colors.white,
      );
  static TextStyle get _whiteButton => _poppinsTextTheme.button!.copyWith(
        fontSize: Sizes.dimen_14.sp,
        color: Colors.white,
      );

  static TextStyle get _whiteBodyText => _poppinsTextTheme.subtitle1!.copyWith(
        fontSize: Sizes.dimen_14.sp,
        color: Colors.white,
        wordSpacing: 0.25,
        letterSpacing: 0.25,
        height: 1.5,
      );

static TextStyle get _vulcanHeadline6 => _poppinsTextTheme.headline6!.copyWith(
        fontSize: Sizes.dimen_20.sp,
        color: AppColor.vulcan,
      );
  static TextStyle get _vulcanHeadline5 => _poppinsTextTheme.headline5!.copyWith(
        fontSize: Sizes.dimen_24.sp,
        color: AppColor.vulcan,
      );

  static TextStyle get _vulcanSubTitle => _poppinsTextTheme.subtitle1!.copyWith(
        fontSize: Sizes.dimen_16.sp,
        color: AppColor.vulcan,
      );

  static TextStyle get _vulcanBodyText => _poppinsTextTheme.subtitle1!.copyWith(
        fontSize: Sizes.dimen_14.sp,
        color: AppColor.vulcan,
        wordSpacing: 0.25,
        letterSpacing: 0.25,
        height: 1.5,
      );

  static getTextTheme() => TextTheme(
        headline5: _whiteHeadline5,
        headline6: _whiteHeadline6,
        subtitle1: _whiteSubTitle,
        bodyText2: _whiteBodyText,
        button: _whiteButton,
      );

  static getLightTextTheme() => TextTheme(
        headline5: _vulcanHeadline5,
        headline6: _vulcanHeadline6,
        subtitle1: _vulcanSubTitle,
        bodyText2: _vulcanBodyText,
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
  TextStyle get orangeSubtitle1 => subtitle1!.copyWith(
        color: Colors.orange,
      );
}
