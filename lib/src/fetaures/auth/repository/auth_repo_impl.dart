import 'package:dio/dio.dart';
import 'package:online_exam_app/src/core/resource/data_state.dart';
import 'package:online_exam_app/src/core/storage/secure_storage.dart';
import 'package:online_exam_app/src/fetaures/auth/model/login_request_model.dart';
import 'package:online_exam_app/src/fetaures/auth/model/login_response_model.dart';
import 'package:online_exam_app/src/fetaures/auth/model/pin_response_model.dart';
import 'package:online_exam_app/src/fetaures/auth/model/register_request_model.dart';
import 'package:online_exam_app/src/fetaures/auth/model/register_response_model.dart';
import 'package:online_exam_app/src/fetaures/auth/model/set_pin_request_model.dart';
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
      if (httpResponse.response.statusCode == 200) {
        final responseData = httpResponse.response.data;

        final loginResponse = LoginResponseModel.fromJson(responseData);

        String token = httpResponse.data.token!;
        int userId = httpResponse.data.userId!;
        print("Login Token: $token");
        await SecureStorage.saveToken(token);
        await SecureStorage.saveUserId(userId);
        print("Pincode: ${httpResponse.data.pinCode}");
        return DataSuccess(loginResponse);
      } else {
        print('Xeta');
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
      print('${e.message}');
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

  @override
  Future<DataState<PinResponseModel>> checkPin(
      SetPinRequestModel setPinRequestModel) async {
    try {
      final httpResponse = await _authService.checkPin(setPinRequestModel);
      if (httpResponse.response.data['success'] == true) {
        print('Repo check pin: ${httpResponse.data}');
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

  @override
  Future<DataState<PinResponseModel>> setPin(
      SetPinRequestModel setPinRequestModel) async {
    try {
      final httpResponse = await _authService.setPin(setPinRequestModel);
      if (httpResponse.response.statusCode == 200) {
        await SecureStorage.savePinCodeForUser(
            setPinRequestModel.userId, setPinRequestModel.pinCode);
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
