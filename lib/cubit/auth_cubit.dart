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
    profileImage =
        "https://images.unsplash.com/photo-1502164980785-f8aa41d53611?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60",
    sentimentScores = const [],
    toneScores = const [],
    eyeVisibilityScores = const [],
    smilingScores = const [],
    fileRecentInterview = "",
    fileExpectedAnswer = "",
    schedule = const [],
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
        profileImage: profileImage,
        sentimentScores: sentimentScores,
        toneScores: toneScores,
        eyeVisibilityScores: eyeVisibilityScores,
        smilingScores: smilingScores,
        fileRecentInterview: fileRecentInterview,
        fileExpectedAnswer: fileExpectedAnswer,
        schedule: schedule,
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

  void updateUserData({
    required UserModel userUpdate
  }) async {
    try {
      emit(AuthLoading());
      await AuthService().updateUserData(userUpdate);
      emit(AuthSuccess(userUpdate));
    } catch (e) {
      emit(AuthFailed(e.toString()));
    }
  }
}
