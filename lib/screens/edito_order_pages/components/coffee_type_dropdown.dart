import 'package:flutter/material.dart';

class CoffeeTypeDropdown extends StatelessWidget {
  final String dropdownValue;
  final ValueChanged<String?> onChanged;

  const CoffeeTypeDropdown({
    required this.dropdownValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      onChanged: onChanged,
      items: const [
        'コーヒー',
        'ふわふわラテ',
        'カフェオレ',
        'アイスコーヒー(急冷式)',
        'アイスコーヒー（水出し）',
        'アイスカフェラテ（牛乳７割）',
        'アイスカフェオレ（コーヒー７割）',
      ].map<DropdownMenuItem<String>>((value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
