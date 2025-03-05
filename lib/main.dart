import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_exam_app/injection_container.dart';
import 'package:online_exam_app/src/core/storage/secure_storage.dart';
import 'package:online_exam_app/src/fetaures/auth/presentation/bloc/auth_bloc.dart';
import 'package:online_exam_app/src/fetaures/auth/presentation/view/log_in.dart';
import 'package:online_exam_app/src/fetaures/exam/presentation/bloc/exam_bloc.dart';
import 'package:online_exam_app/src/fetaures/exam/presentation/view/exams_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  HttpOverrides.global = MyHttpOverrides();

  await initializeDependencies();
  String? token = await SecureStorage.readToken();
  runApp(MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (_) => s1<AuthBloc>(),
        ),
        BlocProvider<ExamBloc>(
          create: (_) => s1<ExamBloc>(),
        ),
      ],
      child: MyApp(
        isLoggedIn: token != null,
      )));
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.isLoggedIn});
  final bool isLoggedIn;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: isLoggedIn ? ExamsView() : LoginView(),
    );
  }
}
