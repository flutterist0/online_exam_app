import 'package:online_exam_app/src/core/resource/data_state.dart';
import 'package:online_exam_app/src/fetaures/exam/model/exam_model.dart';

abstract class ExamRepository {
  Future<DataState<ExamModel>> getAllExams();
}
