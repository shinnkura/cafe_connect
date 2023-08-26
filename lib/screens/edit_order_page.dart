import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lottie/lottie.dart';

import '../constants.dart';
// import 'thanks_page.dart';
import '../components/coffee_type_dropdown.dart';

class EditOrderPage extends StatefulWidget {
  final String name;
  final String initialCoffeeType;
  final String initialTime;
  final bool initialIsIce;
  final bool initialIsSugar;
  final bool initialCaramel;
  final bool initialIsCondecensedMilk;
  final bool initialSmall;
  final bool initialIsPickupOn4thFloor;

  const EditOrderPage({
    super.key,
    required this.name,
    required this.initialCoffeeType,
    required this.initialTime,
    required this.initialIsIce,
    required this.initialIsSugar,
    required this.initialCaramel,
    required this.initialIsCondecensedMilk,
    required this.initialSmall,
    required this.initialIsPickupOn4thFloor,
  });

  @override
  _EditOrderPageState createState() => _EditOrderPageState();
}

class _EditOrderPageState extends State<EditOrderPage> {
  late TextEditingController _nameController;
  late String dropdownValue;
  late String selectedTime;
  bool isOrderCancelled = false;
  bool isIce = false;
  bool small = false;
  bool isSugar = false;
  bool caramel = false;
  bool isCondecensedMilk = false;
  bool isPickupOn4thFloor = false;

  Future<void> updateOrder() async {
    CollectionReference orders =
        FirebaseFirestore.instance.collection('orders');
    QuerySnapshot querySnapshot = await orders.get();
    for (var doc in querySnapshot.docs) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      if (data['name'] == widget.name &&
          data['coffeeType'] == widget.initialCoffeeType &&
          data['time'] == widget.initialTime) {
        doc.reference.update({
          'name': _nameController.text,
          'coffeeType': dropdownValue,
          'time': selectedTime,
          'isIce': isIce,
          'small': small,
          'isSugar': isSugar,
          'caramel': caramel,
          'isCondecensedMilk': isCondecensedMilk,
          'isPickupOn4thFloor': isPickupOn4thFloor,
        });
        break;
      }
    }
  }

  Future<void> cancelOrder() async {
    CollectionReference orders =
        FirebaseFirestore.instance.collection('orders');
    QuerySnapshot querySnapshot = await orders.get();
    for (var doc in querySnapshot.docs) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      if (data['name'] == widget.name &&
          data['coffeeType'] == widget.initialCoffeeType &&
          data['time'] == widget.initialTime) {
        doc.reference.delete();
        break;
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.name);
    dropdownValue = widget.initialCoffeeType;
    isIce = widget.initialIsIce;
    selectedTime = widget.initialTime;
    isSugar = widget.initialIsSugar;
    caramel = widget.initialCaramel;
    isCondecensedMilk = widget.initialIsCondecensedMilk;
    small = widget.initialSmall;
    isPickupOn4thFloor = widget.initialIsPickupOn4thFloor;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: EdgeInsets.only(left: 16.0),
          child: InkWell(
            borderRadius: BorderRadius.circular(30),
            child: Container(
              padding: EdgeInsets.all(2.0),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.brown),
                iconSize: 16.0,
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          Image.network(
            'https://images.unsplash.com/photo-1511426420268-4cfdd3763b77?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=774&q=80',
            width: double.infinity,
            height: 500.0,
            fit: BoxFit.cover,
          ),
          SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.only(top: 150.0),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color(0xFFF8F7FA),
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
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(height: 20),
                    Text(
                      'Name',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: TextField(
                        controller: _nameController,
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
                      ),
                    ),
                    const SizedBox(height: 20),
                    if (!isOrderCancelled) ...[
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
                              elevation: selectedTime == '15時30分' ? 10.0 : 0.0,
                              borderRadius: BorderRadius.circular(20),
                              child: ElevatedButton(
                                child: Text(
                                  '15時30分',
                                  style: TextStyle(
                                      fontSize: 17.0,
                                      color: selectedTime == '15時30分'
                                          ? Colors.white
                                          : Colors.black),
                                ),
                                onPressed: () {
                                  setState(() {
                                    selectedTime = '15時30分';
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  backgroundColor: selectedTime == '15時30分'
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
                              elevation: selectedTime == '17時30分' ? 10.0 : 0.0,
                              borderRadius: BorderRadius.circular(20),
                              child: ElevatedButton(
                                child: Text(
                                  '17時30分',
                                  style: TextStyle(
                                      fontSize: 17.0,
                                      color: selectedTime == '17時30分'
                                          ? Colors.white
                                          : Colors.black),
                                ),
                                onPressed: () {
                                  setState(() {
                                    selectedTime = '17時30分';
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  backgroundColor: selectedTime == '17時30分'
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
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Categories',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      CoffeeTypeDropdown(
                        dropdownValue: dropdownValue,
                        onChanged: (newValue) {
                          setState(() {
                            dropdownValue = newValue!;
                          });
                        },
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Topping',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      CheckboxListTile(
                        title: const Text("氷あり"),
                        value: isIce,
                        onChanged: (bool? value) {
                          setState(() {
                            isIce = value!;
                          });
                        },
                        activeColor: Colors.brown,
                      ),
                      CheckboxListTile(
                        title: const Text("砂糖"),
                        value: isSugar,
                        onChanged: (bool? value) {
                          setState(() {
                            isSugar = value!;
                          });
                        },
                        activeColor: Colors.brown,
                      ),
                      CheckboxListTile(
                        title: const Text("キャラメルシロップ"),
                        value: caramel,
                        onChanged: (bool? value) {
                          setState(() {
                            caramel = value!;
                          });
                        },
                        activeColor: Colors.brown,
                      ),
                      CheckboxListTile(
                        title: const Text("練乳"),
                        value: isCondecensedMilk,
                        onChanged: (bool? value) {
                          setState(() {
                            isCondecensedMilk = value!;
                          });
                        },
                        activeColor: Colors.brown,
                      ),
                      CheckboxListTile(
                        title: const Text("少なめ（250ml程度）"),
                        value: small,
                        onChanged: (bool? value) {
                          setState(() {
                            small = value!;
                          });
                        },
                        activeColor: Colors.brown,
                      ),
                      CheckboxListTile(
                        title: const Text("４階で受け取る"),
                        value: isPickupOn4thFloor,
                        onChanged: (bool? value) {
                          setState(() {
                            isPickupOn4thFloor = value!;
                          });
                        },
                        activeColor: Colors.brown,
                      ),
                      const SizedBox(height: 20),
                    ],
                    Container(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (!isOrderCancelled) {
                            await updateOrder();
                            // 注文完了ダイアログを表示
                            // ignore: use_build_context_synchronously
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return Dialog(
                                  backgroundColor:
                                      Colors.white.withOpacity(0.9),
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
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            kPrimaryColor,
                          ),
                          padding: MaterialStateProperty.all<EdgeInsets>(
                            const EdgeInsets.symmetric(
                              horizontal: 20.0,
                              vertical: 15.0,
                            ),
                          ),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                          ),
                        ),
                        child: const Text(
                          '注文を変更する',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
