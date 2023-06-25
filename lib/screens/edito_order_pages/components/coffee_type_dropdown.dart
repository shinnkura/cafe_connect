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
        'カフェオレ',
        'ちょいふわカフェオレ',
        'ふわふわカフェオレ',
        'アイスコーヒー（水出し）',
        'アイスコーヒー(急冷式)',
        'アイスカフェオレ',
        'アイスカフェオレ（ミルク多め）',
        '温かい緑茶',
        '温かい紅茶（茶葉は日替わり）',
        '冷たい緑茶',
        '冷たい紅茶（茶葉は日替わり）',
      ].map<DropdownMenuItem<String>>((value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
