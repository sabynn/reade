import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:get/get.dart';

import '../../services/controller/interview_controller.dart';
import '../../shared/theme.dart';
import '../widgets/custom_floating_button.dart';

class InterviewPage extends StatefulWidget {
  const InterviewPage({Key? key}) : super(key: key);

  @override
  State<InterviewPage> createState() => _InterviewPageState();
}

class _InterviewPageState extends State<InterviewPage> {
  final _interviewController = InterviewController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  XFile? videoFile;

  void showInSnackBar(String message) {
    // ignore: deprecated_member_use
    _scaffoldKey.currentState?.showSnackBar(SnackBar(content: Text(message)));
  }

  void endInterview() {
    print('Video recorded to asnjajsiais');
    _interviewController.stopVideoRecording().then((file) async {
      if (mounted) setState(() {});
      if (file != null) {
        bool? saveVid =
            await GallerySaver.saveVideo(file.path, albumName: "Interview");
        print('Video recorded to ${file.path} $saveVid');
        videoFile = file;
      }
    });
    _interviewController.stopImageStream();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: GetBuilder<InterviewController>(
                init: _interviewController,
                initState: (_) async {
                  await _interviewController.loadCamera();
                  _interviewController.startImageStream();
                },
                builder: (_) {
                  return _.cameraController != null &&
                          _.cameraController!.value.isInitialized
                      ? CameraPreview(
                          _.cameraController!,
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
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            customFloatingButton(
              Icons.cameraswitch,
              kBackgroundColor,
              kPrimaryColor,
              _interviewController.changeCamera,
            ),
            customFloatingButton(
              Icons.call_end,
              Colors.red,
              kBackgroundColor,
              endInterview,
            ),
            customFloatingButton(
              Icons.next_week,
              kBackgroundColor,
              kPrimaryColor,
              endInterview,
            ),
          ],
        ),
      ),
    );
  }
}
