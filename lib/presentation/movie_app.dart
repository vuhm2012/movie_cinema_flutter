import 'package:flutter/material.dart';
import 'package:movie_cinema_flutter/common/screenutil/screenutil.dart';
import 'package:movie_cinema_flutter/presentation/screens/home/home_screen.dart';
import 'package:movie_cinema_flutter/presentation/themes/app_color.dart';
import 'package:movie_cinema_flutter/presentation/themes/theme_text.dart';

class MovieApp extends StatelessWidget {
  const MovieApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movie App',
      theme: ThemeData(
        primaryColor: AppColor.vulcan,
        scaffoldBackgroundColor: AppColor.vulcan,
        textTheme: ThemeText.getTextTheme(),
        appBarTheme: const AppBarTheme(elevation: 0)
      ),
      home: HomeScreen(),
    );
  }
}
