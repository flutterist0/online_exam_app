import 'package:equatable/equatable.dart';
import 'package:online_exam_app/src/fetaures/auth/model/login_response_model.dart';
import 'package:online_exam_app/src/fetaures/auth/model/register_response_model.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthLoginSuccess extends AuthState {
  final LoginResponseModel? loginModel;

  const AuthLoginSuccess(this.loginModel);

  @override
  List<Object?> get props => [loginModel];
}

class AuthRegisterSuccess extends AuthState {
  final RegisterResponseModel registerModel;

  const AuthRegisterSuccess(this.registerModel);

  @override
  List<Object?> get props => [registerModel];
}

class AuthFailure extends AuthState {
  final String? error;

  const AuthFailure(this.error);

  @override
  List<Object?> get props => [error];
}
