import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_exam_app/src/core/storage/secure_storage.dart';
import 'package:online_exam_app/src/fetaures/exam/presentation/bloc/exam_bloc.dart';
import 'package:online_exam_app/src/fetaures/exam/presentation/bloc/exam_event.dart';
import 'package:online_exam_app/src/fetaures/exam/presentation/bloc/exam_state.dart';

class ExamsResultsView extends StatefulWidget {
  const ExamsResultsView({super.key});

  @override
  State<ExamsResultsView> createState() => _ExamsResultsViewState();
}

class _ExamsResultsViewState extends State<ExamsResultsView> {
  int? userId;
  Map<int, bool> _examResultsVisibility = {};

  @override
  void initState() {
    super.initState();
    getUserIdAndFetchExams();
  }

  void getUserIdAndFetchExams() async {
    userId = await SecureStorage.readUserId();
    if (userId != null) {
      BlocProvider.of<ExamBloc>(context)
          .add(GetExamsResultsEvent(userId: userId));
    }
  }

  void toggleExamResultVisibility(int examId) {
    setState(() {
      _examResultsVisibility[examId] = !_examResultsVisibility[examId]!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Participated Exams"),
        backgroundColor: Colors.deepPurple,
      ),
      body: BlocBuilder<ExamBloc, ExamState>(builder: (context, state) {
        if (state.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        final exams = state.examModel?.data;
        if (exams == null || exams.isEmpty) {
          return const Center(child: Text("No exams available"));
        }

        return ListView.builder(
          itemCount: exams.length,
          itemBuilder: (context, index) {
            final exam = exams[index];

            // Ensure visibility is tracked for each exam
            _examResultsVisibility.putIfAbsent(exam.id!, () => false);

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  margin:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                  elevation: 5,
                  child: ListTile(
                    title: Text(exam.title ?? 'No title'),
                    subtitle:
                        Text("Date: ${exam.createdTime ?? DateTime.now()}"),
                    trailing: IconButton(
                      icon: Icon(_examResultsVisibility[exam.id]!
                          ? Icons.expand_less
                          : Icons.expand_more),
                      onPressed: () {
                        toggleExamResultVisibility(exam.id!);
                        if (_examResultsVisibility[exam.id]!) {
                          BlocProvider.of<ExamBloc>(context).add(
                            GetExamResultEvent(userId: userId, examId: exam.id),
                          );
                        }
                      },
                    ),
                  ),
                ),
                if (_examResultsVisibility[exam.id] == true)
                  BlocBuilder<ExamBloc, ExamState>(
                    builder: (context, state) {
                      if (state.isLoading) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      final examResult = state.examResultModel?.data;
                      if (examResult == null) {
                        return const Center(child: Text("No result available"));
                      }

                      final questions = examResult.questions ?? [];

                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Score: ${examResult.correctAnswers}/${examResult.totalAnswers}",
                              style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green),
                            ),
                            const SizedBox(height: 20),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: questions.length,
                              itemBuilder: (context, index) {
                                final question = questions[index];
                                bool isCorrect = question.isCorrect ?? false;
                                return Card(
                                  margin: const EdgeInsets.only(bottom: 10),
                                  color: isCorrect
                                      ? Colors.green[50]
                                      : Colors.red[50],
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Q${index + 1}: ${question.questionText}",
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(height: 5),
                                        Text(
                                          "Your Answer: ${question.userAnswerText}",
                                          style: TextStyle(
                                              color: isCorrect
                                                  ? Colors.green
                                                  : Colors.red),
                                        ),
                                        Text(
                                          "Correct Answer: ${question.correctAnswerText}",
                                          style: const TextStyle(
                                              color: Colors.blue),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
              ],
            );
          },
        );
      }),
    );
  }
}
