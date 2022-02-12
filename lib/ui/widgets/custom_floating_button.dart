import 'package:flutter/material.dart';

Widget customFloatingButton(
    IconData icon,
    Color buttonColor,
    Color iconColor,
    var func,
    var height,
    var width,
    ) {
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: SizedBox(
      height: height,
      width: width,
      child: FittedBox(
        child: FloatingActionButton(
          heroTag: icon,
          backgroundColor: buttonColor,
          onPressed: func,
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