import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:cafe_connect/constants.dart';
import 'package:cafe_connect/screens/admin_page.dart';
import '../components/custom_elevated_button.dart';
import 'order_list.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({
    Key? key,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final ScrollController _controller = ScrollController();

  String dropdownValue = 'コーヒー';
  String timeDropdownValue = '15時30分';
  bool _isIce = false;
  bool small = false;
  bool _isSugar = false;
  bool caramel = false;
  bool _isCondecensedMilk = false;
  bool _isPickupOn4thFloor = false;

  Future<void> _saveOrder(
    String time,
    String coffeeType,
    String name,
    bool isIce,
    bool small,
    bool isSugar,
    bool caramel,
    bool isCondecensedMilk,
    bool isPickupOn4thFloor,
  ) async {
    CollectionReference orders =
        FirebaseFirestore.instance.collection('orders');
    return orders
        .add({
          'time': time,
          'coffeeType': coffeeType,
          'name': name,
          'isIce': isIce,
          'small': small,
          'isSugar': isSugar,
          'caramel': caramel,
          'isCondecensedMilk': isCondecensedMilk,
          'isPickupOn4thFloor': isPickupOn4thFloor,
        })
        // ignore: avoid_print
        .then((value) => print("Order Added"))
        // ignore: avoid_print
        .catchError((error) => print("Failed to add order: $error"));
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference status =
        FirebaseFirestore.instance.collection('status');

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
      drawer: Drawer(
        backgroundColor: Colors.grey[300],
        elevation: 0,
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            Padding(
              padding: tilePadding,
              child: ListTile(
                leading: const Icon(Icons.home),
                title: Text(
                  'ご 注 文',
                  style: drawerTextColor,
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const OrderPage(),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: tilePadding,
              child: ListTile(
                leading: const Icon(Icons.list_alt),
                title: Text(
                  '本 日 の ご 注 文',
                  style: drawerTextColor,
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const OrderListPage(),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: tilePadding,
              child: ListTile(
                leading: const Icon(Icons.coffee_maker),
                title: Text(
                  'コーヒーメーカー の 使 い 方',
                  style: drawerTextColor,
                ),
                onTap: () {
                  _launchURL();
                },
              ),
            ),
            Padding(
              padding: tilePadding,
              child: ListTile(
                leading: const Icon(Icons.settings),
                title: Text(
                  '管 理 画 面',
                  style: drawerTextColor,
                ),
                onTap: () async {
                  String password = ''; // パスワード変数の初期値を空文字列に設定

                  // パスワード入力ダイアログを表示
                  password = await showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('パスワードを入力してください'),
                            content: TextField(
                              obscureText: true, // パスワードを隠す
                              onChanged: (value) {
                                password = value;
                              },
                            ),
                            actions: <Widget>[
                              TextButton(
                                child: const Text('OK'),
                                onPressed: () {
                                  Navigator.of(context).pop(password);
                                },
                              ),
                            ],
                          );
                        },
                      ) ??
                      ''; // ダイアログがキャンセルされた場合は空文字列を返す

                  // パスワードが正しいかチェック
                  if (password == '1010') {
                    // パスワードが正しければAdminPageに遷移
                    // ignore: use_build_context_synchronously
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AdminPage()),
                    );
                  } else {
                    // パスワードが間違っていればエラーメッセージを表示
                    // ignore: use_build_context_synchronously
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('エラー'),
                          content: const Text('パスワードが間違っています'),
                          actions: <Widget>[
                            TextButton(
                              child: const Text('OK'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: status.doc('shopStatus').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('エラーが発生しました'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          bool isOpen = snapshot.data!.get('isOpen');

          return isOpen ? _buildBody() : const Center(child: Text('本日はお休みです'));
        },
      ),
    );
  }

  _launchURL() async {
    const url =
        'https://iris-paste-aba.notion.site/2359cb056bc2421a9bc9c89a85fcfc64?pvs=4';
    // ignore: deprecated_member_use
    if (await canLaunch(url)) {
      // ignore: deprecated_member_use
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const Text(
                'Name',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: TextFormField(
                  controller: _nameController,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                    labelStyle: const TextStyle(color: Colors.grey),
                    filled: true,
                    fillColor: Colors.grey[100],
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                        color: Colors.grey[400]!,
                        width: 1,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(
                        color: Colors.blue,
                        width: 1,
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'お名前をご記入ください';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    _formKey.currentState!.validate();
                  },
                ),
              ),
              const SizedBox(height: 20.0),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Time',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Material(
                            elevation:
                                timeDropdownValue == '15時30分' ? 10.0 : 0.0,
                            borderRadius: BorderRadius.circular(20),
                            child: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  timeDropdownValue = '15時30分';
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: timeDropdownValue == '15時30分'
                                    ? kPrimaryColor
                                    : Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 30,
                                  vertical: 15,
                                ),
                              ),
                              child: Text(
                                '15時30分',
                                style: TextStyle(
                                    fontSize: 15.0,
                                    color: timeDropdownValue == '15時30分'
                                        ? Colors.white
                                        : Colors.black),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Material(
                            elevation:
                                timeDropdownValue == '17時30分' ? 10.0 : 0.0,
                            borderRadius: BorderRadius.circular(20),
                            child: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  timeDropdownValue = '17時30分';
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: timeDropdownValue == '17時30分'
                                    ? kPrimaryColor
                                    : Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 30,
                                  vertical: 15,
                                ),
                              ),
                              child: Text('17時30分',
                                  style: TextStyle(
                                      fontSize: 15.0,
                                      color: timeDropdownValue == '17時30分'
                                          ? Colors.white
                                          : Colors.black)),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20.0),
              const Text(
                'Drinks',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10.0),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.red[400],
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: const Text(
                    'ホット',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        controller: _controller,
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: <Map<String, String>>[
                            {
                              "name": "コーヒー",
                              "image":
                                  "https://images.unsplash.com/photo-1634913564795-7825a3266590?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1740&q=80"
                            },
                            {
                              "name": "カフェオレ",
                              "image":
                                  "https://images.unsplash.com/photo-1484244619813-7dd17c80db4c?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1170&q=80"
                            },
                            {
                              "name": "ふわふわ\nカフェオレ",
                              "image":
                                  "https://images.unsplash.com/photo-1585494156145-1c60a4fe952b?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=774&q=80"
                            },
                            {
                              "name": "ソイラテ",
                              "image":
                                  "https://images.unsplash.com/photo-1608651057580-4a50b2fc2281?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=774&q=80"
                            },
                            {
                              "name": "緑茶",
                              "image":
                                  "https://images.unsplash.com/photo-1627435601361-ec25f5b1d0e5?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1170&q=80",
                            },
                            // {
                            //   "name": "ティーラテ",
                            //   "image":
                            //       "https://images.unsplash.com/38/QoR8Bv1S2SEqH6UcSJCA_Tea.jpg?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80",
                            // },
                            {
                              "name": "抹茶ラテ",
                              "image":
                                  "https://images.unsplash.com/photo-1515823064-d6e0c04616a7?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1742&q=80",
                            },
                          ].map((Map<String, String> item) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Material(
                                color: item['name'] == dropdownValue
                                    ? kPrimaryColor
                                    : null,
                                elevation:
                                    item['name'] == dropdownValue ? 10.0 : 0.0,
                                borderRadius: BorderRadius.circular(20),
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      dropdownValue = item['name']!;
                                    });
                                  },
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    color: item['name'] == dropdownValue
                                        ? kPrimaryColor
                                        : null,
                                    child: SizedBox(
                                      height: 200,
                                      width: 150,
                                      child: Column(
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                              child: Image.network(
                                                item['image']!,
                                                height: 100,
                                                width: 140,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          ListTile(
                                            title: Text(
                                              item['name']!,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: item['name'] ==
                                                        dropdownValue
                                                    ? Colors.white
                                                    : null,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.blue[400],
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: const Text(
                    'アイス',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        controller: _controller,
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: <Map<String, String>>[
                            {
                              "name": "アイスコーヒー\n（水出し）",
                              "image":
                                  "https://images.unsplash.com/photo-1499961024600-ad094db305cc?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1740&q=80"
                            },
                            {
                              "name": "アイスコーヒー\n(急冷式)",
                              "image":
                                  "https://images.unsplash.com/photo-1517959105821-eaf2591984ca?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1746&q=80"
                            },
                            {
                              "name": "アイス\nカフェオレ",
                              "image":
                                  "https://images.unsplash.com/photo-1461023058943-07fcbe16d735?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1738&q=80"
                            },
                            {
                              "name": "アイス\nカフェオレ\n（ミルク多め）",
                              "image":
                                  "https://images.unsplash.com/photo-1553909489-ec2175ef3f52?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=930&q=80"
                            },
                            {
                              "name": "アイスソイラテ",
                              "image":
                                  "https://images.unsplash.com/photo-1471691118458-a88597b4c1f5?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1740&q=80"
                            },
                            {
                              "name": "緑茶（アイス）",
                              "image":
                                  "https://images.unsplash.com/photo-1455621481073-d5bc1c40e3cb?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1324&q=80",
                            },
                            {
                              "name": "アイス抹茶ラテ",
                              "image":
                                  "https://images.unsplash.com/photo-1634473115412-8fa5b647ef59?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1974&q=80",
                            },
                          ].map((Map<String, String> item) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Material(
                                color: item['name'] == dropdownValue
                                    ? kPrimaryColor
                                    : null,
                                elevation:
                                    item['name'] == dropdownValue ? 10.0 : 0.0,
                                borderRadius: BorderRadius.circular(20),
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      dropdownValue = item['name']!;
                                    });
                                  },
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    color: item['name'] == dropdownValue
                                        ? kPrimaryColor
                                        : null,
                                    child: SizedBox(
                                      height: 200,
                                      width: 150,
                                      child: Column(
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                              child: Image.network(
                                                item['image']!,
                                                height: 100,
                                                width: 140,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          ListTile(
                                            title: Text(
                                              item['name']!,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: item['name'] ==
                                                        dropdownValue
                                                    ? Colors.white
                                                    : null,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20.0),
              const Text(
                'Topping',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: CheckboxListTile(
                  title: const Text("氷あり"),
                  value: _isIce,
                  onChanged: (bool? value) {
                    setState(() {
                      _isIce = value!;
                    });
                  },
                  activeColor: kPrimaryColor,
                  controlAffinity: ListTileControlAffinity.leading,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: CheckboxListTile(
                  title: const Text("砂糖"),
                  value: _isSugar,
                  onChanged: (bool? value) {
                    setState(() {
                      _isSugar = value!;
                    });
                  },
                  activeColor: kPrimaryColor,
                  controlAffinity: ListTileControlAffinity.leading,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: CheckboxListTile(
                  title: const Text("キャラメルシロップ"),
                  value: caramel,
                  onChanged: (bool? value) {
                    setState(() {
                      caramel = value!;
                    });
                  },
                  activeColor: kPrimaryColor,
                  controlAffinity: ListTileControlAffinity.leading,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: CheckboxListTile(
                  title: const Text("練乳"),
                  value: _isCondecensedMilk,
                  onChanged: (bool? value) {
                    setState(() {
                      _isCondecensedMilk = value!;
                    });
                  },
                  activeColor: kPrimaryColor,
                  controlAffinity: ListTileControlAffinity.leading,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: CheckboxListTile(
                  title: const Text("少なめ（250ml程度）"),
                  value: small,
                  onChanged: (bool? value) {
                    setState(() {
                      small = value!;
                    });
                  },
                  activeColor: kPrimaryColor,
                  controlAffinity: ListTileControlAffinity.leading,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: CheckboxListTile(
                  title: const Text("４階で受け取る"),
                  value: _isPickupOn4thFloor,
                  onChanged: (bool? value) {
                    setState(() {
                      _isPickupOn4thFloor = value!;
                    });
                  },
                  activeColor: kPrimaryColor,
                  controlAffinity: ListTileControlAffinity.leading,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: CustomElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _saveOrder(
                        timeDropdownValue,
                        dropdownValue,
                        _nameController.text,
                        _isIce,
                        small,
                        _isSugar,
                        caramel,
                        _isCondecensedMilk,
                        _isPickupOn4thFloor,
                      );

                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Dialog(
                            backgroundColor: Colors.white.withOpacity(0.9),
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Container(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Text(
                                    '注文完了',
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  Lottie.network(
                                    'https://lottie.host/59766007-61be-4bad-af60-b642e632bc9c/xhAatOnIvn.json',
                                    repeat: false,
                                    reverse: false,
                                    animate: true,
                                    width: 200,
                                    height: 200,
                                    fit: BoxFit.fill,
                                    alignment: Alignment.center,
                                  ),
                                  const SizedBox(height: 20),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const OrderListPage(),
                                        ),
                                      );
                                    },
                                    child: const Text('閉じる'),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }
                  },
                  text: '注文',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
