// lib/theme_notifier.dart
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeNotifier extends ChangeNotifier {
  static const String _themePrefKey = "theme_mode_preference";
  ThemeMode _currentThemeMode = ThemeMode.light; // Default ke mode terang

  ThemeMode get currentThemeMode => _currentThemeMode;

  ThemeNotifier() {
    _loadThemePreference();
  }

  Future<void> _loadThemePreference() async {
    final prefs = await SharedPreferences.getInstance();
    // Baca preferensi, default ke light (index 0) jika tidak ada atau tidak valid
    int themeIndex = prefs.getInt(_themePrefKey) ?? ThemeMode.light.index;
    if (themeIndex >= 0 && themeIndex < ThemeMode.values.length) {
      _currentThemeMode = ThemeMode.values[themeIndex];
    } else {
      _currentThemeMode = ThemeMode.light; // Fallback
    }
    notifyListeners();
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    _currentThemeMode = mode;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_themePrefKey, mode.index);
  }

  void toggleTheme() {
    if (_currentThemeMode == ThemeMode.light) {
      setThemeMode(ThemeMode.dark);
    } else {
      setThemeMode(ThemeMode.light);
    }
    // Anda juga bisa menambahkan opsi ThemeMode.system di sini jika diinginkan
  }
}