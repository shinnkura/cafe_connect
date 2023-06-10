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

// class OrderListPage extends StatelessWidget {
//   // Dummy data for demonstration
//   final Map<String, Map<String, List<String>>> orders = {
//     '15時': {
//       'コーヒー': ['John', 'Alice'],
//       'ふわふわカフェオレ': ['Bob'],
//       'カフェオレ': ['Charlie', 'David'],
//     },
//     '17時': {
//       'コーヒー': ['Eve', 'Frank'],
//       'ふわふわカフェオレ': ['Grace'],
//       'カフェオレ': ['Heidi', 'Ivan'],
//     },
//   };

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: kPrimaryColor,
//         title: Text('Order List'),
//       ),
//       body: ListView.builder(
//         itemCount: orders.length,
//         itemBuilder: (context, index) {
//           String time = orders.keys.elementAt(index);
//           return ExpansionTile(
//             title: Text(time),
//             children: orders[time]!.entries.map((entry) {
//               String coffeeType = entry.key;
//               List<String> names = entry.value;
//               return ExpansionTile(
//                 title: Text(coffeeType),
//                 children: names.map((name) {
//                   return ListTile(
//                     title: Text(name),
//                   );
//                 }).toList(),
//               );
//             }).toList(),
//           );
//         },
//       ),
//     );
//   }
// }

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
          return ExpansionTile(
            title: Text(time),
            children: orders[time]!.entries.map((entry) {
              String coffeeType = entry.key;
              List<String> names = entry.value;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0, top: 8.0),
                    child: Text(
                      coffeeType,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  ...names.map((name) {
                    return ListTile(
                      title: Text(name),
                    );
                  }).toList(),
                ],
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
