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
        'sentimentScores': user.sentimentScores,
        'toneScores': user.toneScores,
        'eyeVisibilityScores': user.eyeVisibilityScores,
        'smilingScores': user.smilingScores,
        'fileRecentInterview': user.fileRecentInterview,
        'fileExpectedAnswer': user.fileExpectedAnswer,
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
        interests: snapshot['interests'],
        sentimentScores: snapshot['sentimentScores'],
        toneScores: snapshot['toneScores'],
        eyeVisibilityScores: snapshot['eyeVisibilityScores'],
        smilingScores: snapshot['smilingScores'],
        fileRecentInterview: snapshot['fileRecentInterview'],
        fileExpectedAnswer: snapshot['fileExpectedAnswer'],
      );
    } catch (e) {
      rethrow;
    }
  }
}
