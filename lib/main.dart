import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'config/firebase_options.dart';
import 'package:cafe_connect/screens/order_page.dart';
import 'package:cafe_connect/screens/order_list.dart';
import 'package:cafe_connect/screens/admin_page.dart';
import 'config/constants.dart';
import 'screens/bullentin_board.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const MyApp(),
  );
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
        textTheme: Theme.of(context).textTheme.apply(bodyColor: kTextColor),
      ),
      home: const UnifiedLayout(),
    );
  }
}

class UnifiedLayout extends StatefulWidget {
  const UnifiedLayout({Key? key}) : super(key: key);

  @override
  _UnifiedLayoutState createState() => _UnifiedLayoutState();
}

class _UnifiedLayoutState extends State<UnifiedLayout> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    OrderPage(),
    OrderListPage(),
    BulletinBoard(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // 管理者ページへのアクセスを試みる
  Future<void> _tryAccessAdmin() async {
    bool isAdmin = await _showPasswordDialog(context);
    if (isAdmin) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (_) => const AdminPage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth < 600) {
          // Mobile layout
          return Scaffold(
            appBar: AppBar(
              title: const Text('Simple Coffee'),
              backgroundColor: Colors.white,
              actions: [
                IconButton(
                  icon: const Icon(Icons.admin_panel_settings),
                  onPressed: _tryAccessAdmin,
                )
              ],
            ),
            body: Center(
              child: _widgetOptions.elementAt(_selectedIndex),
            ),
            bottomNavigationBar: BottomNavigationBar(
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.list),
                  label: 'Orders',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.assignment),
                  label: 'Board',
                ),
              ],
              currentIndex: _selectedIndex,
              selectedItemColor: Colors.amber[800],
              unselectedItemColor: Colors.black,
              onTap: _onItemTapped,
            ),
          );
        } else {
          // Desktop layout
          return Scaffold(
            appBar: AppBar(
              title: const Text('Simple Coffee'),
              backgroundColor: Colors.white,
              actions: [
                IconButton(
                  icon: const Icon(Icons.admin_panel_settings),
                  onPressed: _tryAccessAdmin,
                )
              ],
            ),
            body: Row(
              children: [
                NavigationRail(
                  selectedIndex: _selectedIndex,
                  onDestinationSelected: _onItemTapped,
                  labelType: NavigationRailLabelType.all,
                  destinations: const [
                    NavigationRailDestination(
                      icon: Icon(Icons.home),
                      label: Text('Home'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.list),
                      label: Text('Orders'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.assignment),
                      label: Text('Board'),
                    ),
                  ],
                ),
                const VerticalDivider(thickness: 1, width: 1),
                Expanded(
                  child: _widgetOptions.elementAt(_selectedIndex),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}

Future<bool> _showPasswordDialog(BuildContext context) async {
  String password = '';
  bool isAdmin = false;
  await showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('パスワードを入力してください'),
        content: TextField(
          obscureText: true,
          onChanged: (value) {
            password = value;
          },
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('OK'),
            onPressed: () {
              if (password == '1010') {
                isAdmin = true;
              }
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
  return isAdmin;
}
