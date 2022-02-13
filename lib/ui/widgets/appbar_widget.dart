import 'package:flutter/material.dart';

AppBar buildAppBar(BuildContext context, String text, var page) {
  return AppBar(
    leading: IconButton(
      icon: const Icon(
        Icons.arrow_back,
        color: Color(0xff2545b4),
        size: 20,
      ),
      onPressed: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (BuildContext context) => page),
      ),
    ),
    title: Text(
      text,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    ),
    foregroundColor: const Color(0xff2545b4),
    backgroundColor: Colors.transparent,
    elevation: 0,
  );
}
