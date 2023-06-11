import 'package:flutter/material.dart';

import '../../constants.dart';
import '../thanks_pages/components/thanks_edito_order.dart';

class EditOrderPage extends StatefulWidget {
  final String name;
  final String initialCoffeeType;
  final String initialTime;

  const EditOrderPage(
      {super.key,
      required this.name,
      required this.initialCoffeeType,
      required this.initialTime});

  @override
  // ignore: library_private_types_in_public_api
  _EditOrderPageState createState() => _EditOrderPageState();
}

class _EditOrderPageState extends State<EditOrderPage> {
  late String dropdownValue;
  late String selectedTime;
  bool isOrderCancelled = false;

  @override
  void initState() {
    super.initState();
    dropdownValue = widget.initialCoffeeType;
    selectedTime = widget.initialTime;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: const Text('注文変更'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              '${widget.name}さんのご注文を変更します',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            if (!isOrderCancelled) ...[
              const Text(
                'Coffee Type',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
              const SizedBox(height: 20),
              const Text(
                'Time',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              DropdownButton<String>(
                value: selectedTime,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedTime = newValue!;
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
              const SizedBox(height: 20),
            ],
            ElevatedButton(
              onPressed: () {
                setState(() {
                  isOrderCancelled = true;
                });
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                  Colors.red,
                ),
              ),
              child: const Text('注文取り消し'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (isOrderCancelled) {
                  // Cancel the order in your data source here
                } else {
                  // Update the order in your data source here
                }
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ThanksPage()),
                );
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                  kPrimaryColor,
                ),
              ),
              child: const Text('注文'),
            ),
          ],
        ),
      ),
    );
  }
}
