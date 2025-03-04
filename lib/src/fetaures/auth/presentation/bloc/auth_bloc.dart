import 'package:bloc/bloc.dart';
import 'package:online_exam_app/src/core/resource/data_state.dart';
import 'package:online_exam_app/src/fetaures/auth/presentation/bloc/auth_event.dart';
import 'package:online_exam_app/src/fetaures/auth/presentation/bloc/auth_state.dart';
import 'package:online_exam_app/src/fetaures/auth/repository/auth_repo.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;
  AuthBloc({required this.authRepository}) : super(AuthInitial()) {
    on<LoginRequested>((event, emit) async {
      emit(AuthLoading());

      final dataState = await authRepository.login(event.loginRequest);

      emit(AuthLoginSuccess(dataState.data!));
      if (dataState is DataSuccess) {
        emit(
          AuthLoginSuccess(dataState.data!),
        );
      } else {
        emit(
          AuthFailure(dataState.error!.message!),
        );
      }
    });
  }
}
