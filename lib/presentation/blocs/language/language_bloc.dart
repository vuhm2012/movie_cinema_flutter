import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:movie_cinema_flutter/common/constants/languages.dart';
import 'package:movie_cinema_flutter/domain/entities/language_entity.dart';

part 'language_event.dart';
part 'language_state.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  LanguageBloc()
      : super(
          LanguageLoaded(
            Locale(Languages.languages[0].code),
          ),
        );

  @override
  Stream<LanguageState> mapEventToState(LanguageEvent event) async* {
    if (event is ToggleLanguageEvent) {
      yield LanguageLoaded(Locale(event.languageEntity.code));
    }
  }
}
