import 'package:movie_cinema_flutter/common/screenutil/screenutil.dart';

extension SizeExtension on double {
  double get w => ScreenUtil().setWidth(this);
  double get h => ScreenUtil().setHeight(this);
  double get sp => ScreenUtil().setSp(this);
}
