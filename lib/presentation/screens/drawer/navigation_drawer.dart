import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_cinema_flutter/common/constants/languages.dart';
import 'package:movie_cinema_flutter/common/constants/route_constants.dart';
import 'package:movie_cinema_flutter/common/constants/size_constants.dart';
import 'package:movie_cinema_flutter/common/constants/themes.dart';
import 'package:movie_cinema_flutter/common/constants/translation_constants.dart';
import 'package:movie_cinema_flutter/common/extensions/size_extensions.dart';
import 'package:movie_cinema_flutter/common/extensions/string_extensions.dart';
import 'package:movie_cinema_flutter/common/screenutil/screenutil.dart';
import 'package:movie_cinema_flutter/presentation/blocs/language/language_bloc.dart';
import 'package:movie_cinema_flutter/presentation/blocs/login/login_bloc.dart';
import 'package:movie_cinema_flutter/presentation/blocs/theme/theme_bloc.dart';
import 'package:movie_cinema_flutter/presentation/screens/drawer/navigation_expanded_list_tile.dart';
import 'package:movie_cinema_flutter/presentation/screens/drawer/navigation_list_item.dart';
import 'package:movie_cinema_flutter/presentation/widgets/app_dialog.dart';
import 'package:movie_cinema_flutter/presentation/widgets/logo.dart';
import 'package:wiredash/wiredash.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil.screenHeight,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).primaryColor.withOpacity(0.7),
            blurRadius: 4,
          )
        ],
      ),
      width: Sizes.dimen_300.w,
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: Sizes.dimen_8.h,
                  bottom: Sizes.dimen_8.h,
                  left: Sizes.dimen_8.h,
                  right: Sizes.dimen_8.h,
                ),
                child: Logo(
                  height: Sizes.dimen_20.h,
                ),
              ),
              NavigationListItem(
                title: TranslationConstants.favoriteMovies.t(context),
                icon: Icons.favorite,
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    RouteList.favorite,
                  );
                },
              ),
              NavigationExpandedListTile(
                title: TranslationConstants.language.t(context),
                icon: Icons.language,
                children: Languages.languages.map((e) => e.value).toList(),
                onPressed: (index) {
                  BlocProvider.of<LanguageBloc>(context).add(
                    ToggleLanguageEvent(
                      Languages.languages[index],
                    ),
                  );
                },
              ),
              NavigationExpandedListTile(
                title: TranslationConstants.theme.t(context),
                icon: Icons.light_mode_outlined,
                children: [TranslationConstants.darkMode.t(context), TranslationConstants.lightMode.t(context)],
                onPressed: (index) {
                  BlocProvider.of<ThemeBloc>(context).add(
                    ToggleThemeEvent(
                      Themes.themes[index],
                    ),
                  );
                },
              ),
              NavigationListItem(
                title: TranslationConstants.feedback.t(context),
                icon: Icons.feedback,
                onPressed: () {
                  Navigator.of(context).pop();
                  Wiredash.of(context)?.show();
                },
              ),
              NavigationListItem(
                title: TranslationConstants.about.t(context),
                icon: Icons.info,
                onPressed: () {
                  Navigator.of(context).pop();
                  _showDialog(context);
                },
              ),
              BlocListener<LoginBloc, LoginState>(
                listenWhen: (previous, current) => current is LogoutSuccess,
                listener: (context, state) {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      RouteList.initail, (route) => false);
                },
                child: NavigationListItem(
                  title: TranslationConstants.logout.t(context),
                  icon: Icons.logout,
                  onPressed: () {
                    BlocProvider.of<LoginBloc>(context).add(LogoutEvent());
                  },
                ),
              ),
              SizedBox(height: Sizes.dimen_20.h,)
            ],
          ),
        ),
      ),
    );
  }

  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AppDialog(
        title: TranslationConstants.about,
        description: TranslationConstants.aboutDescription,
        buttonText: TranslationConstants.okay,
        image: Image.asset(
          'assets/pngs/tmdb_logo.png',
          height: Sizes.dimen_32.h,
        ),
      ),
    );
  }
}
