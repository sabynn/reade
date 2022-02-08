import 'package:flutter/material.dart';

Widget customFloatingButton(
    IconData icon,
    Color buttonColor,
    Color iconColor,
    ) {
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: SizedBox(
      height: 65.0,
      width: 65.0,
      child: FittedBox(
        child: FloatingActionButton(
          backgroundColor: buttonColor,
          onPressed: () {

          },
          child: Icon(
            icon,
            color: iconColor,
          ),
          elevation: 4.0,
        ),
      ),
    ),
  );
}