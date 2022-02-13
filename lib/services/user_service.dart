import 'package:reade/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserService {
  final CollectionReference _userReference =
      FirebaseFirestore.instance.collection('users');

  Future<void> setUser(UserModel user) async {
    try {
      _userReference.doc(user.id).set({
        'email': user.email,
        'name': user.name,
        'dateOfBirth': user.dateOfBirth,
        'gender': user.gender,
        'education': user.education,
        'interests': user.interests,
        'profileImage': user.profileImage,
        'sentimentScores': user.sentimentScores,
        'toneScores': user.toneScores,
        'eyeVisibilityScores': user.eyeVisibilityScores,
        'smilingScores': user.smilingScores,
        'fileRecentInterview': user.fileRecentInterview,
        'fileExpectedAnswer': user.fileExpectedAnswer,
        'schedule': user.schedule,
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<UserModel> getUserById(String id) async {
    try {
      DocumentSnapshot snapshot = await _userReference.doc(id).get();
      return UserModel(
        id: id,
        email: snapshot['email'],
        name: snapshot['name'],
        dateOfBirth: snapshot['dateOfBirth'],
        gender: snapshot['gender'],
        education: snapshot['education'],
        profileImage: snapshot['profileImage'],
        interests: snapshot['interests'],
        sentimentScores: snapshot['sentimentScores'],
        toneScores: snapshot['toneScores'],
        eyeVisibilityScores: snapshot['eyeVisibilityScores'],
        smilingScores: snapshot['smilingScores'],
        fileRecentInterview: snapshot['fileRecentInterview'],
        fileExpectedAnswer: snapshot['fileExpectedAnswer'],
        schedule: snapshot['schedule'],
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateUserData(UserModel user) async {
    try {
      _userReference.doc(user.id).set({
        'email': user.email,
        'name': user.name,
        'dateOfBirth': user.dateOfBirth,
        'gender': user.gender,
        'education': user.education,
        'profileImage': user.profileImage,
        'interests': user.interests,
        'sentimentScores': user.sentimentScores,
        'toneScores': user.toneScores,
        'eyeVisibilityScores': user.eyeVisibilityScores,
        'smilingScores': user.smilingScores,
        'fileRecentInterview': user.fileRecentInterview,
        'fileExpectedAnswer': user.fileExpectedAnswer,
        'schedule': user.schedule,
      });
    } catch (e) {
      rethrow;
    }
  }
}
