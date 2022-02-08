import 'package:flutter/material.dart';

import '../../shared/theme.dart';

class InterviewPage extends StatelessWidget {
  const InterviewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(
                    'assets/images/background_image.png',
                  ),
                ),
              ),
            ),
            ListView(
              children: [],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(
                        100,
                      ),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: kPrimaryColor,
                        // gradient: LinearGradient(
                        //   begin: Alignment.topRight,
                        //   end: Alignment.bottomLeft,
                        //   colors: [
                        //     kPrimaryColor,
                        //     kAvailableColor,
                        //   ],
                        // ),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(80.0),
                        ),
                      ),
                      child: BackButton(
                        color: kBackgroundColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: kPrimaryColor,
        onPressed: () {},
        icon: const Icon(
          Icons.voice_chat,
        ),
        label: Text(
          "Start Interview",
          style: whiteTextStyle.copyWith(),
        ),
        elevation: 4.0,
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 35.0),
              child: IconButton(
                onPressed: () {},
                iconSize: 30.0,
                icon: Icon(
                  Icons.pause,
                  color: kDarkColor,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 35.0),
              child: IconButton(
                onPressed: () {},
                iconSize: 30.0,
                icon: Icon(
                  Icons.switch_camera_outlined,
                  color: kDarkColor,
                ),
              ),
            ),
          ],
        ),
        shape: const AutomaticNotchedShape(
          RoundedRectangleBorder(),
          StadiumBorder(
            side: BorderSide(),
          ),
        ),
        color: Colors.white,
      ),
    );
  }
}
