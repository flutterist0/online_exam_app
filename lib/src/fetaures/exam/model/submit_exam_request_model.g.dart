// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'submit_exam_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubmitExamRequestModelAnswers _$SubmitExamRequestModelAnswersFromJson(
        Map<String, dynamic> json) =>
    SubmitExamRequestModelAnswers(
      questionId: (json['questionId'] as num?)?.toInt(),
      answerId: (json['answerId'] as num?)?.toInt(),
    );

Map<String, dynamic> _$SubmitExamRequestModelAnswersToJson(
        SubmitExamRequestModelAnswers instance) =>
    <String, dynamic>{
      'questionId': instance.questionId,
      'answerId': instance.answerId,
    };

SubmitExamRequestModel _$SubmitExamRequestModelFromJson(
        Map<String, dynamic> json) =>
    SubmitExamRequestModel(
      userId: (json['userId'] as num?)?.toInt(),
      examId: (json['examId'] as num?)?.toInt(),
      answers: (json['answers'] as List<dynamic>?)
          ?.map((e) =>
              SubmitExamRequestModelAnswers.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SubmitExamRequestModelToJson(
        SubmitExamRequestModel instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'examId': instance.examId,
      'answers': instance.answers,
    };
