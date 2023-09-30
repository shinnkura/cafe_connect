import 'package:cafe_connect/constants.dart';
import 'package:flutter/material.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        title: const Text(
          'お知らせ',
          style: TextStyle(
            fontSize: 24.0,
            color: kTextColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0.0,
        iconTheme: const IconThemeData(color: kTextColor),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: RichText(
          textAlign: TextAlign.left,
          text: const TextSpan(
            style: TextStyle(
              fontSize: 16.0,
              color: kTextColor,
            ),
            children: [
              TextSpan(
                text: 'お疲れ様です。 ',
              ),
              TextSpan(
                text: '\n\n', // 1つの改行と、もう1つの改行をパディングとして使用
              ),
              TextSpan(
                text: 'いつも、コーヒーアプリをご利用いただきありがとうございます。 ',
              ),
              TextSpan(
                text: '\n\n', // 1つの改行と、もう1つの改行をパディングとして使用
              ),
              TextSpan(
                text: 'この度、大学との都合により、コーヒーの配布は ',
              ),
              TextSpan(
                text: '1日一回、 17時',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
              TextSpan(
                text: ' に行うことにさせて頂きます。',
              ),
              TextSpan(
                text: ' よろしくお願いします。',
              ),
              TextSpan(
                text: '\n\n', // 1つの改行と、もう1つの改行をパディングとして使用
              ),
              TextSpan(
                text: 'また、曜日によってはコーヒーを配布できない日もありますので、あらかじめご了承ください。',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
