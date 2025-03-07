// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exam_results_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExamResultsModel _$ExamResultsModelFromJson(Map<String, dynamic> json) =>
    ExamResultsModel(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => ExamResultModelData.fromJson(e as Map<String, dynamic>))
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
