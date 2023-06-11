import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../constants.dart';
import '../thanks/components/thanks_edito_order.dart';

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
          'coffeeType': dropdownValue,
          'time': selectedTime,
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
              onPressed: () async {
                await cancelOrder();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ThanksPage()),
                );
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
              onPressed: () async {
                if (!isOrderCancelled) {
                  await updateOrder();
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
