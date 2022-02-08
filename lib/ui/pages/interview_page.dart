import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../services/controller/interview_controller.dart';
import '../../shared/theme.dart';

class InterviewPage extends StatefulWidget {
  const InterviewPage({Key? key}) : super(key: key);

  @override
  State<InterviewPage> createState() => _InterviewPageState();
}

class _InterviewPageState extends State<InterviewPage> {
  final _interviewController = InterviewController();

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
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 75.0),
                  child: GetBuilder<InterviewController>(
                    init: _interviewController,
                    initState: (_) async {
                      await _interviewController.loadCamera();
                      _interviewController.startImageStream();
                    },
                    builder: (_) {
                      return _.cameraController != null &&
                          _.cameraController!.value.isInitialized
                          ? Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width,
                        height:
                        MediaQuery.of(context).size.height * 0.60,
                        child: CameraPreview(
                          _.cameraController!,
                        ),
                      )
                          : const Center(
                        child: Text(
                          'loading',
                        ),
                      );
                    },
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
