import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:movie_cinema_flutter/app_localizations.dart';
import 'package:movie_cinema_flutter/common/constants/languages.dart';
import 'package:movie_cinema_flutter/common/screenutil/screenutil.dart';
import 'package:movie_cinema_flutter/di/get_it.dart';
import 'package:movie_cinema_flutter/presentation/blocs/language/language_bloc.dart';
import 'package:movie_cinema_flutter/presentation/screens/home/home_screen.dart';
import 'package:movie_cinema_flutter/presentation/themes/app_color.dart';
import 'package:movie_cinema_flutter/presentation/themes/theme_text.dart';

class MovieApp extends StatefulWidget {
  const MovieApp({Key? key}) : super(key: key);

  @override
  State<MovieApp> createState() => _MovieAppState();
}

class _MovieAppState extends State<MovieApp> {
  late LanguageBloc _languageBloc;

  @override
  void initState() {
    super.initState();
    _languageBloc = getItInstance<LanguageBloc>();
  }

  @override
  void dispose() {
    _languageBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init();
    return BlocProvider<LanguageBloc>.value(
      value: _languageBloc,
      child: BlocBuilder<LanguageBloc, LanguageState>(
        builder: (context, state) {
          if (state is LanguageLoaded) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Movie App',
              theme: ThemeData(
                  unselectedWidgetColor: Colors.blue,
                  primaryColor: AppColor.vulcan,
                  scaffoldBackgroundColor: AppColor.vulcan,
                  textTheme: ThemeText.getTextTheme(),
                  appBarTheme: const AppBarTheme(elevation: 0)),
              supportedLocales:
                  Languages.languages.map((e) => Locale(e.code)).toList(),
              locale: state.locale,
              localizationsDelegates: [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate
              ],
              home: HomeScreen(),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
