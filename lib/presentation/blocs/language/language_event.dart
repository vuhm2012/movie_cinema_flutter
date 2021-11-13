part of 'language_bloc.dart';

abstract class LanguageEvent extends Equatable {
  const LanguageEvent();

  @override
  List<Object> get props => [];
}

class ToggleLanguageEvent extends LanguageEvent {
  final LanguageEntity languageEntity;

  const ToggleLanguageEvent(this.languageEntity);

  @override
  List<Object> get props => [languageEntity.code];
}

class LoadPreferredLanguageEvent extends LanguageEvent {}