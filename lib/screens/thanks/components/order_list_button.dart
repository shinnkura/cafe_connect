import 'package:flutter/material.dart';

import '../../order_list/order_list_page.dart';

class OrderListButton extends StatelessWidget {
  const OrderListButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Colors.brown[800], // background
        onPrimary: Colors.white, // foreground
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const OrderListPage()),
        );
      },
      child: const Text('注文一覧へ'),
    );
  }
}
