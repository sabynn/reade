import 'package:equatable/equatable.dart';

class QuestionModel extends Equatable {
  final List<dynamic> userInterview;

  const QuestionModel({
    required this.userInterview,
  });

  factory QuestionModel.fromJson(String id, Map<String, dynamic> json) =>
      QuestionModel(
        userInterview: json["user_interview"]
      );

  Map<String, dynamic> toJson() => {
      "user_interview": userInterview
  };

  @override
  List<Object?> get props => [userInterview];
}
