import 'package:cafe_connect/screens/home/my_home_page.dart';
import 'package:flutter/material.dart';

import 'constants.dart';
import 'screens/order_list_pages/order_list_page.dart';
import 'screens/top_pages/top_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Coffee Order Tracker',
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
      home: TopPage(), // Changed from MyHomePage to TopPage
      routes: {
        '/home': (context) => const MyHomePage(
              title: 'Coffee Order Tracker',
              key: Key('home'),
            ),
        '/orderList': (context) => OrderListPage(),
      },
    );
  }
}
