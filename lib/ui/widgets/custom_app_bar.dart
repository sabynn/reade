import 'package:flutter/material.dart';

import '../../shared/theme.dart';

Widget customAppBar(BuildContext context, dynamic scaffoldKey, bool homePage) {
  return Row(
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
              height: 55,
              width: 55,
              color: kBackgroundColor,
              child: IconButton(
                icon: Icon(
                  Icons.short_text,
                  size: 30,
                  color: kDarkColor,
                ),
                onPressed: () {
                  scaffoldKey.currentState?.openDrawer();
                },
              )),
        ),
      ),
      homePage ? Padding(
        padding: const EdgeInsets.all(20.0),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(
            Radius.circular(
              100,
            ),
          ),
          child: Container(
              height: 55,
              width: 55,
              color: kBackgroundColor,
              child: IconButton(
                icon: Icon(
                  Icons.person,
                  size: 25,
                  color: kDarkColor,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/profile-page');
                },
              )),
        ),
      ) : const SizedBox(),
    ],
  );
}