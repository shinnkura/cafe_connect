import 'package:flutter/material.dart';

class OrderChangeText extends StatelessWidget {
  final String name;

  const OrderChangeText({required this.name});

  @override
  Widget build(BuildContext context) {
    return Text(
      '$nameさんのご注文を変更します',
      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    );
  }
}