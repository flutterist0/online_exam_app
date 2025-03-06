import 'package:online_exam_app/src/core/resource/data_state.dart';
import 'package:online_exam_app/src/fetaures/exam/model/exam_detail_model.dart';
import 'package:online_exam_app/src/fetaures/exam/model/exam_model.dart';
import 'package:online_exam_app/src/fetaures/exam/model/submit_exam_request_model.dart';

abstract class ExamRepository {
  Future<DataState<ExamModel>> getAllExams();
  Future<DataState<ExamDetailModel>> getExamDetail(int examId);
  Future<DataState<void>> submitExam(
      SubmitExamRequestModel submitExamRequestModel);
}
