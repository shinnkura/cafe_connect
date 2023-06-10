import 'package:flutter/material.dart';

import '../../../constants.dart';

class ThanksPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text('Thank You'),
      ),
      body: const Center(
        child: Text(
          'Thank you for your order!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
