import 'package:cafe_connect/screens/order_list.dart';
import 'package:flutter/material.dart';

import '../components/bottom_nav_bar.dart';
import 'order_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // ページのインデックスを追跡する
  int _selectedIndex = 0;

  // ページのインデックスを変更する
  void navigateBottomNavBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // ページのインデックスに応じて、ページを表示する
  final List<Widget> _pages = [
    const OrderPage(
      key: Key('order'),
      title: 'Coffee Order',
    ),
    const OrderListPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: MyBottomNavBar(
        onTabChange: (index) => navigateBottomNavBar(index),
      ),
    );
  }
}
