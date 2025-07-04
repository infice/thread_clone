import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../services/localization_service.dart';
import '../services/theme_service.dart';

class SettingsController extends GetxController {
  final ILocalizationService localizationService;
  final IThemeService themeService;
  
  SettingsController(this.localizationService, this.themeService);

  final RxString currentLanguage = 'en'.obs;
  final RxString pendingLanguage = 'en'.obs;
  final RxBool isDarkMode = false.obs;
  final Rx<ThemeMode> pendingThemeMode = ThemeMode.light.obs;

  @override
  void onInit() {
    super.onInit();
    _initLanguage();
    _initTheme();
  }

  Future<void> _initLanguage() async {
    final lang = await localizationService.loadSavedLanguage();
    currentLanguage.value = lang;
    pendingLanguage.value = lang;
  }

  Future<void> _initTheme() async {
    final mode = await themeService.getThemeMode();
    pendingThemeMode.value = mode;
    isDarkMode.value = mode == ThemeMode.dark;
  }

  void setPendingLanguage(String languageCode) {
    pendingLanguage.value = languageCode;
  }

  Future<void> applyLanguageSetting() async {
    await localizationService.setLanguage(pendingLanguage.value);
    currentLanguage.value = pendingLanguage.value;
  }

  void changeLanguage(String languageCode) {
    setPendingLanguage(languageCode);
  }

  void setPendingThemeMode(ThemeMode mode) {
    pendingThemeMode.value = mode;
    isDarkMode.value = mode == ThemeMode.dark;
  }

  Future<void> applyThemeSetting() async {
    await themeService.setThemeMode(pendingThemeMode.value);
    // Apply theme immediately to the entire app
    Get.changeThemeMode(pendingThemeMode.value);
  }

  List<Map<String, String>> getSupportedLanguages() {
    return localizationService.getSupportedLanguages();
  }

  String getCurrentLanguageName() {
    final languages = getSupportedLanguages();
    final current = languages.firstWhere(
      (lang) => lang['code'] == currentLanguage.value,
      orElse: () => languages.first,
    );
    return current['nativeName'] ?? current['name'] ?? 'English';
  }
} 