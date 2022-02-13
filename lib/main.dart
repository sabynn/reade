import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reade/cubit/all_user_cubit.dart';
import 'package:reade/ui/pages/after_interview_page.dart';
import 'package:reade/ui/pages/get_started_page.dart';
import 'package:reade/ui/pages/home_page.dart';
import 'package:reade/ui/pages/interview_page.dart';
import 'package:reade/ui/pages/interview_partner_page.dart';
import 'package:reade/ui/pages/meeting_board_page.dart';
import 'package:reade/ui/pages/pre_interview_page.dart';
import 'package:reade/ui/pages/profile_page.dart';
import 'package:reade/ui/pages/sign_in_page.dart';
import 'package:reade/ui/pages/sign_up_page.dart';
import 'package:reade/ui/pages/splash_screen.dart';

import 'cubit/auth_cubit.dart';
import 'cubit/question_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthCubit(),
        ),
        BlocProvider(
          create: (context) => QuestionCubit(),
        ),
        BlocProvider(
          create: (context) => AllUserCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Face Detector App ',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const SplashPage(),
        routes: {
          '': (context) => const SplashPage(),
          '/get-started': (context) => const GetStartedPage(),
          '/sign-up': (context) => const SignUpPage(),
          '/sign-in': (context) => SignInPage(),
          '/home': (context) => const HomePage(),
          '/pre-interview': (context) => const PreInterviewPage(),
          '/interview-page': (context) => const InterviewPage(),
          '/after-interview': (context) => AfterInterviewPage(),
          '/profile-page': (context) => const ProfilePage(),
          '/interview-partner': (context) => InterviewPartnerPage(),
          '/meeting-boards': (context) => MeetingBoardPage(),
        },
      ),
    );
  }
}
