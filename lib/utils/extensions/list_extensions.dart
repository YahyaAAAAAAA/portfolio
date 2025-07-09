extension ListExtensions on List<bool> {
  bool only(List<int> trueIndexes) {
    return asMap().entries.every((entry) {
      final index = entry.key;
      final value = entry.value;
      final shouldBeTrue = trueIndexes.contains(index);
      return shouldBeTrue == value;
    });
  }
}
