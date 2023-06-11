import 'package:flutter/material.dart';

class GreetingText extends StatelessWidget {
  const GreetingText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text(
      'いつも、お疲れ様です！',
      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    );
  }
}
