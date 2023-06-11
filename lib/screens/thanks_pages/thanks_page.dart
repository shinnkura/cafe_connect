import 'package:flutter/material.dart';

import '../order_lists/order_list.dart';

class ThanksPage extends StatelessWidget {
  const ThanksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                'いつも、ありがとうございます!',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.brown[800]),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'ご注文を承りました',
              style: TextStyle(fontSize: 20, color: Colors.brown[700]),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.brown[800], // foreground
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const OrderListPage()),
                );
              },
              child: const Text('注文一覧へ'),
            ),
          ],
        ),
      ),
    );
  }
}
