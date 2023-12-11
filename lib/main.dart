import 'package:cafe_connect/components/responsive_layout.dart';
import 'package:cafe_connect/screens/seat_chart_page.dart';
import 'package:flutter/material.dart';

// import 'package:lottie/lottie.dart';
// import 'package:page_transition/page_transition.dart';
// import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';

import 'config/firebase_options.dart';
import 'package:cafe_connect/screens/order_page.dart';
import 'package:cafe_connect/screens/order_list.dart';
import 'config/constants.dart';
import 'screens/admin_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    const MyApp(),
  );
}

// class SplashScreen extends StatelessWidget {
//   const SplashScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return AnimatedSplashScreen(
//       splash: Lottie.network(
//         'https://lottie.host/c377cb11-db7c-441f-b444-683224969d58/TfSIr1spOc.json',
//         height: 250,
//         width: 250,
//       ),
//       nextScreen: const OrderPage(),
//       splashIconSize: 250,
//       duration: 1000,
//       splashTransition: SplashTransition.fadeTransition,
//       pageTransitionType: PageTransitionType.leftToRightWithFade,
//       animationDuration: const Duration(milliseconds: 1500),
//     );
//   }
// }

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
      routes: _buildRoutes(),
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

  Map<String, WidgetBuilder> _buildRoutes() {
    return {
      '/order': (context) => const OrderPage(),
      '/orderList': (context) => const OrderListPage(),
    };
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
                // 正しいパスワード
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
    SeatChartPage(),
    AdminPage(),
  ];

  void _onItemTapped(int index) async {
    if (index == 3) {
      bool isAdmin = await _showPasswordDialog(context);
      if (!isAdmin) return;
    }
    setState(() {
      _selectedIndex = index;
    });
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
            icon: Icon(Icons.chair),
            label: 'Seat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Admin',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
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
    SeatChartPage(),
    AdminPage(),
  ];

  void _onItemTapped(int index) async {
    if (index == 3) {
      // Adminページのインデックス
      bool isAdmin = await _showPasswordDialog(context);
      if (!isAdmin) return;
    }
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Simple Coffee'),
        backgroundColor: Colors.white,
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
                icon: Icon(Icons.chair),
                label: Text('Seat'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.settings),
                label: Text('Admin'),
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
