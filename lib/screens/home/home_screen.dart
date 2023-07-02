import 'package:flutter/material.dart';
import '../order_lists/components/custom_elevated_button.dart';
import 'components/greeting_text.dart';
import 'components/order_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Coffee Order'),
        backgroundColor: Colors.brown,
      ),
      body: Center(
        child: ListView(
          // mainAxisAlignment: MainAxisAlignment.center,
          padding: const EdgeInsets.all(8),
          children: <Widget>[
            const GreetingText(),
            const SizedBox(height: 20),
            const OrderButton(),
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/orderList');
                },
                text: '注文一覧',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
