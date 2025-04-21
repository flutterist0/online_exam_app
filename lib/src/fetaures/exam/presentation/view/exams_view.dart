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
import 'package:online_exam_app/src/fetaures/exam/presentation/view/exams_results_view.dart';
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

  Future<void> _refreshExams() async {
    BlocProvider.of<ExamBloc>(context).add(const GetAllExams());
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _refreshExams,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          title: const Text('Exams'),
          actions: [
            IconButton(
              onPressed: () async {
                BlocProvider.of<AuthBloc>(context).add(const LogoutRequested());
                await SecureStorage.deletePinCodeForUser(widget.userId!);
                Navigator.pushReplacement(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => const LoginView(),
                  ),
                );
              },
              icon: const Icon(Icons.logout),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => const ExamsResultsView(),
                  ),
                );
              },
              icon: const Icon(Icons.list),
            )
          ],
        ),
        body: BlocBuilder<ExamBloc, ExamState>(builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.errorMessage != null) {
            return Center(child: Text('Error: ${state.errorMessage}'));
          } else if (state.examModel != null) {
            final exams = state.examModel!.data
                ?.where((exam) =>
                    exam.isDeleted == false && exam.hasParticipated == false)
                .toList();

            if (exams == null || exams.isEmpty) {
              return const Center(child: Text('No incomplete exams available'));
            }

            return ListView.builder(
              itemCount: exams.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final exam = exams[index];
                bool hasParticipated = exam.hasParticipated ?? false;

                return ExamCard(
                  title: exam.title ?? 'No title',
                  description: exam.description ?? 'No description',
                  date: exam.createdTime ?? DateTime.now(),
                  onTap: () {
                    // Only allow navigation if the user hasn't participated
                    if (!hasParticipated) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BlocProvider.value(
                            value: BlocProvider.of<ExamBloc>(context),
                            child: ExamDetailView(
                              examId: exam.id,
                            ),
                          ),
                        ),
                      );
                    }
                  },
                  icon: hasParticipated ? Icons.lock : null,
                );
              },
            );
          }
          return Center(
            child: IconButton(
              onPressed: _refreshExams,
              icon: const Icon(Icons.refresh, size: 60),
            ),
          );
        }),
      ),
    );
  }
}
