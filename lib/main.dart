import 'package:cafe_connect/screens/order_pages/order_page.dart';
import 'package:cafe_connect/screens/order_list_pages/order_list_page.dart';
import 'package:cafe_connect/screens/home/home_screen.dart';
import 'package:flutter/material.dart';

import 'constants.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Coffee Order',
      theme: ThemeData(
        scaffoldBackgroundColor: kBackgroundColor,
        primaryColor: kBackgroundColor,
        textTheme:
            Theme.of(context).textTheme.apply(bodyColor: kTextColor).copyWith(
                  bodyMedium: const TextStyle(
                    color: kTextColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                  titleMedium: const TextStyle(color: kTextColor),
                ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeScreen(),
      routes: {
        '/order': (context) => const OrderPage(
              key: Key('order'),
              title: 'Coffee Order',
            ),
        '/orderList': (context) => OrderListPage(),
      },
    );
  }
}
