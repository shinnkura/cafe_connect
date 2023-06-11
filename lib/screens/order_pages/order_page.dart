import 'package:cafe_connect/constants.dart';
import 'package:flutter/material.dart';

import '../thanks_pages/thanks_page.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({required Key key, required this.title}) : super(key: key);

  final String title;

  @override
  OrderPageState createState() => OrderPageState();
}

class OrderPageState extends State<OrderPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  String dropdownValue = 'コーヒー';
  String timeDropdownValue = '15時';

  // フォームのバリデーションを行うメソッド
  void _validateForm() {
    if (_formKey.currentState!.validate()) {
      print('Name: ${_nameController.text}, Order: $dropdownValue');
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ThanksPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: buildBody(),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: kPrimaryColor,
      elevation: 0,
      title: Text(widget.title),
    );
  }

  Widget buildBody() {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(20.0 * 1.5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
            DropdownButton<String>(
              value: dropdownValue,
              onChanged: (String? newValue) {
                setState(() {
                  dropdownValue = newValue!;
                });
              },
              items: <String>['コーヒー', 'ふわふわカフェオレ', 'カフェオレ']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            DropdownButton<String>(
              value: timeDropdownValue,
              onChanged: (String? newValue) {
                setState(() {
                  timeDropdownValue = newValue!;
                });
              },
              items: <String>['15時', '17時']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            ElevatedButton(
              onPressed: _validateForm, // フォームのバリデーションを行う
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                  kPrimaryColor,
                ),
              ),
              child: const Text('注文'),
            ),
            // const SizedBox(height: 200),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/orderList');
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                  kPrimaryColor,
                ),
              ),
              child: const Text('注文一覧'),
            ),
          ],
        ),
      ),
    );
  }
}
