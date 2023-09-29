import 'package:flutter/material.dart';

import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';
import 'package:cafe_connect/screens/order_page.dart';
import 'package:cafe_connect/screens/order_list.dart';
import 'constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    const MyApp(),
  );
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Lottie.network(
        'https://lottie.host/c377cb11-db7c-441f-b444-683224969d58/TfSIr1spOc.json',
        height: 250,
        width: 250,
      ),
      nextScreen: const OrderPage(),
      splashIconSize: 250,
      duration: 1000,
      splashTransition: SplashTransition.fadeTransition,
      pageTransitionType: PageTransitionType.leftToRightWithFade,
      animationDuration: const Duration(milliseconds: 1500),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Coffee Order',
      theme: _buildThemeData(context),
      home: const SplashScreen(),
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
                  fontSize: 24,
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
