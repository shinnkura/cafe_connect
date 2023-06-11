import 'package:flutter/material.dart';
import '../../../constants.dart';

class CustomElevatedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;

  CustomElevatedButton({required this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(
          kPrimaryColor,
        ),
      ),
      child: Text(text),
    );
  }
}
