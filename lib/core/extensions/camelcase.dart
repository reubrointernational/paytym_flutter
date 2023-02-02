extension StringExtension on String {
  String toCamelCase() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }

  String getType() {
    return substring(length - 3, length);
  }
}
