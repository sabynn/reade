import 'package:flutter/material.dart';

class EditProfileWidget extends StatelessWidget {
  final String imagePath;

  const EditProfileWidget({
    Key? key,
    required this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Center(
      child: Stack(
        children: [
          buildImage (context),
        ],
      ),
    );
  }

  Widget buildImage(BuildContext context) {

    return Center(
      child: Stack(
        children: [
          Container(
            width: 130,
            height: 130,
            decoration: BoxDecoration(
                border: Border.all(
                    width: 4,
                    color: Theme.of(context).scaffoldBackgroundColor),
                boxShadow: [
                  BoxShadow(
                      spreadRadius: 2,
                      blurRadius: 10,
                      color: Colors.black.withOpacity(0.1),
                      offset: Offset(0, 10))
                ],
                shape: BoxShape.circle,
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                        imagePath
                    ))),
          ),
          Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    width: 2,
                    color: Theme.of(context).scaffoldBackgroundColor,
                  ),
                  color: Color(0xff425bb3),
                ),
                child: IconButton(
                    icon : Icon(Icons.camera, color : Colors.white),
                    iconSize: 30,
                    padding: EdgeInsets.all(1),
                    onPressed : (){},
                  ),
                ),
              ),
        ],
      ),
    );
  }
}