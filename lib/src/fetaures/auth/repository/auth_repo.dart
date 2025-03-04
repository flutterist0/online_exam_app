import 'package:online_exam_app/src/core/resource/data_state.dart';
import 'package:online_exam_app/src/fetaures/auth/model/login_request_model.dart';
import 'package:online_exam_app/src/fetaures/auth/model/login_response_model.dart';
import 'package:online_exam_app/src/fetaures/auth/model/register_request_model.dart';
import 'package:online_exam_app/src/fetaures/auth/model/register_response_model.dart';

abstract class AuthRepository {
  Future<DataState<LoginResponseModel>> login(LoginRequest loginRequestModel);

  Future<DataState<RegisterResponseModel>> register(
      RegisterRequest registerRequestModel);
}
