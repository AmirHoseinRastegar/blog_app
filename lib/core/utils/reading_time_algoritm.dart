int readingTimeCalculator(String content) {
  final wprdsCount = content.split(RegExp(r'\s+')).length;
  final readingTime = wprdsCount / 250;
  return readingTime.ceil();
}
