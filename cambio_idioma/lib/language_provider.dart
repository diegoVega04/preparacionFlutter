import 'package:flutter/material.dart';

class LanguageProvider extends ChangeNotifier {
  Locale _locale = const Locale('es'); // Idioma inicial

  Locale get locale => _locale;

  void toggleLanguage() {
    _locale = (_locale.languageCode == 'es') ? const Locale('en') : const Locale('es');
    notifyListeners();
  }
}