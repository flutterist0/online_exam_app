import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:online_exam_app/src/fetaures/exam/model/exam_result_model.dart';
part 'exam_results_model.g.dart';

@JsonSerializable()
class ExamResultsModel extends Equatable {
  final List<ExamResultModelData>? data;
  final bool? success;
  final String? message;

  ExamResultsModel({
    this.data,
    this.success,
    this.message,
  });
  factory ExamResultsModel.fromJson(Map<String, dynamic> json) =>
      _$ExamResultsModelFromJson(json);

  Map<String, dynamic> toJson() => _$ExamResultsModelToJson(this);
  @override
  // TODO: implement props
  List<Object?> get props => [data, success, message];
}
