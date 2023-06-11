import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../constants.dart';
import '../edito_order_pages/edit_order_page.dart';

class OrderListPage extends StatefulWidget {
  const OrderListPage({Key? key}) : super(key: key);

  @override
  _OrderListPageState createState() => _OrderListPageState();
}

class _OrderListPageState extends State<OrderListPage> {
  Future<Map<String, Map<String, List<String>>>> loadOrder() async {
    CollectionReference orders =
        FirebaseFirestore.instance.collection('orders');
    Map<String, Map<String, List<String>>> ordersMap = {};

    QuerySnapshot querySnapshot = await orders.get();
    for (var doc in querySnapshot.docs) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      String time = data['time'];
      String coffeeType = data['coffeeType'];
      String name = data['name'];
      if (ordersMap[time] == null) {
        ordersMap[time] = {};
      }
      if (ordersMap[time]![coffeeType] == null) {
        ordersMap[time]![coffeeType] = [];
      }
      ordersMap[time]![coffeeType]!.add(name);
    }

    return ordersMap;
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
              return Center(child: Text('エラーが発生しました: ${snapshot.error}'));
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
