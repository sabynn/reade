import 'package:flutter/material.dart';
import 'package:reade/ui/pages/get_started.dart';
import 'package:reade/ui/pages/splash_screen.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Face Detector App ',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplashPage(),
      routes: {
        '': (context) => const SplashPage(),
        '/get-started': (context) => const GetStartedPage(),
      },
    );
  }
}
