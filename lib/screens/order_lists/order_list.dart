import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../edito_order_pages/edit_order_page.dart';
import '../order_screen/components/custom_app_bar.dart';
import '../order_screen/components/custom_elevated_button.dart';
import 'components/order_loader.dart';

class OrderListPage extends StatefulWidget {
  const OrderListPage({Key? key}) : super(key: key);

  @override
  _OrderListPageState createState() => _OrderListPageState();
}

class _OrderListPageState extends State<OrderListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Order List'),
      body: FutureBuilder<Map<String, Map<String, List<Map<String, dynamic>>>>>(
          future: loadOrder(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('エラーが発生しました: ${snapshot.error}'));
            } else {
              Map<String, Map<String, List<Map<String, dynamic>>>> orders =
                  snapshot.data!;
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
                      List<Map<String, dynamic>> ordersList = entry.value;
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
                                '$coffeeType     ${ordersList.length}名',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Colors.brown[800]),
                              ),
                              Divider(color: Colors.brown[800]),
                              ...ordersList.map((order) {
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    IconButton(
                                      icon: Icon(Icons.edit,
                                          color: Colors.brown[700]),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => EditOrderPage(
                                              name: order['name'],
                                              initialCoffeeType: coffeeType,
                                              initialTime: time,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                    SizedBox(width: 5),
                                    Text.rich(
                                      TextSpan(
                                        children: [
                                          TextSpan(
                                            text: '${order['name']}',
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.brown[700],
                                            ),
                                          ),
                                          TextSpan(
                                            text:
                                                '${order['isSugar'] ? '   砂糖' : ''}',
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.red,
                                            ),
                                          ),
                                          TextSpan(
                                            text:
                                                '${order['isPickupOn4thFloor'] ? '   4階で受け取る' : ''}',
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.blue,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
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
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(30),
            child: FloatingActionButton(
              onPressed: () async {
                const url = 'https://forms.gle/s9BVLxoujXDQy4fv8';
                if (await canLaunchUrl(Uri.parse(url))) {
                  await launchUrl(Uri.parse(url));
                } else {
                  throw 'Could not launch $url';
                }
              },
              backgroundColor: Colors.brown[500],
              heroTag: null,
              child: Icon(Icons.mail),
            ),
          ),
          SizedBox(height: 10),
          CustomElevatedButton(
            onPressed: () {
              Navigator.popUntil(context, (route) => route.isFirst);
            },
            text: 'ホームに戻る',
          ),
        ],
      ),
    );
  }
}
