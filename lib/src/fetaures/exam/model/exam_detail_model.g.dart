// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exam_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExamDetailDataQuestionsAnswers _$ExamDetailDataQuestionsAnswersFromJson(
        Map<String, dynamic> json) =>
    ExamDetailDataQuestionsAnswers(
      answerId: (json['answerId'] as num?)?.toInt(),
      text: json['text'] as String?,
      isCorrect: json['isCorrect'] as bool?,
    );

Map<String, dynamic> _$ExamDetailDataQuestionsAnswersToJson(
        ExamDetailDataQuestionsAnswers instance) =>
    <String, dynamic>{
      'answerId': instance.answerId,
      'text': instance.text,
      'isCorrect': instance.isCorrect,
    };

ExamDetailDataQuestions _$ExamDetailDataQuestionsFromJson(
        Map<String, dynamic> json) =>
    ExamDetailDataQuestions(
      questionId: (json['questionId'] as num?)?.toInt(),
      text: json['text'] as String?,
      answers: (json['answers'] as List<dynamic>?)
          ?.map((e) => ExamDetailDataQuestionsAnswers.fromJson(
              e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ExamDetailDataQuestionsToJson(
        ExamDetailDataQuestions instance) =>
    <String, dynamic>{
      'questionId': instance.questionId,
      'text': instance.text,
      'answers': instance.answers,
    };

ExamDetailData _$ExamDetailDataFromJson(Map<String, dynamic> json) =>
    ExamDetailData(
      examId: (json['examId'] as num?)?.toInt(),
      title: json['title'] as String?,
      description: json['description'] as String?,
      questions: (json['questions'] as List<dynamic>?)
          ?.map((e) =>
              ExamDetailDataQuestions.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ExamDetailDataToJson(ExamDetailData instance) =>
    <String, dynamic>{
      'examId': instance.examId,
      'title': instance.title,
      'description': instance.description,
      'questions': instance.questions,
    };

ExamDetailModel _$ExamDetailModelFromJson(Map<String, dynamic> json) =>
    ExamDetailModel(
      data: json['data'] == null
          ? null
          : ExamDetailData.fromJson(json['data'] as Map<String, dynamic>),
      success: json['success'] as bool?,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$ExamDetailModelToJson(ExamDetailModel instance) =>
    <String, dynamic>{
      'data': instance.data,
      'success': instance.success,
      'message': instance.message,
    };
