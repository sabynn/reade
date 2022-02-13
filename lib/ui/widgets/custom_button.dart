import 'package:reade/shared/theme.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final double width;
  final Function() onPressed;
  final EdgeInsets margin;
  final bool transparent;
  final double? heightSize;
  final double fontSize;
  final double borderRadius;

  const CustomButton({
    Key? key,
    required this.title,
    this.width = double.infinity,
    required this.onPressed,
    this.heightSize = 55,
    this.margin = EdgeInsets.zero,
    this.transparent = false,
    this.fontSize = 18,
    this.borderRadius = 10,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: heightSize,
      margin: margin,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor: !transparent
              ? kPrimaryColor
              : kPrimaryColor.withOpacity(
                  0.05,
                ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            side: BorderSide(
              color: kPrimaryColor,
              width: 1,
              style: BorderStyle.solid,
            ),
          ),
        ),
        child: Text(
          title,
          style: whiteTextStyle.copyWith(
            fontSize: fontSize,
            fontWeight: medium,
          ),
        ),
      ),
    );
  }
}
