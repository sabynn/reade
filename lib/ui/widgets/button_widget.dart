import 'package:flutter/material.dart';
import 'package:reade/shared/theme.dart';

class ButtonWidget extends StatelessWidget {
  final double fontSize;
  final String text;
  final VoidCallback onClicked;

  const ButtonWidget({
    Key? key,
    required this.fontSize,
    required this.text,
    required this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: const StadiumBorder(),
          primary: kPrimaryColor,
          onPrimary: kBackgroundColor,
          textStyle: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
          ),
          elevation: 5,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        ),

        child: Text(text),
        onPressed: onClicked,
      );
}
