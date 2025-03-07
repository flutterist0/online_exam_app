// import 'package:equatable/equatable.dart';
// import 'package:online_exam_app/src/fetaures/exam/model/exam_detail_model.dart';
// import 'package:online_exam_app/src/fetaures/exam/model/exam_model.dart';

// abstract class ExamState extends Equatable {
//   const ExamState();

//   @override
//   List<Object?> get props => [];
// }

// class ExamInitial extends ExamState {}

// class ExamLoading extends ExamState {}

// class ExamGetAllSuccess extends ExamState {
//   final ExamModel? examModel;
//   const ExamGetAllSuccess(this.examModel);
//   @override
//   List<Object?> get props => [examModel];
// }

// class ExamDetailSuccess extends ExamState {
//   final ExamDetailModel? examDetailModel;
//   const ExamDetailSuccess(this.examDetailModel);
//   @override
//   List<Object?> get props => [examDetailModel];
// }

// class SubmitExamSuccess extends ExamState {
//   const SubmitExamSuccess();
// }

// class ExamFailure extends ExamState {
//   final String? errorMessage;
//   const ExamFailure(this.errorMessage);

//   @override
//   List<Object?> get props => [errorMessage];
// }

import 'package:equatable/equatable.dart';
import 'package:online_exam_app/src/fetaures/exam/model/exam_detail_model.dart';
import 'package:online_exam_app/src/fetaures/exam/model/exam_model.dart';
import 'package:online_exam_app/src/fetaures/exam/model/exam_result_model.dart';
import 'package:online_exam_app/src/fetaures/exam/model/exam_results_model.dart';

class ExamState extends Equatable {
  final bool isLoading;
  final ExamModel? examModel;
  final ExamDetailModel? examDetailModel;
  final bool isSubmitSuccess;
  final String? errorMessage;
  final ExamResultModel? examResultModel;
  final ExamResultsModel? examResultsModel;

  const ExamState({
    this.isLoading = false,
    this.examModel,
    this.examDetailModel,
    this.isSubmitSuccess = false,
    this.errorMessage,
    this.examResultModel,
    this.examResultsModel,
  });

  ExamState copyWith({
    bool? isLoading,
    ExamModel? examModel,
    ExamDetailModel? examDetailModel,
    bool? isSubmitSuccess,
    String? errorMessage,
    ExamResultModel? examResultModel,
    ExamResultsModel? examResultsModel,
  }) {
    return ExamState(
      isLoading: isLoading ?? this.isLoading,
      examModel: examModel ?? this.examModel,
      examDetailModel: examDetailModel ?? this.examDetailModel,
      isSubmitSuccess: isSubmitSuccess ?? this.isSubmitSuccess,
      errorMessage: errorMessage ?? this.errorMessage,
      examResultModel: examResultModel ?? this.examResultModel,
      examResultsModel: examResultsModel ?? this.examResultsModel,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        examModel,
        examDetailModel,
        isSubmitSuccess,
        errorMessage,
        examResultModel,
        examResultsModel
      ];
}
