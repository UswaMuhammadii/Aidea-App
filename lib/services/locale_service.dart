// lib/services/locale_service.dart
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleService extends ChangeNotifier {
  Locale _locale = const Locale('en');

  Locale get locale => _locale;

  LocaleService() {
    _loadLocale();
  }

  Future<void> _loadLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final languageCode = prefs.getString('languageCode') ?? 'en';
    _locale = Locale(languageCode);
    notifyListeners();
  }

  Future<void> setLocale(Locale locale) async {
    if (_locale == locale) return;

    _locale = locale;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('languageCode', locale.languageCode);
    notifyListeners();
  }

  void toggleLanguage() {
    if (_locale.languageCode == 'en') {
      setLocale(const Locale('ar'));
    } else {
      setLocale(const Locale('en'));
    }
  }

  bool get isArabic => _locale.languageCode == 'ar';
  bool get isEnglish => _locale.languageCode == 'en';

  // Get currency symbol based on locale
  String get currencySymbol => isArabic ? 'ر.س' : 'SAR';

  // Format currency with proper symbol
  String formatCurrency(double amount) {
    final formatted = amount.toStringAsFixed(0);
    if (isArabic) {
      return '$formatted ر.س';
    } else {
      return 'SAR $formatted';
    }
  }
}