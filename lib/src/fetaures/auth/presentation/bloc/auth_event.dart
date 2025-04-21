import 'package:equatable/equatable.dart';
import 'package:online_exam_app/src/fetaures/auth/model/login_request_model.dart';
import 'package:online_exam_app/src/fetaures/auth/model/register_request_model.dart';
import 'package:online_exam_app/src/fetaures/auth/model/set_pin_request_model.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class LoginRequested extends AuthEvent {
  final LoginRequest loginRequest;

  const LoginRequested(this.loginRequest);

  @override
  List<Object?> get props => [loginRequest];
}

class RegisterRequested extends AuthEvent {
  final RegisterRequest registerRequest;

  const RegisterRequested(this.registerRequest);

  @override
  List<Object?> get props => [registerRequest];
}

class LogoutRequested extends AuthEvent {
  const LogoutRequested();
  @override
  List<Object?> get props => [];
}

class SetPinEvent extends AuthEvent {
  final SetPinRequestModel setPinRequestModel;
  const SetPinEvent(this.setPinRequestModel);
  @override
  List<Object?> get props => [setPinRequestModel];
}

class CheckPinEvent extends AuthEvent {
  final SetPinRequestModel setPinRequestModel;
  const CheckPinEvent(this.setPinRequestModel);
  @override
  List<Object?> get props => [setPinRequestModel];
}
