import 'dart:async';

import 'package:hive/hive.dart';

abstract class ThemeLocalDataSource {
  Future<void> toggleTheme(bool isDarkMode);
  Future<bool> getPreferredTheme();
}

class ThemeLocalDataSourceImpl extends ThemeLocalDataSource {
  @override
  Future<bool> getPreferredTheme() async {
    final themeBox = await Hive.openBox('themeBox');
    return themeBox.get('preferredTheme') ?? true;
  }

  @override
  Future<void> toggleTheme(bool isDarkMode) async {
    final themeBox = await Hive.openBox('themeBox');
    unawaited(themeBox.put('preferredTheme', isDarkMode));
  }
}
