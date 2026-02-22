part of 'language_bloc.dart';

// Events
abstract class LanguageEvent {}

class LoadSavedLanguageEvent extends LanguageEvent {}

class ChangeLanguageEvent extends LanguageEvent {
  final Locale locale;
  ChangeLanguageEvent(this.locale);
}
