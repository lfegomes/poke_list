extension CapitalizationExtension on String {
  String get capitalize =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1)}' : '';
}
