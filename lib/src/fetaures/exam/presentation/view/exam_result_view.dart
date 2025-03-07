import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_exam_app/src/core/storage/secure_storage.dart';
import 'package:online_exam_app/src/fetaures/exam/presentation/bloc/exam_bloc.dart';
import 'package:online_exam_app/src/fetaures/exam/presentation/bloc/exam_event.dart';
import 'package:online_exam_app/src/fetaures/exam/presentation/bloc/exam_state.dart';

class ExamResultView extends StatefulWidget {
  const ExamResultView({
    super.key,
    this.examId,
  });
  final int? examId;

  @override
  State<ExamResultView> createState() => _ExamResultViewState();
}

class _ExamResultViewState extends State<ExamResultView> {
  int? userId;

  @override
  void initState() {
    super.initState();
    getUserIdAndFetchExamResult();
  }

  void getUserIdAndFetchExamResult() async {
    userId = await SecureStorage.readUserId();
    if (userId != null && widget.examId != null) {
      BlocProvider.of<ExamBloc>(context)
          .add(GetExamResultEvent(userId: userId, examId: widget.examId));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Exam Results"),
          backgroundColor: Colors.deepPurple),
      body: BlocBuilder<ExamBloc, ExamState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          final examResult = state.examResultModel?.data;
          if (examResult == null) {
            return const Center(child: Text("No results available"));
          }

          final questions = examResult.questions ?? [];

          return Padding(
            padding: const EdgeInsets.all(16.0),
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
                Expanded(
                  child: ListView.builder(
                    itemCount: questions.length,
                    itemBuilder: (context, index) {
                      final question = questions[index];
                      bool isCorrect = question.isCorrect ?? false;
                      return Card(
                        margin: const EdgeInsets.only(bottom: 10),
                        color: isCorrect ? Colors.green[50] : Colors.red[50],
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Q${index + 1}: ${question.questionText}",
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 5),
                              Text("Your Answer: ${question.userAnswerText}",
                                  style: TextStyle(
                                      color: isCorrect
                                          ? Colors.green
                                          : Colors.red)),
                              Text(
                                  "Correct Answer: ${question.correctAnswerText}",
                                  style: const TextStyle(color: Colors.blue)),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
