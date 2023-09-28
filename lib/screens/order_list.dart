import 'package:cafe_connect/components/custom_drawer.dart';
import 'package:cafe_connect/constants.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../components/order_loader.dart';
import 'edit_order_page.dart';

class OrderListPage extends StatefulWidget {
  const OrderListPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _OrderListPageState createState() => _OrderListPageState();
}

class _OrderListPageState extends State<OrderListPage> {
  Future<Map<String, Map<String, List<Map<String, dynamic>>>>>? _orderFuture;

  final Map<String, String> coffeeImages = {
    'コーヒー':
        'https://images.unsplash.com/photo-1634913564795-7825a3266590?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1740&q=80',
    'カフェオレ':
        'https://images.unsplash.com/photo-1484244619813-7dd17c80db4c?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1170&q=80',
    'ふわふわ\nカフェオレ':
        'https://images.unsplash.com/photo-1585494156145-1c60a4fe952b?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=774&q=80',
    'アイスコーヒー\n（水出し）':
        'https://images.unsplash.com/photo-1499961024600-ad094db305cc?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1740&q=80',
    'アイスコーヒー\n(急冷式)':
        'https://images.unsplash.com/photo-1517959105821-eaf2591984ca?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1746&q=80',
    'アイス\nカフェオレ':
        'https://images.unsplash.com/photo-1461023058943-07fcbe16d735?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1738&q=80',
    'アイス\nカフェオレ\n（ミルク多め）':
        'https://images.unsplash.com/photo-1553909489-ec2175ef3f52?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=930&q=80',
    'ソイラテ':
        'https://images.unsplash.com/photo-1608651057580-4a50b2fc2281?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=774&q=80',
    'アイスソイラテ':
        'https://images.unsplash.com/photo-1471691118458-a88597b4c1f5?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1740&q=80',
    '緑茶':
        'https://images.unsplash.com/photo-1627435601361-ec25f5b1d0e5?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1170&q=80',
    '緑茶（アイス）':
        'https://images.unsplash.com/photo-1455621481073-d5bc1c40e3cb?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1324&q=80',
    '抹茶ラテ':
        'https://images.unsplash.com/photo-1515823064-d6e0c04616a7?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1742&q=80',
    'アイス抹茶ラテ':
        'https://images.unsplash.com/photo-1634473115412-8fa5b647ef59?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1974&q=80',
  };

  @override
  void initState() {
    super.initState();
    _orderFuture = loadOrder();
  }

  Future<void> _refreshOrder() async {
    setState(() {
      _orderFuture = loadOrder();
    });
  }

