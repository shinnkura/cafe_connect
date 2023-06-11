import 'package:flutter/material.dart';
import '../../widgets/greeting_text.dart';
import '../../widgets/order_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Coffee Order'),
        backgroundColor: Colors.brown,
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            GreetingText(),
            SizedBox(height: 20),
            OrderButton(),
          ],
        ),
      ),
    );
  }
}
