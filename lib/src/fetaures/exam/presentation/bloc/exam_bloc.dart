import 'package:bloc/bloc.dart';
import 'package:online_exam_app/src/core/resource/data_state.dart';
import 'package:online_exam_app/src/fetaures/exam/presentation/bloc/exam_event.dart';
import 'package:online_exam_app/src/fetaures/exam/presentation/bloc/exam_state.dart';
import 'package:online_exam_app/src/fetaures/exam/repository/exam_repo.dart';

class ExamBloc extends Bloc<ExamEvent, ExamState> {
  final ExamRepository examRepository;

  ExamBloc(this.examRepository) : super(const ExamState()) {
    on<GetAllExams>((event, emit) async {
      emit(state.copyWith(isLoading: true));
      final dataState = await examRepository.getAllExams();
      if (dataState is DataSuccess && dataState.data != null) {
        emit(state.copyWith(isLoading: false, examModel: dataState.data));
      } else {
        emit(state.copyWith(
            isLoading: false, errorMessage: dataState.error?.message));
      }
    });

    on<GetExamDetail>((event, emit) async {
      emit(state.copyWith(isLoading: true));
      final dataState = await examRepository.getExamDetail(event.examId!);
      if (dataState is DataSuccess && dataState.data != null) {
        emit(state.copyWith(isLoading: false, examDetailModel: dataState.data));
      } else {
        emit(state.copyWith(
            isLoading: false, errorMessage: dataState.error?.message));
      }
    });

    on<SubmitExamEvent>((event, emit) async {
      emit(state.copyWith(isLoading: true));
      final dataState =
          await examRepository.submitExam(event.submitExamRequestModel!);
      if (dataState is DataSuccess) {
        emit(state.copyWith(isLoading: false, isSubmitSuccess: true));
      } else {
        emit(state.copyWith(
            isLoading: false, errorMessage: dataState.error?.message));
      }
    });
    on<ResetSubmitSuccessEvent>((event, emit) {
      emit(state.copyWith(isSubmitSuccess: false));
    });
    on<GetExamResultEvent>((event, emit) async {
      emit(state.copyWith(isLoading: true));
      final dataState =
          await examRepository.getExamResult(event.userId!, event.examId!);
      if (dataState is DataSuccess) {
        emit(state.copyWith(isLoading: false, examResultModel: dataState.data));
      } else {
        emit(state.copyWith(
            isLoading: false, errorMessage: dataState.error?.message));
      }
    });
    on<GetExamsResultsEvent>((event, emit) async {
      emit(state.copyWith(isLoading: true));
      final dataState = await examRepository.getExamResults(event.userId!);
      if (dataState is DataSuccess) {
        emit(
            state.copyWith(isLoading: false, examResultsModel: dataState.data));
      } else {
        emit(state.copyWith(
            isLoading: false, errorMessage: dataState.error?.message));
      }
    });
  }
}
