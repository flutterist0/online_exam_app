import 'package:json_annotation/json_annotation.dart';
part 'submit_exam_request_model.g.dart';

@JsonSerializable()
class SubmitExamRequestModelAnswers {
  final int? questionId;
  final int? answerId;

  SubmitExamRequestModelAnswers({
    this.questionId,
    this.answerId,
  });
  factory SubmitExamRequestModelAnswers.fromJson(Map<String, dynamic> json) =>
      _$SubmitExamRequestModelAnswersFromJson(json);

  Map<String, dynamic> toJson() => _$SubmitExamRequestModelAnswersToJson(this);
}

@JsonSerializable()
class SubmitExamRequestModel {
  final int? userId;
  final int? examId;
  final List<SubmitExamRequestModelAnswers>? answers;

  SubmitExamRequestModel({
    this.userId,
    this.examId,
    this.answers,
  });
  factory SubmitExamRequestModel.fromJson(Map<String, dynamic> json) =>
      _$SubmitExamRequestModelFromJson(json);
  Map<String, dynamic> toJson() => _$SubmitExamRequestModelToJson(this);
}
