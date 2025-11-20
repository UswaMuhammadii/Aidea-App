// lib/utils/formatting_utils.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../gen_l10n/app_localizations.dart';

class FormattingUtils {
  static String formatCurrency(double amount, AppLocalizations l10n, Locale locale) {
    if (locale.languageCode == 'ar') {
      return '${l10n.currencySAR} ${amount.toStringAsFixed(2)}';
    } else {
      return '${l10n.currencySAR} ${amount.toStringAsFixed(2)}';
    }
  }

  static String formatNumber(int number, Locale locale) {
    if (locale.languageCode == 'ar') {
      final arabicNumerals = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];
      return number.toString().split('').map((digit) {
        if (digit.contains(RegExp(r'[0-9]'))) {
          return arabicNumerals[int.parse(digit)];
        }
        return digit;
      }).join();
    }
    return number.toString();
  }

  static String formatDate(BuildContext context, DateTime date, String format) {
    final locale = Localizations.localeOf(context).toString();
    return DateFormat(format, locale).format(date);
  }

  // Helper for common date formats
  static String formatDateLong(BuildContext context, DateTime date) {
    return formatDate(context, date, 'EEEE, MMMM d, y');
  }

  static String formatDateShort(BuildContext context, DateTime date) {
    return formatDate(context, date, 'MMM d, y');
  }
}