import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:cafe_connect/constants.dart';

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
      margin: const EdgeInsets.all(10), // コンテナ全体にマージンを追加
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
      decoration: BoxDecoration(
        color: kPrimaryColor, // Nav barの背景色を茶色に設定
        borderRadius: BorderRadius.circular(30), // 角を丸くする
        boxShadow: [
          // 影を追加
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: GNav(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        color: Colors.white60,
        activeColor: Colors.white,
        tabBackgroundColor: kPrimaryLightColor,
        mainAxisAlignment: MainAxisAlignment.center,
        tabBorderRadius: 20,
        onTabChange: (value) => onTabChange?.call(value),
        tabs: const [
          GButton(
            icon: Icons.home,
            text: 'Home',
            gap: 10, // アイコンとnav barの間に余白を設ける
          ),
          GButton(
            icon: Icons.border_color_outlined,
            text: 'Order List',
            gap: 10, // アイコンとnav barの間に余白を設ける
          ),
        ],
      ),
    );
  }
}
