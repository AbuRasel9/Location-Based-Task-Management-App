

import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

const String _defaultFormat = 'yyyy-MM-dd';

extension DateTimeExtension on DateTime {
  // Return date and time with specific format
  String format([
    String pattern = _defaultFormat,
    String? locale,
  ]) {
    if (locale != null && locale.isNotEmpty) {
      initializeDateFormatting(locale);
    }
    return DateFormat(pattern, locale).format(this);
  }
}

extension DateTimeExtensionFromString on String {
  // Return date and time with specific format
  String format([
    String pattern = _defaultFormat,
    String? locale,
  ]) {
    DateTime parsedDateTime = DateFormat("MM/dd/yyyy hh:mm:ss a").parse(this);
    if (locale != null && locale.isNotEmpty) {
      initializeDateFormatting(locale);
    }
    return DateFormat(pattern, locale).format(parsedDateTime);
  }
}

extension DateFormatExtension on String? {
  // into a readable format: "dd MMM yyyy, hh:mm a"
  String formatDate({String outputFormat = 'dd MMM yyyy, hh:mm a'}) {
    final dateString = this;
    if (dateString == null || dateString.isEmpty) return '-';
    try {
      // Try ISO format first (e.g., 2025-11-12T13:35:00)
      return DateFormat(outputFormat)
          .format(DateTime.parse(dateString));
    } catch (_) {
      try {
        // Try common API format (e.g., 11/12/2025 1:35:00 PM)
        final parsed =
        DateFormat('MM/dd/yyyy hh:mm:ss a').parse(dateString);
        return DateFormat(outputFormat).format(parsed);
      } catch (_) {
        try {
          // Handle single-digit month/day (e.g., 9/5/2025 1:05:00 PM)
          final parsed =
          DateFormat('M/d/yyyy h:mm:ss a').parse(dateString);
          return DateFormat(outputFormat).format(parsed);
        } catch (_) {
          return dateString; // fallback — return as is
        }
      }
    }
  }
}
