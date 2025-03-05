import 'package:bloc/bloc.dart';
import 'package:online_exam_app/src/core/resource/data_state.dart';
import 'package:online_exam_app/src/fetaures/exam/presentation/bloc/exam_event.dart';
import 'package:online_exam_app/src/fetaures/exam/presentation/bloc/exam_state.dart';
import 'package:online_exam_app/src/fetaures/exam/repository/exam_repo.dart';

class ExamBloc extends Bloc<ExamEvent, ExamState> {
  final ExamRepository examRepository;
  ExamBloc(this.examRepository) : super(ExamInitial()) {
    on<GetAllExams>((event, emit) async {
      emit(ExamLoading());
      final dataState = await examRepository.getAllExams();
      if (dataState is DataSuccess && dataState.data != null) {
        emit(ExamGetAllSuccess(dataState.data!));
      } else {
        emit(ExamFailure(dataState.error?.message));
      }
    });
  }
}
