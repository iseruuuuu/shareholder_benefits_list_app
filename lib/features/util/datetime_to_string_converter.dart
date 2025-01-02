extension DateTimeFormatting on DateTime {
  String toShortDateString() =>
      "${year.toString().padLeft(4, '0')}-${month.toString().padLeft(2, '0')}-${day.toString().padLeft(2, '0')}";
}
