import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageProvider with ChangeNotifier {
  String _languageCode = 'en';

  String get languageCode => _languageCode;
  String getTranslatedText(String en, String hi, String pa, String langCode) {
    switch (langCode) {
      case 'hi':
        return hi;
      case 'pa':
        return pa;
      default:
        return en;
    }
  }

  Future<void> loadSavedLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    _languageCode = prefs.getString('selected_lang') ?? 'en';
    notifyListeners();
  }

  Future<void> changeLanguage(String langCode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('selected_lang', langCode);
    _languageCode = langCode;
    notifyListeners();
  }
}
