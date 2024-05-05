import 'package:cafe_connect/components/responsive_layout.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';

import 'config/firebase_options.dart';
import 'package:cafe_connect/screens/order_page.dart';
import 'package:cafe_connect/screens/order_list.dart';
import 'config/constants.dart';
import 'screens/admin_page.dart';
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
      theme: _buildThemeData(context),
      home: const ResponsiveLayout(
        mobileLayout: MobileLayout(),
        desktopLayout: DesktopLayout(),
      ),
    );
  }

  ThemeData _buildThemeData(BuildContext context) {
    return ThemeData(
      scaffoldBackgroundColor: kBackgroundColor,
      primaryColor: kBackgroundColor,
      textTheme:
          Theme.of(context).textTheme.apply(bodyColor: kTextColor).copyWith(
                bodyMedium: const TextStyle(
                  color: kTextColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                titleMedium: const TextStyle(color: kTextColor),
              ),
      visualDensity: VisualDensity.adaptivePlatformDensity,
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

// モバイルレイアウト用のウィジェット
class MobileLayout extends StatefulWidget {
  const MobileLayout({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MobileLayoutState createState() => _MobileLayoutState();
}

class _MobileLayoutState extends State<MobileLayout> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    OrderPage(),
    OrderListPage(),
    BulletinBoard(),
  ];

  void _onItemTapped(int index) async {
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
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Simple Coffee',
          style: TextStyle(color: Colors.black),
        ),
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
  }
}

// デスクトップレイアウト用のウィジェット
class DesktopLayout extends StatefulWidget {
  const DesktopLayout({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _DesktopLayoutState createState() => _DesktopLayoutState();
}

class _DesktopLayoutState extends State<DesktopLayout> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    OrderPage(),
    OrderListPage(),
    BulletinBoard(),
    // AdminPage(),
  ];

  void _onItemTapped(int index) async {
    setState(() {
      _selectedIndex = index;
    });
  }

  // 管理者ページへのアクセスを試みる
  Future<void> _tryAccessAdmin() async {
    bool isAdmin = await _showPasswordDialog(context);
    if (isAdmin) {
      // ignore: use_build_context_synchronously
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (_) => const AdminPage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Simple Coffee',
          style: TextStyle(color: Colors.black),
        ),
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
            selectedIconTheme: IconThemeData(color: Colors.amber[800]),
            selectedLabelTextStyle: TextStyle(color: Colors.amber[800]),
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
          Expanded(
            child: _widgetOptions.elementAt(_selectedIndex),
          ),
        ],
      ),
    );
  }
}
