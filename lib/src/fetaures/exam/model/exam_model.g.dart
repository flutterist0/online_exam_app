// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exam_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExamDataModel _$ExamDataModelFromJson(Map<String, dynamic> json) =>
    ExamDataModel(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String?,
      description: json['description'] as String?,
      createdTime: json['createdTime'] == null
          ? null
          : DateTime.parse(json['createdTime'] as String),
      isDeleted: json['isDeleted'] as bool?,
    );

Map<String, dynamic> _$ExamDataModelToJson(ExamDataModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'createdTime': instance.createdTime?.toIso8601String(),
      'isDeleted': instance.isDeleted,
    };

ExamModel _$ExamModelFromJson(Map<String, dynamic> json) => ExamModel(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => ExamDataModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      success: json['success'] as bool?,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$ExamModelToJson(ExamModel instance) => <String, dynamic>{
      'data': instance.data,
      'success': instance.success,
      'message': instance.message,
    };
