import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_cinema_flutter/app_localizations.dart';
import 'package:movie_cinema_flutter/common/constants/languages.dart';
import 'package:movie_cinema_flutter/common/constants/size_constants.dart';
import 'package:movie_cinema_flutter/common/constants/translation_constants.dart';
import 'package:movie_cinema_flutter/common/extensions/size_extensions.dart';
import 'package:movie_cinema_flutter/common/extensions/string_extensions.dart';
import 'package:movie_cinema_flutter/presentation/blocs/language/language_bloc.dart';
import 'package:movie_cinema_flutter/presentation/screens/drawer/navigation_expanded_list_tile.dart';
import 'package:movie_cinema_flutter/presentation/screens/drawer/navigation_list_item.dart';
import 'package:movie_cinema_flutter/presentation/widgets/logo.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: Sizes.dimen_8.h,
                bottom: Sizes.dimen_18.h,
                left: Sizes.dimen_8.h,
                right: Sizes.dimen_8.h,
              ),
              child: Logo(
                height: Sizes.dimen_20.h,
              ),
            ),
            NavigationListItem(
              title: TranslationConstants.feedback.t(context),
              onPressed: () {},
            ),
            NavigationExpandedListTile(
              title: TranslationConstants.language.t(context),
              children: Languages.languages.map((e) => e.value).toList(),
              onPressed: (index) {
                BlocProvider.of<LanguageBloc>(context).add(
                  ToggleLanguageEvent(
                    Languages.languages[index],
                  ),
                );
              },
            ),
            NavigationListItem(
              title: TranslationConstants.feedback.t(context),
              onPressed: () {},
            ),
            NavigationListItem(
              title: TranslationConstants.about.t(context),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
