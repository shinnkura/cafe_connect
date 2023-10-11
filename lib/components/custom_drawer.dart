import 'package:cafe_connect/config/constants.dart';
import 'package:cafe_connect/screens/recipe_page/recipe_page.dart';
import 'package:flutter/material.dart';
import 'package:cafe_connect/screens/admin_page.dart';
import 'package:cafe_connect/screens/order_list/order_list.dart';
import 'package:cafe_connect/screens/coffee_maker_description/coffee_maker_description.dart.dart';
import 'package:cafe_connect/screens/order_page/order_page.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.grey[300],
      elevation: 0,
      child: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          Padding(
            padding: tilePadding,
            child: ListTile(
              leading: const Icon(Icons.home),
              title: Text(
                'ご 注 文',
                style: drawerTextColor,
              ),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const OrderPage(),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: tilePadding,
            child: ListTile(
              leading: const Icon(Icons.list_alt),
              title: Text(
                '本 日 の ご 注 文',
                style: drawerTextColor,
              ),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const OrderListPage(),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: tilePadding,
            child: ListTile(
              leading: const Icon(Icons.coffee_maker),
              title: Text(
                'コーヒーメーカー の 使 い 方',
                style: drawerTextColor,
              ),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const CoffeeMakerDescription(),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: tilePadding,
            child: ListTile(
              leading: const Icon(Icons.coffee_maker),
              title: Text(
                'レ シ ピ 一 覧',
                style: drawerTextColor,
              ),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const RecipePage(),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: tilePadding,
            child: ListTile(
              leading: const Icon(Icons.settings),
              title: Text(
                '管 理 画 面',
                style: drawerTextColor,
              ),
              onTap: () async {
                String password = ''; // パスワード変数の初期値を空文字列に設定

                // パスワード入力ダイアログを表示
                password = await showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('パスワードを入力してください'),
                          content: TextField(
                            obscureText: true, // パスワードを隠す
                            onChanged: (value) {
                              password = value;
                            },
                          ),
                          actions: <Widget>[
                            TextButton(
                              child: const Text('OK'),
                              onPressed: () {
                                Navigator.of(context).pop(password);
                              },
                            ),
                          ],
                        );
                      },
                    ) ??
                    ''; // ダイアログがキャンセルされた場合は空文字列を返す

                // パスワードが正しいかチェック
                if (password == '1010') {
                  // パスワードが正しければAdminPageに遷移
                  // ignore: use_build_context_synchronously
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AdminPage()),
                  );
                } else {
                  // パスワードが間違っていればエラーメッセージを表示
                  // ignore: use_build_context_synchronously
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('エラー'),
                        content: const Text('パスワードが間違っています'),
                        actions: <Widget>[
                          TextButton(
                            child: const Text('OK'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
