import 'package:dio/dio.dart';
import 'package:online_exam_app/src/core/constant/url_const.dart';
import 'package:online_exam_app/src/fetaures/auth/model/login_request_model.dart';
import 'package:online_exam_app/src/fetaures/auth/model/login_response_model.dart';
import 'package:online_exam_app/src/fetaures/auth/model/register_request_model.dart';
import 'package:online_exam_app/src/fetaures/auth/model/register_response_model.dart';
import 'package:retrofit/retrofit.dart';
part 'auth_service.g.dart';

@RestApi(baseUrl: UrlConst.baseUrl)
abstract class AuthService {
  factory AuthService(Dio dio) {
    return _AuthService(dio);
  }

  @POST(UrlConst.login)
  Future<HttpResponse<LoginResponseModel>> login(
      @Body() LoginRequest loginRequestModel);

  @POST(UrlConst.register)
  Future<HttpResponse<RegisterResponseModel>> register(
      @Body() RegisterRequest registerRequestModel);
}
