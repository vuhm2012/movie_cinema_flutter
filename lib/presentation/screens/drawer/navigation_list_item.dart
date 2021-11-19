import 'package:flutter/material.dart';
import 'package:movie_cinema_flutter/common/constants/size_constants.dart';
import 'package:movie_cinema_flutter/common/extensions/size_extensions.dart';

class NavigationListItem extends StatelessWidget {
  final String title;
  final Function() onPressed;
  const NavigationListItem({
    Key? key,
    required this.title,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).primaryColor,
              blurRadius: 2,
            )
          ],
        ),
        child: Padding(
          padding: EdgeInsets.only(left: Sizes.dimen_16.w),
          child: ListTile(
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
  final Function() onPressed;
  const NavigationSubListItem({
    Key? key,
    required this.title,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).primaryColor,
              blurRadius: 2,
            )
          ],
        ),
        child: Padding(
          padding: EdgeInsets.only(left: Sizes.dimen_16.w),
          child: ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: Sizes.dimen_32.w),
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
