import 'package:flutter/material.dart';

Widget customFloatingButton(
    IconData icon,
    Color buttonColor,
    Color iconColor,
    var func,
    ) {
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: SizedBox(
      height: 65.0,
      width: 65.0,
      child: FittedBox(
        child: FloatingActionButton(
          heroTag: icon,
          backgroundColor: buttonColor,
          onPressed: () {
            func();
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