  // 削除処理を行うメソッド
  Future<void> _deleteOrder(String name, String coffeeType, String time) async {
    CollectionReference orders =
        FirebaseFirestore.instance.collection('orders');

    // 特定の条件に一致するドキュメントを検索
    Query query = orders
        .where('name', isEqualTo: name)
        .where('coffeeType', isEqualTo: coffeeType)
        .where('time', isEqualTo: time);

    QuerySnapshot querySnapshot = await query.get();

    // ドキュメントが存在する場合、削除
    if (querySnapshot.docs.isNotEmpty) {
      querySnapshot.docs.first.reference.delete();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        title: const Text(
          'ご注文',
          style: TextStyle(
            fontSize: 24.0,
            color: kTextColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0.0,
        // iconカラーを変更
        iconTheme: const IconThemeData(color: kTextColor),
      ),
      drawer: const CustomDrawer(),
      body: RefreshIndicator(
        onRefresh: _refreshOrder,
        child:
            FutureBuilder<Map<String, Map<String, List<Map<String, dynamic>>>>>(
          future: _orderFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              // print(snapshot.error);
              return Center(child: Text('エラーが発生しました: ${snapshot.error}'));
            } else {
              Map<String, Map<String, List<Map<String, dynamic>>>> orders =
                  snapshot.data!;
              Map<String, Map<String, List<Map<String, dynamic>>>> ordersMap =
                  orders;
              return ListView.builder(
                itemCount: orders.length,
                itemBuilder: (context, index) {
                  String time = orders.keys.elementAt(index);
                  int totalOrdersAtThisTime = orders[time]!
                      .values
                      .fold(0, (prev, curr) => prev + curr.length);
                  return ExpansionTile(
                    collapsedIconColor: kTextColor,
                    iconColor: kTextColor,
                    title: Text(
                      '$time     $totalOrdersAtThisTime名',
                      style: const TextStyle(
                        color: kTextColor,
                        fontSize: 24,
                      ),
                    ),
                    children: orders[time]!.entries.map((entry) {
                      String coffeeType = entry.key;
                      List<Map<String, dynamic>> ordersList = entry.value;
                      return Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20.0,
                                  vertical: 4.0,
                                ),
                                child: Text(
                                  '$coffeeType     ${ordersList.length}名',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: kTextColor,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ],
                          ),
                          ...ordersList.map((order) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EditOrderPage(
                                      name: order['name'],
                                      initialCoffeeType: coffeeType,
                                      initialTime: time,
                                      initialIsIce: order['isIce'],
                                      initialIsSugar: order['isSugar'],
                                      initialCaramel: order['caramel'],
                                      initialIsCondecensedMilk:
                                          order['isCondecensedMilk'],
                                      initialSmall: order['small'],
                                      initialIsPickupOn4thFloor:
                                          order['isPickupOn4thFloor'],
                                    ),
                                  ),
                                );
                              },
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                elevation: 10,
                                margin: const EdgeInsets.symmetric(
                                  vertical: 8.0,
                                  horizontal: 16.0,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width: 80,
                                        height: 60,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: CachedNetworkImage(
                                            imageUrl:
                                                coffeeImages[coffeeType] ?? '',
                                            placeholder: (context, url) =>
                                                const CircularProgressIndicator(),
                                            errorWidget:
                                                (context, url, error) =>
                                                    const Icon(Icons.error),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 16.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                '${order['name']}',
                                                style: const TextStyle(
                                                  fontSize: 15,
                                                  color: kTextColor,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Wrap(
                                                children: [
                                                  Text(
                                                    order['isIce'] ? '氷あり' : '',
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.blue[300],
                                                    ),
                                                  ),
                                                  Text(
                                                    order['small'] ? '少なめ' : '',
                                                    style: const TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.orange,
                                                    ),
                                                  ),
                                                  Text(
                                                    order['isSugar']
                                                        ? '砂糖'
                                                        : '',
                                                    style: const TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.red,
                                                    ),
                                                  ),
                                                  Text(
                                                    order['caramel']
                                                        ? 'キャラメル'
                                                        : '',
                                                    style: const TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.purple,
                                                    ),
                                                  ),
                                                  Text(
                                                    order['isCondecensedMilk']
                                                        ? '練乳'
                                                        : '',
                                                    style: const TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.blue,
                                                    ),
                                                  ),
                                                  Text(
                                                    order['isPickupOn4thFloor']
                                                        ? '4階受取'
                                                        : '',
                                                    style: const TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.green,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.red[400],
                                            borderRadius:
                                                BorderRadius.circular(50.0),
                                          ),
                                          child: IconButton(
                                            icon: const Icon(
                                              Icons.clear,
                                              color: Colors.white,
                                            ),
                                            onPressed: () async {
                                              // 確認ダイアログを表示
                                              final bool? result =
                                                  await showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    title: const Text("確認"),
                                                    content: Text(
                                                        "${order['name']}さんの注文を削除してもよろしいですか？"),
                                                    actions: [
                                                      TextButton(
                                                        onPressed: () =>
                                                            Navigator.of(
                                                                    context)
                                                                .pop(false),
                                                        child:
                                                            const Text("キャンセル"),
                                                      ),
                                                      TextButton(
                                                        onPressed: () =>
                                                            Navigator.of(
                                                                    context)
                                                                .pop(true),
                                                        child: const Text("削除"),
                                                      ),
                                                    ],
                                                  );
                                                },
                                              );

                                              // ユーザーが「削除」を選択した場合
                                              if (result == true) {
                                                await _deleteOrder(
                                                    order['name'],
                                                    coffeeType,
                                                    time);
                                                setState(() {
                                                  ordersMap[time]![coffeeType]!
                                                      .remove(order);
                                                  if (ordersMap[time]![
                                                          coffeeType]!
                                                      .isEmpty) {
                                                    ordersMap[time]!
                                                        .remove(coffeeType);
                                                    if (ordersMap[time]!
                                                        .isEmpty) {
                                                      ordersMap.remove(time);
                                                    }
                                                  }
                                                });
                                              }
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ],
                      );
                    }).toList(),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
