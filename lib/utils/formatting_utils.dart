// lib/utils/formatting_utils.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../gen_l10n/app_localizations.dart';

class FormattingUtils {
  /// Format currency based on locale
  /// For Arabic: shows "ريال ١٠٠"
  /// For English: shows "SAR 100"
  static String formatCurrency(double amount, AppLocalizations l10n, Locale locale) {
    final formattedAmount = amount.toStringAsFixed(0);

    if (locale.languageCode == 'ar') {
      // Arabic: "ريال ١٠٠" (with Eastern Arabic numerals)
      return 'ريال ${_toArabicNumerals(formattedAmount)}';
    } else {
      // English: "SAR 100"
      return 'SAR $formattedAmount';
    }
  }

  /// Format numbers based on locale (Arabic/Eastern Arabic numerals or Western)
  static String formatNumber(int number, Locale locale) {
    if (locale.languageCode == 'ar') {
      // Convert to Eastern Arabic numerals
      return _toArabicNumerals(number.toString());
    }
    return number.toString();
  }

  /// Helper method to convert Western numerals to Eastern Arabic numerals
  static String _toArabicNumerals(String input) {
    final arabicNumerals = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];
    return input.split('').map((digit) {
      if (digit.contains(RegExp(r'[0-9]'))) {
        return arabicNumerals[int.parse(digit)];
      }
      return digit;
    }).join();
  }

  /// Format date with custom format
  static String formatDate(BuildContext context, DateTime date, String format) {
    final locale = Localizations.localeOf(context).toString();
    final formatted = DateFormat(format, locale).format(date);

    // Convert numbers to Arabic numerals if locale is Arabic
    if (Localizations.localeOf(context).languageCode == 'ar') {
      return _toArabicNumerals(formatted);
    }
    return formatted;
  }

  // Helper for common date formats
  static String formatDateLong(BuildContext context, DateTime date) {
    return formatDate(context, date, 'EEEE, MMMM d, y');
  }

  static String formatDateShort(BuildContext context, DateTime date) {
    return formatDate(context, date, 'MMM d, y');
  }
}