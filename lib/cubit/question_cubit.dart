import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../models/question_model.dart';
import '../services/question_service.dart';
part 'question_state.dart';

class QuestionCubit extends Cubit<QuestionState> {
  QuestionCubit() : super(QuestionInitial());

  void fetchQuestions() async {
    try {
      emit(QuestionLoading());

      List<QuestionModel> questions =
      await QuestionService().fetchQuestions();
      emit(QuestionSuccess(questions));
    } catch (e) {
      emit(QuestionFailed(e.toString()));
    }
  }
}
