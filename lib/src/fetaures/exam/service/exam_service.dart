import 'package:dio/dio.dart';
import 'package:online_exam_app/src/core/constant/url_const.dart';
import 'package:online_exam_app/src/fetaures/exam/model/exam_detail_model.dart';
import 'package:online_exam_app/src/fetaures/exam/model/exam_model.dart';
import 'package:online_exam_app/src/fetaures/exam/model/submit_exam_request_model.dart';
import 'package:retrofit/retrofit.dart';
part 'exam_service.g.dart';

@RestApi(baseUrl: UrlConst.baseUrl)
abstract class ExamService {
  factory ExamService(Dio dio) {
    return _ExamService(dio);
  }

  @GET(UrlConst.getAllExams)
  Future<HttpResponse<ExamModel>> getAllExams();

  @GET(UrlConst.examDetail)
  Future<HttpResponse<ExamDetailModel>> getExamDetail(
      @Path('examId') int examId);

  @POST(UrlConst.submitExam)
  Future<HttpResponse<void>> submitExam(
      @Body() SubmitExamRequestModel submitExamRequestModel);
}
