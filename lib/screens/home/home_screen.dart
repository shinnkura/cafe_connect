import 'package:flutter/material.dart';

import '../order_screen/order_screen.dart';

import 'package:firebase_analytics/firebase_analytics.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Coffee Order'),
        backgroundColor: Colors.brown,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'いつも、お疲れ様です！',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Firebase Analyticsのインスタンスを作成
                // FirebaseAnalytics analytics = FirebaseAnalytics();

                // // イベントを記録
                // analytics.logEvent(name: 'button_pressed');

                FirebaseAnalytics.instance.logEvent(
                  name: 'ボタンがおされました',
                );

                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const OrderPage(
                          title: 'Coffee Order', key: Key('order'))),
                );
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                  Colors.brown,
                ),
              ),
              child: const Text('注文を始める'),
            ),
          ],
        ),
      ),
    );
  }
}
