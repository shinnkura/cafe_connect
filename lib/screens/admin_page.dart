import 'package:cafe_connect/screens/order_page.dart';
import 'package:flutter/material.dart';

class AdminPage extends StatelessWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Page'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const OrderPage(
                      message: '本日はお休みです', isButtonPressed: true)),
            );
          },
          child: const Text('お休みにする'),
        ),
      ),
    );
  }
}
