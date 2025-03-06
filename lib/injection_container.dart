import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:online_exam_app/src/core/interceptor/jwt_interceptor.dart';
import 'package:online_exam_app/src/fetaures/auth/presentation/bloc/auth_bloc.dart';
import 'package:online_exam_app/src/fetaures/auth/repository/auth_repo.dart';
import 'package:online_exam_app/src/fetaures/auth/repository/auth_repo_impl.dart';
import 'package:online_exam_app/src/fetaures/auth/service/auth_service.dart';
import 'package:online_exam_app/src/fetaures/exam/presentation/bloc/exam_bloc.dart';
import 'package:online_exam_app/src/fetaures/exam/repository/exam_repo.dart';
import 'package:online_exam_app/src/fetaures/exam/repository/exam_repo_impl.dart';
import 'package:online_exam_app/src/fetaures/exam/service/exam_service.dart';

GetIt s1 = GetIt.instance;

Future<void> initializeDependencies() async {
  final Dio initialDio = Dio();
  initialDio.options = BaseOptions(
    headers: {
      'Content-Type': 'application/json',
    },
    contentType: 'application/json',
    connectTimeout: const Duration(seconds: 10),
  );
  initialDio.interceptors.add(LogInterceptor());
  final Dio baseDio = Dio();
  baseDio.options = BaseOptions(
    headers: {
      'Content-Type': 'application/json',
    },
    contentType: 'application/json',
    connectTimeout: const Duration(seconds: 10),
  );
  baseDio.interceptors.addAll([JwtInterceptor(), LogInterceptor()]);
  s1.registerSingleton(initialDio, instanceName: 'initialDio');
  s1.registerSingleton(baseDio, instanceName: 'baseDio');

  //service
  s1.registerLazySingleton<AuthService>(
    () => AuthService(
      s1<Dio>(instanceName: 'initialDio'),
    ),
  );
  s1.registerLazySingleton<ExamService>(
    () => ExamService(
      s1<Dio>(instanceName: 'baseDio'),
    ),
  );

  //repository
  s1.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(s1<AuthService>()),
  );

  s1.registerLazySingleton<ExamRepository>(
    () => ExamRepositoryImpl(s1<ExamService>()),
  );

  //bloc
  s1.registerFactory<AuthBloc>(
    () => AuthBloc(s1<AuthRepository>()),
  );
  s1.registerFactory<ExamBloc>(
    () => ExamBloc(s1<ExamRepository>()),
  );
}
