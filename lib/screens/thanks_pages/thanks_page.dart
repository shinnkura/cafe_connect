import 'package:flutter/material.dart';

import '../order_list_pages/order_list_page.dart';

class ThanksPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'いつも、ありがとうございます!',
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.brown[800]),
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
                  MaterialPageRoute(builder: (context) => OrderListPage()),
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
