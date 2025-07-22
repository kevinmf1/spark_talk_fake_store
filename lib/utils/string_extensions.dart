import 'dart:ui';

extension CapitalizeEachWord on String {
  String capitalizeEachWord() {
    return split(' ')
        .map((word) => word.isNotEmpty
            ? '${word[0].toUpperCase()}${word.substring(1).toLowerCase()}'
            : '')
        .join(' ');
  }
}

extension CapitalizeFirstSentence on String {
  String capitalizeFirstSentence() {
    if (isEmpty) return this;
    int firstPeriod = indexOf('.');
    if (firstPeriod == -1) firstPeriod = length;
    String firstSentence = substring(0, firstPeriod).trimLeft();
    if (firstSentence.isEmpty) return this;
    String capitalized = firstSentence[0].toUpperCase() + firstSentence.substring(1);
    return capitalized + substring(firstSentence.length);
  }
}

Color parseColor(String hex) {
  return Color.fromRGBO(
    int.parse(hex.substring(1, 3), radix: 16),
    int.parse(hex.substring(3, 5), radix: 16),
    int.parse(hex.substring(5, 7), radix: 16),
    1.0,
  );
}

Map<String, List<Color>> getCategoryBadgeStyle(String category) {
  switch (category) {
    case "men's clothing":
      return {
        'background': [parseColor("#DBEAFE")],
        'text': [parseColor("#1D4ED8")]
      };
    case "jewelery":
      return {
        'background': [parseColor("#FEF3C7")],
        'text': [parseColor("#D97706")]
      };
    case "electronics":
      return {
        'background': [parseColor("#DCFCE7")],
        'text': [parseColor("#16A34A")]
      };
    case "women's clothing":
      return {
        'background': [parseColor("#FCE7F3")],
        'text': [parseColor("#BE185D")]
      };
    default:
      return {
        'background': [parseColor("#F3F4F6")],
        'text': [parseColor("#374151")]
      };
  }
}