import 'package:cafe_connect/screens/order_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AdminPage extends StatelessWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CollectionReference status = FirebaseFirestore.instance.collection('status');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                status.doc('shopStatus').set({'isOpen': false});
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const OrderPage(),
                  ),
                );
              },
              child: const Text('お休みにする'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                status.doc('shopStatus').set({'isOpen': true});
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const OrderPage(),
                  ),
                );
              },
              child: const Text('取り消し'),
            ),
          ],
        ),
      ),
    );
  }
}