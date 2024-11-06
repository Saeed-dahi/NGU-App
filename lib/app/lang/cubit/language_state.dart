part of 'language_cubit.dart';

@immutable
sealed class LanguageState {}

final class LanguageInit extends LanguageState {}

class ChangeLanguageState extends LanguageState {
  final Locale locale;

  ChangeLanguageState({required this.locale});
}
