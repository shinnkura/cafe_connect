import 'package:flutter/material.dart';

const kPrimaryColor = Color(0xFF795548);
// const kPrimaryColor = Color.fromARGB(255, 83, 75, 239);
const kPrimaryLightColor = Color.fromARGB(255, 141, 110, 99);
// const kPrimaryColor = Color.fromARGB(255, 13, 16, 215);
const kTextColor = Color(0xFF212121);
const kBackgroundColor = Color(0xFFECEFF1);

const double kDefaultPadding = 20.0;

var drawerTextColor = TextStyle(
  color: Colors.grey[600],
);
var tilePadding = const EdgeInsets.only(left: 8.0, right: 8, top: 8);
var myDrawer = Drawer(
  backgroundColor: Colors.grey[300],
  elevation: 0,
  child: Column(
    children: [
      // const DrawerHeader(
      //   child: Icon(
      //     Icons.coffee,
      //     size: 64,
      //   ),
      // ),
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
        ),
      ),
    ],
  ),
);
