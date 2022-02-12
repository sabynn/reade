import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:get/get.dart';
import 'package:reade/models/face_analysis.dart';
import 'package:reade/models/user_model.dart';
import 'package:reade/services/controller/question_voice.dart';
import 'package:reade/services/controller/voice_controller.dart';
import '../../cubit/auth_cubit.dart';
import '../../cubit/question_cubit.dart';
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
  QuestionVoice questionVoice = QuestionVoice();
  List<dynamic>? questions;
  int questionNumber = 0;

  void showInSnackBar(String message) {
    // ignore: deprecated_member_use
    _scaffoldKey.currentState?.showSnackBar(SnackBar(content: Text(message)));
  }

  void nextQuestion(){
    questionVoice.setVoiceText(questions![questionNumber++]);
    questionVoice.speak();
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

    voiceDetector.stopListening(user);
    FaceAnalysis faceAnalysis = _interviewController.faceAnalysis!;
    user.smilingScores
        .add((faceAnalysis.scoreSmile / faceAnalysis.countSmile) * 100);

    user.eyeVisibilityScores.add(((faceAnalysis.scoreLeftEyeOpen +
        faceAnalysis.scoreRightEyeOpen) /
        (faceAnalysis.countLeftEyeOpen + faceAnalysis.countRightEyeOpen)) *
        100);
    context.read<AuthCubit>().updateUserData(userUpdate: user);

    Navigator.pushNamed(context, '/after-interview');
  }

  @override
  void initState(){
    context.read<QuestionCubit>().fetchQuestions();
    voiceDetector.initSpeechState();
    questionVoice.initTts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            BlocConsumer<QuestionCubit, QuestionState>(
              listener: (context, state) {
                if (state is QuestionFailed) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: kRedColor,
                      content: Text(state.error),
                    ),
                  );
                }
              },
              builder: (context, state) {
                if (state is QuestionSuccess) {
                  return SizedBox(
                    width: double.infinity,
                    height: double.infinity,
                    child: GetBuilder<InterviewController>(
                      init: _interviewController,
                      initState: (_) async {
                        await _interviewController.loadCamera();
                        _interviewController.startImageStream();
                        voiceDetector.startListening();
                        print("THIS IS QUESTIONS");
                        print(state.questions);
                        questions = state.questions[0].userInterview;
                        nextQuestion();
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
                  );
                }

                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
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
                          65.0,
                          65.0,
                        ),
                        customFloatingButton(
                          Icons.call_end,
                          Colors.red,
                          kBackgroundColor,
                          () {
                            endInterview(state.user);
                          },
                          65.0,
                          65.0,
                        ),
                        customFloatingButton(
                          Icons.next_week,
                          kBackgroundColor,
                          kPrimaryColor,
                          () {
                            nextQuestion();
                          },
                          65.0,
                          65.0,
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
