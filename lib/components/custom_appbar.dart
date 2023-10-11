import 'package:flutter/material.dart';
import 'package:cafe_connect/config/constants.dart';

// AppBarをカスタムウィジェットとして作成する場合、そのウィジェットはPreferredSizeWidgetを実装する必要があります
class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String titleText;

  const CustomAppbar({super.key, required this.titleText});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: kBackgroundColor,
      title: Text(
        titleText,
        style: const TextStyle(
          fontSize: 24.0,
          color: kTextColor,
          fontWeight: FontWeight.bold,
        ),
      ),
      elevation: 0.0,
      iconTheme: const IconThemeData(color: kTextColor),
    );
  }

  // PreferredSizeWidgetの要件として、preferredSizeプロパティをオーバーライドする
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
