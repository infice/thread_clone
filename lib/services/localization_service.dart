import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ILocalizationService {
  Future<void> setLanguage(String languageCode);
  String getCurrentLanguage();
  List<Map<String, String>> getSupportedLanguages();
  Future<String> loadSavedLanguage();
  Locale get locale;
}

class LocalizationService implements ILocalizationService {
  static const String _defaultLanguage = 'en';
  static const String _thaiLanguage = 'th';
  static const String _langKey = 'app_language';
  late Locale _locale;
  
  Future<LocalizationService> init() async {
    final langCode = await loadSavedLanguage();
    _locale = _getLocale(langCode);
    return this;
  }

  @override
  Locale get locale => _locale;
  
  @override
  Future<void> setLanguage(String languageCode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_langKey, languageCode);
    _locale = _getLocale(languageCode);
    Get.updateLocale(_locale);
  }

  @override
  String getCurrentLanguage() {
    return Get.locale?.languageCode ?? _defaultLanguage;
  }

  @override
  List<Map<String, String>> getSupportedLanguages() {
    return [
      {'code': 'en', 'name': 'English', 'nativeName': 'English'},
      {'code': 'th', 'name': 'Thai', 'nativeName': 'ไทย'},
    ];
  }

  @override
  Future<String> loadSavedLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_langKey) ?? _defaultLanguage;
  }

  Locale _getLocale(String languageCode) {
    switch (languageCode) {
      case 'th':
        return const Locale('th', 'TH');
      case 'en':
      default:
        return const Locale('en', 'US');
    }
  }
} 