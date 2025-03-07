// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exam_result_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExamResultModelDataQuestions _$ExamResultModelDataQuestionsFromJson(
        Map<String, dynamic> json) =>
    ExamResultModelDataQuestions(
      questionId: (json['questionId'] as num?)?.toInt(),
      questionText: json['questionText'] as String?,
      userAnswerText: json['userAnswerText'] as String?,
      isCorrect: json['isCorrect'] as bool?,
      correctAnswerText: json['correctAnswerText'] as String?,
    );

Map<String, dynamic> _$ExamResultModelDataQuestionsToJson(
        ExamResultModelDataQuestions instance) =>
    <String, dynamic>{
      'questionId': instance.questionId,
      'questionText': instance.questionText,
      'userAnswerText': instance.userAnswerText,
      'isCorrect': instance.isCorrect,
      'correctAnswerText': instance.correctAnswerText,
    };

ExamResultModelData _$ExamResultModelDataFromJson(Map<String, dynamic> json) =>
    ExamResultModelData(
      examId: (json['examId'] as num?)?.toInt(),
      userId: (json['userId'] as num?)?.toInt(),
      correctAnswers: (json['correctAnswers'] as num?)?.toInt(),
      totalAnswers: (json['totalAnswers'] as num?)?.toInt(),
      score: (json['score'] as num?)?.toInt(),
      questions: (json['questions'] as List<dynamic>?)
          ?.map((e) =>
              ExamResultModelDataQuestions.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ExamResultModelDataToJson(
        ExamResultModelData instance) =>
    <String, dynamic>{
      'examId': instance.examId,
      'userId': instance.userId,
      'correctAnswers': instance.correctAnswers,
      'totalAnswers': instance.totalAnswers,
      'score': instance.score,
      'questions': instance.questions,
    };

ExamResultModel _$ExamResultModelFromJson(Map<String, dynamic> json) =>
    ExamResultModel(
      data: json['data'] == null
          ? null
          : ExamResultModelData.fromJson(json['data'] as Map<String, dynamic>),
      success: json['success'] as bool?,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$ExamResultModelToJson(ExamResultModel instance) =>
    <String, dynamic>{
      'data': instance.data,
      'success': instance.success,
      'message': instance.message,
    };
