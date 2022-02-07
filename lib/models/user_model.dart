
import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String id;
  final String email;
  final String name;
  final String dateOfBirth;
  final String gender;
  final String education;
  final String profileImage;
  final List<dynamic> interests;
  final List<dynamic> sentimentScores;
  final List<dynamic> toneScores;
  final List<dynamic> eyeVisibilityScores;
  final List<dynamic> smilingScores;
  final dynamic fileRecentInterview;
  final dynamic fileExpectedAnswer;

  const UserModel({
    required this.id,
    required this.email,
    required this.name,
    required this.dateOfBirth,
    required this.gender,
    required this.education,
    required this.profileImage,
    required this.interests,
    this.sentimentScores = const [],
    this.toneScores = const [0.0],
    this.eyeVisibilityScores = const [0.0],
    this.smilingScores = const [0.0],
    this.fileRecentInterview = "",
    this.fileExpectedAnswer = "",
  });

  @override
  List<Object?> get props => [
        id,
        email,
        name,
        dateOfBirth,
        gender,
        education,
        profileImage,
        interests,
        sentimentScores,
        toneScores,
        eyeVisibilityScores,
        smilingScores,
        fileRecentInterview,
        fileExpectedAnswer,
      ];
}
