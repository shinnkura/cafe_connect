import 'package:flutter/material.dart';
import 'package:cafe_connect/constants.dart';
import 'package:cafe_connect/screens/home/my_home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Coffee Order Tracker',
      theme: ThemeData(
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
      ),
      home: const MyHomePage(
        title: 'Coffee Order Tracker',
        key: Key('home'),
      ),
      routes: {
        '/orderList': (context) => OrderListPage(),
      },
    );
  }
}

class OrderListPage extends StatelessWidget {
  // Dummy data for demonstration
  final Map<String, Map<String, List<String>>> orders = {
    '15時': {
      'コーヒー': ['John', 'Alice'],
      'ふわふわカフェオレ': ['Bob'],
      'カフェオレ': ['Charlie', 'David'],
    },
    '17時': {
      'コーヒー': ['Eve', 'Frank'],
      'ふわふわカフェオレ': ['Grace'],
      'カフェオレ': ['Heidi', 'Ivan'],
    },
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text('Order List'),
      ),
      body: ListView.builder(
        itemCount: orders.length,
        itemBuilder: (context, index) {
          String time = orders.keys.elementAt(index);
          int totalOrdersAtThisTime =
              orders[time]!.values.fold(0, (prev, curr) => prev + curr.length);
          return ExpansionTile(
            title: Text('$time     $totalOrdersAtThisTime名',
                style: TextStyle(color: Colors.brown[800], fontSize: 20)),
            children: orders[time]!.entries.map((entry) {
              String coffeeType = entry.key;
              List<String> names = entry.value;
              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                elevation: 10,
                margin: const EdgeInsets.all(8.0),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '$coffeeType     ${names.length}名',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.brown[800]),
                      ),
                      const Divider(color: kPrimaryColor),
                      ...names.map((name) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            name,
                            style: TextStyle(
                                fontSize: 16, color: Colors.brown[700]),
                          ),
                        );
                      }).toList(),
                    ],
                  ),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}

class ThanksPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Thank You!',
              style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.brown[800]),
            ),
            SizedBox(height: 20),
            Text(
              'Your order has been submitted successfully.',
              style: TextStyle(fontSize: 20, color: Colors.brown[700]),
            ),
            SizedBox(height: 40),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.brown[800], // background
                onPrimary: Colors.white, // foreground
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => OrderListPage()),
                );
              },
              child: Text('View Orders'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.brown[800], // background
                onPrimary: Colors.white, // foreground
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Back to Home'),
            ),
          ],
        ),
      ),
    );
  }
}
