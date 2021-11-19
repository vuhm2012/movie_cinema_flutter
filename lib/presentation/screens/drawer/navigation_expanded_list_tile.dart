import 'package:flutter/material.dart';
import 'package:movie_cinema_flutter/common/constants/size_constants.dart';
import 'package:movie_cinema_flutter/common/extensions/size_extensions.dart';
import 'package:movie_cinema_flutter/presentation/screens/drawer/navigation_list_item.dart';

class NavigationExpandedListTile extends StatelessWidget {
  final String title;
  final Function(int index) onPressed;
  final List<String> children;

  const NavigationExpandedListTile(
      {Key? key,
      required this.title,
      required this.onPressed,
      required this.children})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
        child: ExpansionTile(
          title: Text(
            title,
            style: Theme.of(context).textTheme.subtitle1,
          ),
          children: [
            for (int i = 0; i < children.length; i++)
              NavigationSubListItem(
                title: children[i],
                onPressed: () => onPressed(i),
              )
          ],
        ),
      ),
    );
  }
}
