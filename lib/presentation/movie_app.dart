import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:movie_cinema_flutter/app_localizations.dart';
import 'package:movie_cinema_flutter/common/constants/languages.dart';
import 'package:movie_cinema_flutter/common/constants/route_constants.dart';
import 'package:movie_cinema_flutter/common/screenutil/screenutil.dart';
import 'package:movie_cinema_flutter/di/get_it.dart';
import 'package:movie_cinema_flutter/presentation/blocs/language/language_bloc.dart';
import 'package:movie_cinema_flutter/presentation/blocs/loading/loading_bloc.dart';
import 'package:movie_cinema_flutter/presentation/blocs/login/login_bloc.dart';
import 'package:movie_cinema_flutter/presentation/blocs/theme/theme_bloc.dart';
import 'package:movie_cinema_flutter/presentation/routes.dart';
import 'package:movie_cinema_flutter/presentation/screens/loading/loading_screen.dart';
import 'package:movie_cinema_flutter/presentation/themes/app_color.dart';
import 'package:movie_cinema_flutter/presentation/themes/theme_text.dart';
import 'package:movie_cinema_flutter/presentation/widgets/fade_page_route_builder.dart';
import 'package:movie_cinema_flutter/presentation/wiredash_app.dart';

bool isDarkMode = true;

class MovieApp extends StatefulWidget {
  const MovieApp({Key? key}) : super(key: key);

  @override
  State<MovieApp> createState() => _MovieAppState();
}

class _MovieAppState extends State<MovieApp> {
  final _navigatorKey = GlobalKey<NavigatorState>();
  late LanguageBloc _languageBloc;
  late LoginBloc _loginBloc;
  late LoadingBloc _loadingBloc;
  late ThemeBloc _themeBloc;

  @override
  void initState() {
    super.initState();
    _languageBloc = getItInstance<LanguageBloc>();
    _languageBloc.add(LoadPreferredLanguageEvent());
    _loginBloc = getItInstance<LoginBloc>();
    _loadingBloc = getItInstance<LoadingBloc>();
    _themeBloc = getItInstance<ThemeBloc>();
    _themeBloc.add(LoadPreferredThemeEvent());
  }

  @override
  void dispose() {
    _languageBloc.close();
    _loginBloc.close();
    _loadingBloc.close();
    _themeBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init();
    return MultiBlocProvider(
      providers: [
        BlocProvider<LanguageBloc>.value(
          value: _languageBloc,
        ),
        BlocProvider<LoginBloc>.value(
          value: _loginBloc,
        ),
        BlocProvider<LoadingBloc>.value(
          value: _loadingBloc,
        ),
        BlocProvider<ThemeBloc>.value(
          value: _themeBloc,
        ),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, themeState) {
          return BlocBuilder<LanguageBloc, LanguageState>(
            builder: (context, languageState) {
              if (themeState is ThemeLoaded) {
                isDarkMode = themeState.isDarkMode;
                if (languageState is LanguageLoaded) {
                  return WiredashApp(
                    navigatorKey: _navigatorKey,
                    child: MaterialApp(
                      navigatorKey: _navigatorKey,
                      debugShowCheckedModeBanner: false,
                      title: 'Movie App',
                      theme: ThemeData(
                        unselectedWidgetColor: themeState.isDarkMode
                            ? Colors.white
                            : AppColor.vulcan,
                        colorScheme:
                            const ColorScheme.light(primary: Colors.white70),
                        primaryColor: themeState.isDarkMode
                            ? AppColor.vulcan
                            : Colors.white,
                        scaffoldBackgroundColor: themeState.isDarkMode
                            ? AppColor.vulcan
                            : Colors.white70,
                        textTheme: themeState.isDarkMode
                            ? ThemeText.getTextTheme()
                            : ThemeText.getLightTextTheme(),
                        appBarTheme: AppBarTheme(
                          elevation: 0,
                          color: themeState.isDarkMode ? AppColor.vulcan : Colors.white70,
                        ),
                        inputDecorationTheme: InputDecorationTheme(
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          hintStyle: Theme.of(context).textTheme.greySubtitle1,
                        ),
                      ),
                      supportedLocales: Languages.languages
                          .map((e) => Locale(e.code))
                          .toList(),
                      locale: languageState.locale,
                      localizationsDelegates: const [
                        AppLocalizations.delegate,
                        GlobalMaterialLocalizations.delegate,
                        GlobalWidgetsLocalizations.delegate
                      ],
                      builder: (context, child) {
                        return LoadingScreen(
                          screen: child ?? Container(),
                        );
                      },
                      initialRoute: RouteList.initail,
                      onGenerateRoute: (RouteSettings settings) {
                        final routes = Routes.getRoutes(settings);
                        final WidgetBuilder builder = routes[settings.name]!;
                        return FadePageRouteBuilder(
                          builder: builder,
                          settings: settings,
                        );
                      },
                    ),
                  );
                }
              }
              return const SizedBox.shrink();
            },
          );
        },
      ),
    );
  }
}
