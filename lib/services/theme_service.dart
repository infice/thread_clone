import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class IThemeService {
  Future<void> setThemeMode(ThemeMode mode);
  Future<ThemeMode> getThemeMode();
  bool isDarkMode();
  ThemeMode get themeMode;
}

class ThemeService implements IThemeService {
  static const String _themeKey = 'theme_mode';
  late ThemeMode _themeMode;

  Future<ThemeService> init() async {
    _themeMode = await getThemeMode();
    return this;
  }

  @override
  ThemeMode get themeMode => _themeMode;

  @override
  Future<void> setThemeMode(ThemeMode mode) async {
    final prefs = await SharedPreferences.getInstance();
    String value = mode == ThemeMode.dark ? 'dark' : 'light';
    await prefs.setString(_themeKey, value);
    _themeMode = mode;
    Get.changeThemeMode(mode);
  }

  @override
  Future<ThemeMode> getThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getString(_themeKey);
    if (value == 'dark') return ThemeMode.dark;
    return ThemeMode.light;
  }

  @override
  bool isDarkMode() {
    return Get.isDarkMode;
  }
} 