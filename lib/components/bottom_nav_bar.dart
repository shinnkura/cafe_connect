import 'package:cafe_connect/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

// ignore: must_be_immutable
class MyBottomNavBar extends StatelessWidget {
  MyBottomNavBar({
    super.key,
    required this.onTabChange,
  });

  void Function(int)? onTabChange;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: GNav(
        // color: Colors.grey[400],
        color: kTextColor,
        // activeColor: Colors.grey.shade700,
        activeColor: Colors.white,
        tabActiveBorder: Border.all(color: Colors.white),
        // tabBackgroundColor: Colors.grey.shade100,
        tabBackgroundColor: Colors.white,
        mainAxisAlignment: MainAxisAlignment.center,
        tabBorderRadius: 16,
        onTabChange: (value) => onTabChange?.call(value),
        tabs: [
          GButton(
            backgroundColor: Colors.brown,
            icon: Icons.home,
            text: 'Home',
          ),
          GButton(
            backgroundColor: Colors.brown,
            icon: Icons.border_color_outlined,
            text: 'Order List',
          ),
        ],
      ),
    );
  }
}
