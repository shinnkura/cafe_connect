import 'package:flutter/material.dart';
import 'package:cafe_connect/constants.dart';
import 'package:cafe_connect/screens/home/my_home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  // const MyApp(Key? key) : super(key: key);
  const MyApp({super.key});

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
                ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const MyHomePage(
        title: 'Coffee Order Tracker',
        key: Key('home'),
      ),
    );
  }
}
