import 'package:dio/dio.dart';
import 'package:online_exam_app/src/core/resource/data_state.dart';
import 'package:online_exam_app/src/fetaures/exam/model/exam_detail_model.dart';
import 'package:online_exam_app/src/fetaures/exam/model/exam_model.dart';
import 'package:online_exam_app/src/fetaures/exam/model/exam_result_model.dart';
import 'package:online_exam_app/src/fetaures/exam/model/exam_results_model.dart';
import 'package:online_exam_app/src/fetaures/exam/model/submit_exam_request_model.dart';
import 'package:online_exam_app/src/fetaures/exam/repository/exam_repo.dart';
import 'package:online_exam_app/src/fetaures/exam/service/exam_service.dart';

class ExamRepositoryImpl implements ExamRepository {
  final ExamService _examService;
  const ExamRepositoryImpl(this._examService);

  @override
  Future<DataState<ExamModel>> getAllExams() async {
    try {
      final httpResponse = await _examService.getAllExams();
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
  Future<DataState<ExamDetailModel>> getExamDetail(int examId) async {
    try {
      final httpResponse = await _examService.getExamDetail(examId);
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
  Future<DataState<void>> submitExam(
      SubmitExamRequestModel submitExamRequestModel) async {
    try {
      final httpResponse =
          await _examService.submitExam(submitExamRequestModel);
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
  Future<DataState<ExamResultModel>> getExamResult(
      int userId, int examId) async {
    try {
      final httpResponse = await _examService.getExamResult(userId, examId);
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
  Future<DataState<ExamResultsModel>> getExamResults(int userId) async {
    try {
      final httpResponse = await _examService.getExamResults(userId);
      if (httpResponse.response.statusCode == 200) {
        print('ExamResultsModel: ${httpResponse.data.data}');
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
      print('${e.message}');
      return DataFailed(e.copyWith(
        response: Response<ErrorResponseModel>(
          requestOptions: e.requestOptions,
          data: ErrorResponseModel.fromJson(e.response?.data),
        ),
      ));
    }
  }
}
