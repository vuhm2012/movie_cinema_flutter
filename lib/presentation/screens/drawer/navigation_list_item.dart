import 'package:flutter/material.dart';
import 'package:movie_cinema_flutter/common/constants/size_constants.dart';
import 'package:movie_cinema_flutter/common/extensions/size_extensions.dart';
import 'package:movie_cinema_flutter/presentation/movie_app.dart';
import 'package:movie_cinema_flutter/presentation/themes/app_color.dart';

class NavigationListItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final Function() onPressed;
  const NavigationListItem({
    Key? key,
    required this.title,
    required this.icon,
    required this.onPressed,
  }) : super(key: key);

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
      child: InkWell(
        onTap: onPressed,
        child: Padding(
          padding: EdgeInsets.only(left: Sizes.dimen_16.w),
          child: ListTile(
            leading: Icon(
              icon,
              color: isDarkMode ? Colors.white : AppColor.vulcan,
            ),
            title: Text(
              title,
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
        ),
      ),
    );
  }
}

class NavigationSubListItem extends StatelessWidget {
  final String title;
  // final IconData icon;
  final Function() onPressed;
  const NavigationSubListItem({
    Key? key,
    required this.title,
    // required this.icon,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Padding(
        padding: EdgeInsets.only(left: Sizes.dimen_16.w),
        child: ListTile(
          // leading: Icon(
          //   icon,
          //   color: Colors.white,
          // ),
          contentPadding: EdgeInsets.symmetric(horizontal: Sizes.dimen_32.w),
          title: Text(
            title,
            style: Theme.of(context).textTheme.subtitle1,
          ),
        ),
      ),
    );
  }
}
