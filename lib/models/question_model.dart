import 'package:equatable/equatable.dart';

class QuestionModel extends Equatable {
  final List<dynamic> hrInterview;

  const QuestionModel({
    required this.hrInterview,
  });

  factory QuestionModel.fromJson(String id, Map<String, dynamic> json) =>
      QuestionModel(
        hrInterview: json["hr_interview"]
      );

  Map<String, dynamic> toJson() => {
      "hr_interview": hrInterview
  };

  @override
  List<Object?> get props => [hrInterview];
}
