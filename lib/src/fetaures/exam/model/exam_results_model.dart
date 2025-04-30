import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:online_exam_app/src/fetaures/exam/model/exam_result_model.dart';
part 'exam_results_model.g.dart';

@JsonSerializable()
class ExamResultsModel extends Equatable {
  final List<ExamsResultsModelData>? data;
  final bool? success;
  final String? message;

  ExamResultsModel({
    this.data,
    this.success,
    this.message,
  });
  factory ExamResultsModel.fromJson(Map<String, dynamic> json) =>
      _$ExamResultsModelFromJson(json);

  Map<String, dynamic> toJson() => _$ExamResultsModelToJson(this);
  @override
  // TODO: implement props
  List<Object?> get props => [data, success, message];
}

@JsonSerializable()
class ExamsResultsModelData extends Equatable {
  final int? examId;
  final int? userId;
  final int? correctAnswers;
  final int? totalAnswers;
  final int? score;
  final String? examTitle;
  final DateTime? createdDate;
  final List<ExamsResultsModelDataQuestions>? questions;

  ExamsResultsModelData({
    this.examId,
    this.userId,
    this.correctAnswers,
    this.totalAnswers,
    this.score,
    this.examTitle,
    this.createdDate,
    this.questions,
  });
  factory ExamsResultsModelData.fromJson(Map<String, dynamic> json) =>
      _$ExamsResultsModelDataFromJson(json);

  Map<String, dynamic> toJson() => _$ExamsResultsModelDataToJson(this);

  @override
  // TODO: implement props
  List<Object?> get props => [
        examId,
        userId,
        correctAnswers,
        totalAnswers,
        score,
        questions,
        examTitle,
        createdDate
      ];
}

@JsonSerializable()
class ExamsResultsModelDataQuestions extends Equatable {
  final int? questionId;
  final String? questionText;
  final String? userAnswerText;
  final bool? isCorrect;
  final String? correctAnswerText;

  ExamsResultsModelDataQuestions({
    this.questionId,
    this.questionText,
    this.userAnswerText,
    this.isCorrect,
    this.correctAnswerText,
  });
  factory ExamsResultsModelDataQuestions.fromJson(Map<String, dynamic> json) =>
      _$ExamsResultsModelDataQuestionsFromJson(json);

  Map<String, dynamic> toJson() => _$ExamsResultsModelDataQuestionsToJson(this);

  @override
  // TODO: implement props
  List<Object?> get props =>
      [questionId, questionText, userAnswerText, isCorrect, correctAnswerText];
}
