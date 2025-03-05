import 'package:equatable/equatable.dart';
import 'package:online_exam_app/src/fetaures/exam/model/exam_model.dart';

abstract class ExamState extends Equatable {
  const ExamState();

  @override
  List<Object?> get props => [];
}

class ExamInitial extends ExamState {}

class ExamLoading extends ExamState {}

class ExamGetAllSuccess extends ExamState {
  final ExamModel? examModel;
  const ExamGetAllSuccess(this.examModel);
  @override
  List<Object?> get props => [examModel];
}

class ExamFailure extends ExamState {
  final String? errorMessage;
  const ExamFailure(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
