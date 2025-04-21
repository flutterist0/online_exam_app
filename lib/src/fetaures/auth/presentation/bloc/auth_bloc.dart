import 'package:bloc/bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:online_exam_app/src/core/resource/data_state.dart';
import 'package:online_exam_app/src/core/storage/secure_storage.dart';
import 'package:online_exam_app/src/fetaures/auth/model/login_response_model.dart';
import 'package:online_exam_app/src/fetaures/auth/presentation/bloc/auth_event.dart';
import 'package:online_exam_app/src/fetaures/auth/presentation/bloc/auth_state.dart';
import 'package:online_exam_app/src/fetaures/auth/repository/auth_repo.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;
  AuthBloc(this.authRepository) : super(AuthInitial()) {
    on<LoginRequested>((event, emit) async {
      emit(AuthLoading());

      final dataState = await authRepository.login(event.loginRequest);

      if (dataState is DataSuccess && dataState.data != null) {
        emit(
          AuthLoginSuccess(dataState.data),
        );
      } else {
        emit(
          AuthFailure(dataState.error?.message),
        );
      }
    });

    on<RegisterRequested>((event, emit) async {
      emit(AuthLoading());
      final dataState = await authRepository.register(event.registerRequest);
      if (dataState is DataSuccess && dataState.data != null) {
        emit(
          AuthRegisterSuccess(dataState.data!),
        );
      } else {
        emit(
          AuthFailure(dataState.error!.message!),
        );
      }
    });
    on<LogoutRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        await SecureStorage.deleteToken();
        await SecureStorage.deleteUserId();
        print('token silindi');

        emit(AuthInitial());
      } catch (e) {
        emit(AuthFailure('Failed to logout'));
      }
    });
    on<SetPinEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        final dataState = await authRepository.setPin(event.setPinRequestModel);

        if (dataState is DataSuccess && dataState.data != null) {
          emit(
            AuthPinSuccess(),
          );
        } else {
          emit(
            AuthFailure(dataState.error?.message),
          );
        }
      } catch (e) {
        print("Error: $e");
        emit(AuthFailure('Failed to check pin'));
      }
    });
    on<CheckPinEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        final dataState =
            await authRepository.checkPin(event.setPinRequestModel);
        if (dataState is DataSuccess) {
          emit(
            AuthPinSuccess(),
          );
        } else {
          emit(
            AuthFailure('Pin kod duzgun deyill!!'),
          );
        }
      } catch (e) {
        print("Error: $e");
        emit(AuthFailure('Failed to set pin'));
      }
    });
  }
}
