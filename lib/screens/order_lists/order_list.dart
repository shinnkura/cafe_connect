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
                                              name: name,
                                              initialCoffeeType: coffeeType,
                                              initialTime: time,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                    SizedBox(width: 5),
                                    Text(
                                      name,
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.brown[700]),
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
                  // canLaunchからcanLaunchUrlに変更
                  await launchUrl(Uri.parse(url)); // launchからlaunchUrlに変更
                } else {
                  throw 'Could not launch $url';
                }
              },
              backgroundColor: Colors.brown[400],
              heroTag: null, // 同じページ内で複数のFABを使用する場合に必要
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
