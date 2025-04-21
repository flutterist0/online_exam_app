// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exam_results_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExamResultsModel _$ExamResultsModelFromJson(Map<String, dynamic> json) =>
    ExamResultsModel(
      data: (json['data'] as List<dynamic>?)
          ?.map(
              (e) => ExamsResultsModelData.fromJson(e as Map<String, dynamic>))
          .toList(),
      success: json['success'] as bool?,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$ExamResultsModelToJson(ExamResultsModel instance) =>
    <String, dynamic>{
      'data': instance.data,
      'success': instance.success,
      'message': instance.message,
    };

ExamsResultsModelData _$ExamsResultsModelDataFromJson(
        Map<String, dynamic> json) =>
    ExamsResultsModelData(
      examId: (json['examId'] as num?)?.toInt(),
      userId: (json['userId'] as num?)?.toInt(),
      correctAnswers: (json['correctAnswers'] as num?)?.toInt(),
      totalAnswers: (json['totalAnswers'] as num?)?.toInt(),
      score: (json['score'] as num?)?.toInt(),
      questions: (json['questions'] as List<dynamic>?)
          ?.map((e) => ExamsResultsModelDataQuestions.fromJson(
              e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ExamsResultsModelDataToJson(
        ExamsResultsModelData instance) =>
    <String, dynamic>{
      'examId': instance.examId,
      'userId': instance.userId,
      'correctAnswers': instance.correctAnswers,
      'totalAnswers': instance.totalAnswers,
      'score': instance.score,
      'questions': instance.questions,
    };

ExamsResultsModelDataQuestions _$ExamsResultsModelDataQuestionsFromJson(
        Map<String, dynamic> json) =>
    ExamsResultsModelDataQuestions(
      questionId: (json['questionId'] as num?)?.toInt(),
      questionText: json['questionText'] as String?,
      userAnswerText: json['userAnswerText'] as String?,
      isCorrect: json['isCorrect'] as bool?,
      correctAnswerText: json['correctAnswerText'] as String?,
    );

Map<String, dynamic> _$ExamsResultsModelDataQuestionsToJson(
        ExamsResultsModelDataQuestions instance) =>
    <String, dynamic>{
      'questionId': instance.questionId,
      'questionText': instance.questionText,
      'userAnswerText': instance.userAnswerText,
      'isCorrect': instance.isCorrect,
      'correctAnswerText': instance.correctAnswerText,
    };
