import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:get/get.dart';
import 'package:reade/models/face_analysis.dart';
import 'package:reade/models/user_model.dart';
import 'package:reade/services/controller/voice_controller.dart';
import '../../cubit/auth_cubit.dart';
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
  VoiceDetector voiceDetector = VoiceDetector();


  void showInSnackBar(String message) {
    // ignore: deprecated_member_use
    _scaffoldKey.currentState?.showSnackBar(SnackBar(content: Text(message)));
  }


  void endInterview(UserModel user) {
    _interviewController.stopVideoRecording().then((file) async {
      if (mounted) setState(() {});
      if (file != null) {
        bool? saveVid =
        await GallerySaver.saveVideo(file.path, albumName: "Interview");
        print('Video recorded to ${file.path} $saveVid');
        videoFile = file;
      }
      _interviewController.stopImageStream();
    });

    voiceDetector.stopListening();
    print(voiceDetector.lastWords);
    FaceAnalysis faceAnalysis = _interviewController.faceAnalysis!;
    user.smilingScores
        .add((faceAnalysis.scoreSmile / faceAnalysis.countSmile) * 100);

    user.eyeVisibilityScores.add(((faceAnalysis.scoreLeftEyeOpen +
        faceAnalysis.scoreRightEyeOpen) /
        (faceAnalysis.countLeftEyeOpen + faceAnalysis.countRightEyeOpen)) *
        100);

    print("INI SCORENYA: ");
    print((faceAnalysis.scoreSmile / faceAnalysis.countSmile) * 100);
    print(((faceAnalysis.scoreLeftEyeOpen + faceAnalysis.scoreRightEyeOpen) /
        (faceAnalysis.countLeftEyeOpen + faceAnalysis.countRightEyeOpen)) *
        100);
    context.read<AuthCubit>().updateUserData(userUpdate: user);
  }

  @override
  void initState(){
    voiceDetector.initSpeechState();
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
                  voiceDetector.startListening();
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
      floatingActionButton: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          if (state is AuthSuccess) {
            print(state.user);
            return BlocBuilder<AuthCubit, AuthState>(
              builder: (context, state) {
                if (state is AuthSuccess) {
                  print(state.user);
                  return Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        customFloatingButton(
                          Icons.cameraswitch,
                          kBackgroundColor,
                          kPrimaryColor,
                          () {
                            _interviewController.changeCamera();
                          },
                        ),
                        customFloatingButton(
                          Icons.call_end,
                          Colors.red,
                          kBackgroundColor,
                          () {
                            endInterview(state.user);
                          },
                        ),
                        customFloatingButton(
                          Icons.next_week,
                          kBackgroundColor,
                          kPrimaryColor,
                          () {
                            endInterview(state.user);
                          },
                        ),
                      ],
                    ),
                  );
                } else {
                  return const SizedBox();
                }
              },
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
