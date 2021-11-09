import 'package:movie_cinema_flutter/common/constants/translation_constants.dart';
import 'package:movie_cinema_flutter/presentation/screens/home/movie_tab/tab.dart';

class MovieTabConstants {
  static const List<Tab> movieTabs = [
    Tab(index: 0, title: TranslationConstants.popular),
    Tab(index: 1, title: TranslationConstants.now),
    Tab(index: 2, title: TranslationConstants.soon),
  ];
}
