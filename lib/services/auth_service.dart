import 'package:reade/models/user_model.dart';
import 'package:reade/services/user_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserModel> signIn({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      UserModel user =
          await UserService().getUserById(userCredential.user!.uid);
      return user;
    } catch (e) {
      rethrow;
    }
  }

  Future<UserModel> signUp({
    required String email,
    required String password,
    required String name,
    required String dateOfBirth,
    required gender,
    required education,
    required interests,
    profileImage =
        "https://images.unsplash.com/photo-1502164980785-f8aa41d53611?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60",
    sentimentScores = const [],
    toneScores = const [],
    eyeVisibilityScores = const [],
    smilingScores = const [],
    fileRecentInterview = "",
    fileExpectedAnswer = "",
    schedule = "",
  }) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      UserModel user = UserModel(
        id: userCredential.user!.uid,
        email: email,
        name: name,
        dateOfBirth: dateOfBirth,
        gender: gender,
        education: education,
        interests: interests,
        profileImage: profileImage,
        sentimentScores: sentimentScores,
        toneScores: toneScores,
        eyeVisibilityScores: eyeVisibilityScores,
        smilingScores: smilingScores,
        fileRecentInterview: fileRecentInterview,
        fileExpectedAnswer: fileExpectedAnswer,
        schedule: schedule,
      );

      await UserService().setUser(user);

      return user;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateUserData(UserModel user) async {
    try {
      await UserService().updateUserData(user);
    } catch (e) {
      rethrow;
    }
  }
}
