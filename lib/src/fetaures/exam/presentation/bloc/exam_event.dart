import 'package:equatable/equatable.dart';
import 'package:online_exam_app/src/fetaures/exam/model/submit_exam_request_model.dart';

abstract class ExamEvent extends Equatable {
  const ExamEvent();

  @override
  List<Object?> get props => [];
}

class GetAllExams extends ExamEvent {
  const GetAllExams();
}

class GetExamDetail extends ExamEvent {
  final int? examId;
  const GetExamDetail({this.examId});
}

class SubmitExamEvent extends ExamEvent {
  final SubmitExamRequestModel? submitExamRequestModel;
  const SubmitExamEvent({this.submitExamRequestModel});
}
