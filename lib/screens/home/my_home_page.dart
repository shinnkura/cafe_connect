import 'package:cafe_connect/constants.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({required Key key, required this.title}) : super(key: key);

  final String title;

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  String dropdownValue = 'コーヒー';
  String timeDropdownValue = '15時';

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
                labelText: 'Enter your name',
                labelStyle: TextStyle(color: kTextColor),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: kTextColor),
                ),
              ),
              validator: (value) {
                if (value?.length == 0) {
                  return 'Please enter your name';
                }
                return null;
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
              onPressed: () {
                if (_formKey.currentState!.validate()) {}
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                  kPrimaryColor,
                ),
              ),
              child: const Text('Submit'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/orderList');
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                  kPrimaryColor,
                ),
              ),
              child: const Text('View Orders'),
            ),
          ],
        ),
      ),
    );
  }
}
