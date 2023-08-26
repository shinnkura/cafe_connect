import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lottie/lottie.dart';

import '../constants.dart';
import '../components/custom_elevated_button.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({required Key key, required this.title}) : super(key: key);

  final String title;

  @override
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
        .then((value) => print("Order Added"))
        .catchError((error) => print("Failed to add order: $error"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Image.network(
            'https://images.unsplash.com/photo-1509042239860-f550ce710b93?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80',
            width: double.infinity,
            height: 500.0,
            fit: BoxFit.cover,
          ),
          SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.only(top: 150.0),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                boxShadow: [
                  BoxShadow(
                    blurRadius: 4.0,
                    color: Color(0x320E151B),
                    offset: Offset(0.0, -2.0),
                  )
                ],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40.0),
                  topRight: Radius.circular(40.0),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(15.0),
                child: _buildBody(),
              ),
            ),
          ),
        ],
      ),
    );
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
              Text(
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
                  style: Theme.of(context).textTheme.titleMedium,
                  decoration: InputDecoration(
                    labelStyle: TextStyle(color: kTextColor),
                    filled: true,
                    fillColor: Colors.white,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: kTextColor,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Colors.brown,
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
                    Text(
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
                              child: Text(
                                '15時30分',
                                style: TextStyle(
                                    fontSize: 15.0,
                                    color: timeDropdownValue == '15時30分'
                                        ? Colors.white
                                        : Colors.black),
                              ),
                              onPressed: () {
                                setState(() {
                                  timeDropdownValue = '15時30分';
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: timeDropdownValue == '15時30分'
                                    ? Colors.brown
                                    : Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                padding: EdgeInsets.symmetric(
                                  horizontal: 30,
                                  vertical: 15,
                                ),
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
                              child: Text('17時30分',
                                  style: TextStyle(
                                      fontSize: 15.0,
                                      color: timeDropdownValue == '17時30分'
                                          ? Colors.white
                                          : Colors.black)),
                              onPressed: () {
                                setState(() {
                                  timeDropdownValue = '17時30分';
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: timeDropdownValue == '17時30分'
                                    ? Colors.brown
                                    : Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                padding: EdgeInsets.symmetric(
                                  horizontal: 30,
                                  vertical: 15,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20.0),
              Text(
                'Categories',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    MediaQuery.of(context).size.width > 600
                        ? IconButton(
                            icon: Icon(
                              Icons.arrow_back_ios,
                              color: Colors.brown,
                              size: 30,
                            ),
                            onPressed: () {
                              _controller.animateTo(
                                _controller.offset - 250,
                                duration: Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            },
                          )
                        : Container(),
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
                              "name": "ちょいふわ\nカフェオレ",
                              "image":
                                  "https://images.unsplash.com/photo-1666600638856-dc0fb01c01bc?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1740&q=80"
                            },
                            {
                              "name": "ふわふわ\nカフェオレ",
                              "image":
                                  "https://images.unsplash.com/photo-1585494156145-1c60a4fe952b?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=774&q=80"
                            },
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
                              "name": "ソイラテ",
                              "image":
                                  "https://images.unsplash.com/photo-1608651057580-4a50b2fc2281?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=774&q=80"
                            },
                            {
                              "name": "アイスソイラテ",
                              "image":
                                  "https://images.unsplash.com/photo-1471691118458-a88597b4c1f5?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1740&q=80"
                            },
                            {
                              "name": "緑茶",
                              "image":
                                  "https://images.unsplash.com/photo-1627435601361-ec25f5b1d0e5?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1170&q=80",
                            },
                            {
                              "name": "緑茶（アイス）",
                              "image":
                                  "https://images.unsplash.com/photo-1455621481073-d5bc1c40e3cb?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1324&q=80",
                            },
                          ].map((Map<String, String> item) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Material(
                                color: item['name'] == dropdownValue
                                    ? Colors.brown
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
                                        ? Colors.brown
                                        : null,
                                    child: Container(
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
                    MediaQuery.of(context).size.width > 600
                        ? IconButton(
                            icon: Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.brown,
                              size: 30,
                            ),
                            onPressed: () {
                              _controller.animateTo(
                                _controller.offset + 250,
                                duration: Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            },
                          )
                        : Container(),
                  ],
                ),
              ),
              const SizedBox(height: 20.0),
              Text(
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
                  activeColor: Colors.brown,
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
                  activeColor: Colors.brown,
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
                  activeColor: Colors.brown,
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
                  activeColor: Colors.brown,
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
                  activeColor: Colors.brown,
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
                  activeColor: Colors.brown,
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
                              padding: EdgeInsets.all(20),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    '注文完了',
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 20),
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
                                  SizedBox(height: 20),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text('閉じる'),
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
