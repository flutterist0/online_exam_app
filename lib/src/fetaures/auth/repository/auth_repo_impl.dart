import 'package:dio/dio.dart';
import 'package:online_exam_app/src/core/resource/data_state.dart';
import 'package:online_exam_app/src/core/storage/secure_storage.dart';
import 'package:online_exam_app/src/fetaures/auth/model/login_request_model.dart';
import 'package:online_exam_app/src/fetaures/auth/model/login_response_model.dart';
import 'package:online_exam_app/src/fetaures/auth/model/register_request_model.dart';
import 'package:online_exam_app/src/fetaures/auth/model/register_response_model.dart';
import 'package:online_exam_app/src/fetaures/auth/repository/auth_repo.dart';
import 'package:online_exam_app/src/fetaures/auth/service/auth_service.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthService _authService;
  const AuthRepositoryImpl(this._authService);
  @override
  Future<DataState<LoginResponseModel>> login(
      LoginRequest loginRequestModel) async {
    try {
      final httpResponse = await _authService.login(loginRequestModel);
      if (httpResponse.response.statusCode == 200 &&
          httpResponse.response.data['code'] == 200) {
        String token = httpResponse.response.data['token'];
        await SecureStorage.saveToken(token);
        return DataSuccess(httpResponse.response.data);
      } else {
        return DataFailed(
          DioException(
            requestOptions: httpResponse.response.requestOptions,
            error: httpResponse.response.data,
            type: DioExceptionType.badResponse,
            response: Response<ErrorResponseModel>(
              requestOptions: httpResponse.response.requestOptions,
              data: ErrorResponseModel.fromJson(httpResponse.response.data),
            ),
          ),
        );
      }
    } on DioException catch (e) {
      return DataFailed(e.copyWith(
        response: Response<ErrorResponseModel>(
          requestOptions: e.requestOptions,
          data: ErrorResponseModel.fromJson(e.response?.data),
        ),
      ));
    }
  }

  @override
  Future<DataState<RegisterResponseModel>> register(
      RegisterRequest registerRequestModel) async {
    try {
      final httpResponse = await _authService.register(registerRequestModel);
      if (httpResponse.response.statusCode == 200) {
        return DataSuccess(httpResponse.data);
      } else {
        return DataFailed(
          DioException(
            requestOptions: httpResponse.response.requestOptions,
            error: httpResponse.response.data,
            type: DioExceptionType.badResponse,
            response: Response<ErrorResponseModel>(
              requestOptions: httpResponse.response.requestOptions,
              data: ErrorResponseModel.fromJson(httpResponse.response.data),
            ),
          ),
        );
      }
    } on DioException catch (e) {
      return DataFailed(e.copyWith(
        response: Response<ErrorResponseModel>(
          requestOptions: e.requestOptions,
          data: ErrorResponseModel.fromJson(e.response?.data),
        ),
      ));
    }
  }
}
