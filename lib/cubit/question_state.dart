part of 'question_cubit.dart';

abstract class QuestionState extends Equatable {
  const QuestionState();

  @override
  List<Object> get props => [];
}

class QuestionInitial extends QuestionState {}

class QuestionLoading extends QuestionState {}

class QuestionSuccess extends QuestionState {
  final List<QuestionModel> questions;

  const QuestionSuccess(this.questions);

  @override
  List<Object> get props => [questions];
}

class QuestionFailed extends QuestionState {
  final String error;

  const QuestionFailed(this.error);

  @override
  List<Object> get props => [error];
}
