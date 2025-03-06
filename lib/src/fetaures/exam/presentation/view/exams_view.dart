import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_exam_app/src/core/storage/secure_storage.dart';
import 'package:online_exam_app/src/fetaures/auth/presentation/bloc/auth_bloc.dart';
import 'package:online_exam_app/src/fetaures/auth/presentation/bloc/auth_event.dart';
import 'package:online_exam_app/src/fetaures/auth/presentation/view/log_in.dart';
import 'package:online_exam_app/src/fetaures/exam/presentation/bloc/exam_bloc.dart';
import 'package:online_exam_app/src/fetaures/exam/presentation/bloc/exam_event.dart';
import 'package:online_exam_app/src/fetaures/exam/presentation/bloc/exam_state.dart';
import 'package:online_exam_app/src/fetaures/exam/presentation/view/exam_detail.dart';
import 'package:online_exam_app/src/fetaures/exam/presentation/widget/exam_card.dart';

class ExamsView extends StatefulWidget {
  const ExamsView({super.key, this.userId});
  final int? userId;
  @override
  State<ExamsView> createState() => _ExamsViewState();
}

class _ExamsViewState extends State<ExamsView> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ExamBloc>(context).add(const GetAllExams());
  }

  @override
  Widget build(BuildContext context) {
    print('UserId: ${widget.userId}');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text('Exams'),
        actions: [
          IconButton(
            onPressed: () {
              BlocProvider.of<AuthBloc>(context).add(const LogoutRequested());
              Navigator.pushReplacement(
                context,
                CupertinoPageRoute(
                  builder: (context) => const LoginView(),
                ),
              );
            },
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BlocBuilder<ExamBloc, ExamState>(builder: (context, state) {
            if (state is ExamLoading) {
              return Center(child: const CircularProgressIndicator());
            } else if (state is ExamGetAllSuccess) {
              final exams = state.examModel!.data
                  ?.where((exam) => exam.isDeleted == false)
                  .toList();
              if (exams == null || exams.isEmpty) {
                return const Center(
                    child: Text('No incomplete exams available'));
              }
              return Expanded(
                child: ListView.builder(
                  itemCount: exams.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return ExamCard(
                      title: exams[index].title ?? 'No title',
                      description: exams[index].description ?? 'No description',
                      date: exams[index].createdTime ?? DateTime.now(),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BlocProvider.value(
                                      value: BlocProvider.of<ExamBloc>(context),
                                      child: ExamDetailView(
                                        examId: exams[index].id,
                                        userId: widget.userId,
                                      ),
                                    )));
                      },
                    );
                  },
                ),
              );
            } else if (state is ExamFailure) {
              return Center(
                child: Text('Error: ${state.errorMessage}'),
              );
            }
            return const Center(
              child: Text('No data available'),
            );
          }),
        ],
      ),
    );
  }
}
