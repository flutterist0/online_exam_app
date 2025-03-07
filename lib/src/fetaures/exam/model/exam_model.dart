import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'exam_model.g.dart';

@JsonSerializable()
class ExamDataModel extends Equatable {
  const ExamDataModel(
      {this.id,
      this.title,
      this.description,
      this.createdTime,
      this.isDeleted,
      this.hasParticipated});

  final int? id;
  final String? title;
  final String? description;
  final DateTime? createdTime;
  final bool? isDeleted;
  final bool? hasParticipated;

  factory ExamDataModel.fromJson(Map<String, dynamic> json) =>
      _$ExamDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$ExamDataModelToJson(this);

  @override
  List<Object?> get props => [id, title, description, createdTime, isDeleted];
}

@JsonSerializable()
class ExamModel extends Equatable {
  const ExamModel({this.data, this.success, this.message});

  final List<ExamDataModel>? data;
  final bool? success;
  final String? message;

  factory ExamModel.fromJson(Map<String, dynamic> json) =>
      _$ExamModelFromJson(json);

  Map<String, dynamic> toJson() => _$ExamModelToJson(this);

  @override
  List<Object?> get props => [data, success, message];
}
