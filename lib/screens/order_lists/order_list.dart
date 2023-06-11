import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants.dart';
import '../edito_order_pages/edit_order_page.dart';

class OrderListPage extends StatefulWidget {
  const OrderListPage({Key? key}) : super(key: key);

  @override
  _OrderListPageState createState() => _OrderListPageState();
}

class _OrderListPageState extends State<OrderListPage> {
  Future<Map<String, Map<String, List<String>>>> loadOrder() async {
    final prefs = await SharedPreferences.getInstance();
    Map<String, Map<String, List<String>>> orders = {};
    List<String>? orderListString = prefs.getStringList('orderList');
    if (orderListString != null) {
      for (String orderString in orderListString) {
        Map<String, dynamic> order = jsonDecode(orderString);
        String time = order['time'];
        String coffeeType = order['coffeeType'];
        String name = order['name'];
        if (orders[time] == null) {
          orders[time] = {};
        }
        if (orders[time]![coffeeType] == null) {
          orders[time]![coffeeType] = [];
        }
        orders[time]![coffeeType]!.add(name);
      }
    }
    return orders;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: const Text('Order List'),
      ),
      body: FutureBuilder<Map<String, Map<String, List<String>>>>(
          future: loadOrder(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Center(child: Text('エラーが発生しました'));
            } else {
              Map<String, Map<String, List<String>>> orders = snapshot.data!;
              return ListView.builder(
                itemCount: orders.length,
                itemBuilder: (context, index) {
                  String time = orders.keys.elementAt(index);
                  int totalOrdersAtThisTime = orders[time]!
                      .values
                      .fold(0, (prev, curr) => prev + curr.length);
                  return ExpansionTile(
                    title: Text('$time     $totalOrdersAtThisTime名',
                        style:
                            TextStyle(color: Colors.brown[800], fontSize: 20)),
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
                              Divider(color: Colors.brown[800]),
                              ...names.map((name) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => EditOrderPage(
                                          name: name,
                                          initialCoffeeType: coffeeType,
                                          initialTime: time,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Text(
                                      name,
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.brown[700]),
                                    ),
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
              );
            }
          }),
      floatingActionButton: ElevatedButton(
        onPressed: () {
          Navigator.popUntil(context, (route) => route.isFirst);
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
            kPrimaryColor,
          ),
        ),
        child: const Text('ホームに戻る'),
      ),
    );
  }
}
