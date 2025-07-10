import 'package:portfolio_3/models/panel.dart';

extension BoolListExtensions on List<bool> {
  bool only(List<int> trueIndexes) {
    return asMap().entries.every((entry) {
      final index = entry.key;
      final value = entry.value;
      final shouldBeTrue = trueIndexes.contains(index);
      return shouldBeTrue == value;
    });
  }
}

extension PanelListExtensions on List<Panel> {
  bool only(List<int> trueIndexes) {
    return asMap().entries.every((entry) {
      final index = entry.key;
      final value = entry.value.enabled;
      final shouldBeTrue = trueIndexes.contains(index);
      return shouldBeTrue == value;
    });
  }
}
