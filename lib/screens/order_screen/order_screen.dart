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
  String timeDropdownValue = '15時';

  Future<void> _saveOrder(String time, String coffeeType, String name) async {
    CollectionReference orders =
        FirebaseFirestore.instance.collection('orders');
    return orders
        .add({
          'time': time,
          'coffeeType': coffeeType,
          'name': name,
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
            TextFormField(
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
            CustomDropdownButton<String>(
              value: dropdownValue,
              onChanged: (String? newValue) {
                setState(() {
                  dropdownValue = newValue!;
                });
              },
              items: const [
                'コーヒー',
                'ふわふわラテ',
                'カフェオレ',
                'アイスコーヒー(急冷式)',
                'アイスコーヒー（水出し）',
                'アイスカフェラテ（牛乳７割）',
                'アイスカフェオレ（コーヒー７割）',
              ],
            ),
            CustomDropdownButton<String>(
              value: timeDropdownValue,
              onChanged: (String? newValue) {
                setState(() {
                  timeDropdownValue = newValue!;
                });
              },
              items: const ['15時', '17時'],
            ),
            CustomElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _saveOrder(
                      timeDropdownValue, dropdownValue, _nameController.text);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ThanksPage()),
                  );
                }
              },
              text: '注文',
            ),
            const Spacer(),
            CustomElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/orderList');
              },
              text: '注文一覧',
            ),
          ],
        ),
      ),
    );
  }
}
