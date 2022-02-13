import 'package:flutter/material.dart';

class ProfileWidget extends StatelessWidget {
  final String imagePath;
  final double width;
  final double height;

  const ProfileWidget({
    Key? key,
    required this.imagePath,
    this.width = 135,
    this.height = 135,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Center(
      child: Stack(
        children: [
          buildImage(),
        ],
      ),
    );
  }

  Widget buildImage() {
    final image = NetworkImage(imagePath);

    return ClipOval(
      child: Material(
        color: Colors.transparent,
        child: Container(
          child: Ink.image(
            image: image,
            fit: BoxFit.cover,
            width: width,
            height: height,
          ),
        ),
      ),
    );
  }
}