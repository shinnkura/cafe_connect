import 'package:flutter/material.dart';
import 'package:cafe_connect/constants.dart';

class CoffeeTypeDropdown extends StatefulWidget {
  final String dropdownValue;
  final ValueChanged<String?> onChanged;

  const CoffeeTypeDropdown({
    super.key,
    required this.dropdownValue,
    required this.onChanged,
  });

  @override
  // ignore: library_private_types_in_public_api
  _CoffeeTypeDropdownState createState() => _CoffeeTypeDropdownState();
}

class _CoffeeTypeDropdownState extends State<CoffeeTypeDropdown> {
  final ScrollController _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        children: [
          MediaQuery.of(context).size.width > 600
              ? IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: kPrimaryColor,
                    size: 30,
                  ),
                  onPressed: () {
                    _controller.animateTo(
                      _controller.offset - 250,
                      duration: const Duration(milliseconds: 300),
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
                      color: item['name'] == widget.dropdownValue
                          ? kPrimaryColor
                          : null,
                      elevation:
                          item['name'] == widget.dropdownValue ? 10.0 : 0.0,
                      borderRadius: BorderRadius.circular(20),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            widget.onChanged(item['name']);
                          });
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          color: item['name'] == widget.dropdownValue
                              ? kPrimaryColor
                              : null,
                          child: SizedBox(
                            height: 200,
                            width: 150,
                            child: Column(
                              children: <Widget>[
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(20.0),
                                  child: Image.network(
                                    item['image']!,
                                    height: 100,
                                    width: 140,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                ListTile(
                                  title: Text(
                                    item['name']!,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color:
                                          item['name'] == widget.dropdownValue
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
                  icon: const Icon(
                    Icons.arrow_forward_ios,
                    color: kPrimaryColor,
                    size: 30,
                  ),
                  onPressed: () {
                    _controller.animateTo(
                      _controller.offset + 250,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  },
                )
              : Container(),
        ],
      ),
    );
  }
}
