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