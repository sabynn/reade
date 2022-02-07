import 'package:reade/models/user_model.dart';
import 'package:reade/services/auth_service.dart';
import 'package:reade/services/user_service.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  void signIn({required String email, required String password}) async {
    try {
      emit(AuthLoading());
      UserModel user = await AuthService().signIn(
        email: email,
        password: password,
      );
      emit(AuthSuccess(user));
    } catch (e) {
      emit(AuthFailed(e.toString()));
    }
  }

  void signUp({
    required String email,
    required String password,
    required String name,
    required String dateOfBirth,
    required gender,
    required education,
    required interests,
    sentimentScores = const [],
    toneScores = const [],
    eyeVisibilityScores = const [],
    smilingScores = const [],
    fileRecentInterview = "",
    fileExpectedAnswer = "",
  }) async {
    try {
      emit(AuthLoading());

      UserModel user = await AuthService().signUp(
        email: email,
        password: password,
        name: name,
        dateOfBirth: dateOfBirth,
        gender: gender,
        education: education,
        interests: interests,
        sentimentScores: sentimentScores,
        toneScores: toneScores,
        eyeVisibilityScores: eyeVisibilityScores,
        smilingScores: smilingScores,
        fileRecentInterview: fileRecentInterview,
        fileExpectedAnswer: fileExpectedAnswer,
      );
      emit(AuthSuccess(user));
    } catch (e) {
      emit(AuthFailed(e.toString()));
    }
  }

  void signOut() async {
    try {
      emit(AuthLoading());
      await AuthService().signOut();
      emit(AuthInitial());
    } catch (e) {
      emit(AuthFailed(e.toString()));
    }
  }

  void getCurrentUser(String id) async {
    try {
      UserModel user = await UserService().getUserById(id);
      emit(AuthSuccess(user));
    } catch (e) {
      emit(AuthFailed(e.toString()));
    }
  }
}
