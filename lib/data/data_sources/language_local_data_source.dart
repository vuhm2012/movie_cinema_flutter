import 'dart:async';

import 'package:hive/hive.dart';

abstract class LanguageLocalDataSource {
  Future<void> updateLanguage(String languageCode);
  Future<String> getPreferredLanguage();
}

class LanguageLocalDataSourceImpl extends LanguageLocalDataSource {
  @override
  Future<String> getPreferredLanguage() async {
    final languageBox = await Hive.openBox('languageBox');
    return languageBox.get('preferredLanguage');
  }

  @override
  Future<void> updateLanguage(String languageCode) async {
    final languageBox = await Hive.openBox('languageBox');
    unawaited(languageBox.put('preferredLanguage', languageCode));
  }
}
