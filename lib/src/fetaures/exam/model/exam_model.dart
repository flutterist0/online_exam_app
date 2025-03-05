import 'package:json_annotation/json_annotation.dart';
part 'exam_model.g.dart';

@JsonSerializable()
class ExamDataModel {
  ExamDataModel(
      {this.id,
      this.title,
      this.description,
      this.createdTime,
      this.isDeleted});
  final int? id;
  final String? title;
  final String? description;
  final DateTime? createdTime;
  final bool? isDeleted;
  factory ExamDataModel.fromJson(Map<String, dynamic> json) =>
      _$ExamDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$ExamDataModelToJson(this);
}

@JsonSerializable()
class ExamModel {
  ExamModel({this.data, this.success, this.message});
  final List<ExamDataModel>? data;
  final bool? success;
  final String? message;
  factory ExamModel.fromJson(Map<String, dynamic> json) =>
      _$ExamModelFromJson(json);

  Map<String, dynamic> toJson() => _$ExamModelToJson(this);
}
