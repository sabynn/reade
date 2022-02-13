
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/question_model.dart';

class QuestionService {
  final CollectionReference _questionReference =
  FirebaseFirestore.instance.collection('questions');

  Future<List<QuestionModel>> fetchQuestions() async {
    try {
      QuerySnapshot result = await _questionReference.get();

      List<QuestionModel> questions = result.docs.map(
            (e) {
          return QuestionModel.fromJson(
              e.id, e.data() as Map<String, dynamic>);
        },
      ).toList();

      return questions;
    } catch (e) {
      rethrow;
    }
  }
}
