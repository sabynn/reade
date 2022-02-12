import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../shared/theme.dart';

import '../widgets/custom_button.dart';

class PreInterviewPage extends StatefulWidget {
  const PreInterviewPage({Key? key}) : super(key: key);

  @override
  _PreInterviewPageState createState() => _PreInterviewPageState();
}

class _PreInterviewPageState extends State<PreInterviewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: kBackgroundColor,
        body: SafeArea(
      child: Center(
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
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(
                    left: defaultMargin,
                    right: defaultMargin,
                    top: 30,
                  ),
                  child: Center(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset('assets/images/pre_interview.png'),
                          Center(
                            child: Text(
                              'Are you ready to start the interview?',
                              style: darkTextStyle.copyWith(
                                fontSize: 22,
                                fontWeight: semiBold,
                              ),
                              textAlign: TextAlign.center,
                              // overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          Center(
                            child: Text(
                              'Prepare yourself and click the button below to start the interview',
                              style: greyTextStyle.copyWith(
                                fontSize: 14,
                                fontWeight: light,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(
                    8.0,
                  ),
                  child: CustomButton(
                    title: 'Start',
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        "/interview-page",
                      );
                    },
                    width: 125,
                    heightSize: 40,
                    margin: const EdgeInsets.only(
                      left: 50,
                      right: 50,
                    ),
                    fontSize: 16,
                  ),
                ),
              ],
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
                      color: kBackgroundColor,
                      child: BackButton(
                        color: kPrimaryColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ));
  }
}
