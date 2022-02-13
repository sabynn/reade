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
  final List<dynamic> schedule;
  final dynamic fileRecentInterview;
  final dynamic fileExpectedAnswer;
  final List<dynamic> videoFile;

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
    this.schedule = const [],
    this.videoFile = const [],
  });

  factory UserModel.fromJson(String id, Map<String, dynamic> json) => UserModel(
      email: json["email"],
      name: json["name"],
      dateOfBirth: json["dateOfBirth"],
      gender: json["gender"],
      education: json["education"],
      profileImage: json["profileImage"],
      interests: json["interests"],
      sentimentScores: json["sentimentScores"],
      toneScores: json["toneScores"],
      eyeVisibilityScores: json["eyeVisibilityScores"],
      smilingScores: json["smilingScores"],
      fileRecentInterview: json["fileRecentInterview"],
      fileExpectedAnswer: json["fileExpectedAnswer"],
      schedule: json["schedule"],
      videoFile: json["videoFile"],
      id: id);

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
        schedule,
        videoFile,
      ];
}
