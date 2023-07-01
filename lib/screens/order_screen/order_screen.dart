import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../constants.dart';
import '../thanks_pages/thanks_page.dart';
import 'components/custom_app_bar.dart';
import 'components/custom_dropdown_button.dart';
import 'components/custom_elevated_button.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({required Key key, required this.title}) : super(key: key);

  final String title;

  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();

  String dropdownValue = 'コーヒー';
  String timeDropdownValue = '15時30分';
  bool _isSugar = false;
  bool _isPickupOn4thFloor = false;

  // Future<void> _saveOrder(String time, String coffeeType, String name) async {
  //   CollectionReference orders =
  //       FirebaseFirestore.instance.collection('orders');
  //   return orders
  //       .add({
  //         'time': time,
  //         'coffeeType': coffeeType,
  //         'name': name,
  //       })
  //       .then((value) => print("Order Added"))
  //       .catchError((error) => print("Failed to add order: $error"));
  // }

  Future<void> _saveOrder(String time, String coffeeType, String name,
      bool isSugar, bool isPickupOn4thFloor) async {
    CollectionReference orders =
        FirebaseFirestore.instance.collection('orders');
    return orders
        .add({
          'time': time,
          'coffeeType': coffeeType,
          'name': name,
          'isSugar': isSugar,
          'isPickupOn4thFloor': isPickupOn4thFloor,
        })
        .then((value) => print("Order Added"))
        .catchError((error) => print("Failed to add order: $error"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: widget.title),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(20.0 * 1.5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: TextFormField(
                controller: _nameController,
                style: Theme.of(context).textTheme.titleMedium,
                decoration: const InputDecoration(
                  labelText: 'お名前をご記入ください',
                  labelStyle: TextStyle(color: kTextColor),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: kTextColor),
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: CustomDropdownButton<String>(
                value: timeDropdownValue,
                onChanged: (String? newValue) {
                  setState(() {
                    timeDropdownValue = newValue!;
                  });
                },
                items: const ['15時30分', '17時30分'],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: CustomDropdownButton<String>(
                value: dropdownValue,
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownValue = newValue!;
                  });
                },
                items: const [
                  'コーヒー',
                  'カフェオレ',
                  'ちょいふわカフェオレ',
                  'ふわふわカフェオレ',
                  'アイスコーヒー（水出し）',
                  'アイスコーヒー(急冷式)',
                  'アイスカフェオレ',
                  'アイスカフェオレ（ミルク多め）',
                  '温かい緑茶',
                  '温かい紅茶（茶葉は日替わり）',
                  '冷たい緑茶',
                  '冷たい紅茶（茶葉は日替わり）',
                ],
              ),
            ),
            SwitchListTile(
              title: const Text('砂糖'),
              value: _isSugar,
              onChanged: (bool value) {
                setState(() {
                  _isSugar = value;
                });
              },
            ),
            SwitchListTile(
              title: const Text('4階で受け取る'),
              value: _isPickupOn4thFloor,
              onChanged: (bool value) {
                setState(() {
                  _isPickupOn4thFloor = value;
                });
              },
            ),
            // CustomElevatedButton(
            //   onPressed: () {
            //     if (_formKey.currentState!.validate()) {
            //       _saveOrder(
            //           timeDropdownValue, dropdownValue, _nameController.text);
            //       Navigator.push(
            //         context,
            //         MaterialPageRoute(builder: (context) => const ThanksPage()),
            //       );
            //     }
            //   },
            //   text: '注文',
            // ),
            CustomElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _saveOrder(timeDropdownValue, dropdownValue,
                      _nameController.text, _isSugar, _isPickupOn4thFloor);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ThanksPage()),
                  );
                }
              },
              text: '注文',
            ),
          ],
        ),
      ),
    );
  }
}
