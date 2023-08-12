import 'dart:collection';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<Map<String, Map<String, List<Map<String, dynamic>>>>> loadOrder() async {
  CollectionReference orders = FirebaseFirestore.instance.collection('orders');
  Map<String, Map<String, List<Map<String, dynamic>>>> ordersMap =
      SplayTreeMap();

  QuerySnapshot querySnapshot = await orders.get();
  for (var doc in querySnapshot.docs) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    String time = data['time'] ?? 'defaultTime';
    String coffeeType = data['coffeeType'] ?? 'defaultCoffeeType';
    String name = data['name'] ?? 'defaultName';
    bool isIce = data['isIce'] ?? false;
    bool small = data['small'] ?? false;
    bool isSugar = data['isSugar'] ?? false;
    bool caramel = data['caramel'] ?? false;
    bool isCondecensedMilk = data['isCondecensedMilk'] ?? false;
    bool isPickupOn4thFloor = data['isPickupOn4thFloor'] ?? false;

    if (ordersMap[time] == null) {
      ordersMap[time] = {};
    }
    if (ordersMap[time]![coffeeType] == null) {
      ordersMap[time]![coffeeType] = [];
    }

    // 同じキーを持つデータが存在する場合、そのデータを更新する
    var existingOrder = ordersMap[time]![coffeeType]!
        .firstWhere((order) => order['name'] == name, orElse: () => {});
    if (existingOrder.isNotEmpty) {
      ordersMap[time]![coffeeType]!.remove(existingOrder);
    }

    ordersMap[time]![coffeeType]!.add({
      'name': name,
      'isIce': isIce,
      'small': small,
      'isSugar': isSugar,
      'caramel': caramel,
      'isCondecensedMilk': isCondecensedMilk,
      'isPickupOn4thFloor': isPickupOn4thFloor,
    });
  }

  return ordersMap;
}
