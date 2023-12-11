import 'package:flutter/material.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget mobileLayout;
  final Widget desktopLayout;

  const ResponsiveLayout({
    Key? key,
    required this.mobileLayout,
    required this.desktopLayout,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 画面の幅を取得
    double width = MediaQuery.of(context).size.width;

    // 画面幅に応じてレイアウトを切り替え
    return width < 600 ? mobileLayout : desktopLayout;
  }
}
