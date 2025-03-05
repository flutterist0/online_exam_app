import 'package:json_annotation/json_annotation.dart';
part 'exam_detail_model.g.dart';

@JsonSerializable()
class ExamDetailDataQuestionsAnswers {
  final int? answerId;
  final String? text;
  final bool? isCorrect;

  ExamDetailDataQuestionsAnswers({
    this.answerId,
    this.text,
    this.isCorrect,
  });
  factory ExamDetailDataQuestionsAnswers.fromJson(Map<String, dynamic> json) =>
      _$ExamDetailDataQuestionsAnswersFromJson(json);

  Map<String, dynamic> toJson() => _$ExamDetailDataQuestionsAnswersToJson(this);
}

@JsonSerializable()
class ExamDetailDataQuestions {
  final int? questionId;
  final String? text;
  final List<ExamDetailDataQuestionsAnswers>? answers;

  ExamDetailDataQuestions({
    this.questionId,
    this.text,
    this.answers,
  });
  factory ExamDetailDataQuestions.fromJson(Map<String, dynamic> json) =>
      _$ExamDetailDataQuestionsFromJson(json);

  Map<String, dynamic> toJson() => _$ExamDetailDataQuestionsToJson(this);
}

@JsonSerializable()
class ExamDetailData {
  final int? examId;
  final String? title;
  final String? description;
  final List<ExamDetailDataQuestions>? questions;

  ExamDetailData({
    this.examId,
    this.title,
    this.description,
    this.questions,
  });
  factory ExamDetailData.fromJson(Map<String, dynamic> json) =>
      _$ExamDetailDataFromJson(json);

  Map<String, dynamic> toJson() => _$ExamDetailDataToJson(this);
}

@JsonSerializable()
class ExamDetailModel {
  ExamDetailModel({
    this.data,
    this.success,
    this.message,
  });
  final ExamDetailData? data;
  final bool? success;
  final String? message;
  factory ExamDetailModel.fromJson(Map<String, dynamic> json) =>
      _$ExamDetailModelFromJson(json);

  Map<String, dynamic> toJson() => _$ExamDetailModelToJson(this);
}
