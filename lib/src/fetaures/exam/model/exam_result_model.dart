import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'exam_result_model.g.dart';

@JsonSerializable()
class ExamResultModelDataQuestions extends Equatable {
  final int? questionId;
  final String? questionText;
  final String? userAnswerText;
  final bool? isCorrect;
  final String? correctAnswerText;

  ExamResultModelDataQuestions({
    this.questionId,
    this.questionText,
    this.userAnswerText,
    this.isCorrect,
    this.correctAnswerText,
  });
  factory ExamResultModelDataQuestions.fromJson(Map<String, dynamic> json) =>
      _$ExamResultModelDataQuestionsFromJson(json);

  Map<String, dynamic> toJson() => _$ExamResultModelDataQuestionsToJson(this);

  @override
  // TODO: implement props
  List<Object?> get props =>
      [questionId, questionText, userAnswerText, isCorrect, correctAnswerText];
}

@JsonSerializable()
class ExamResultModelData extends Equatable {
  final int? examId;
  final int? userId;
  final int? correctAnswers;
  final int? totalAnswers;
  final int? score;
  final List<ExamResultModelDataQuestions>? questions;

  ExamResultModelData({
    this.examId,
    this.userId,
    this.correctAnswers,
    this.totalAnswers,
    this.score,
    this.questions,
  });
  factory ExamResultModelData.fromJson(Map<String, dynamic> json) =>
      _$ExamResultModelDataFromJson(json);

  Map<String, dynamic> toJson() => _$ExamResultModelDataToJson(this);

  @override
  // TODO: implement props
  List<Object?> get props =>
      [examId, userId, correctAnswers, totalAnswers, score, questions];
}

@JsonSerializable()
class ExamResultModel extends Equatable {
  final ExamResultModelData? data;
  final bool? success;
  final String? message;

  ExamResultModel({
    this.data,
    this.success,
    this.message,
  });
  factory ExamResultModel.fromJson(Map<String, dynamic> json) =>
      _$ExamResultModelFromJson(json);

  Map<String, dynamic> toJson() => _$ExamResultModelToJson(this);

  @override
  // TODO: implement props
  List<Object?> get props => [data, success, message];
}
