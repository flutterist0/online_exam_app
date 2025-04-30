import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:online_exam_app/src/core/storage/secure_storage.dart';
import 'package:online_exam_app/src/fetaures/exam/model/exam_result_model.dart';
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
  final Map<int, bool> _examResultsVisibility = {};
  final Map<int, ExamResultModel?> _examResults = {};

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

    if (_examResultsVisibility[examId]! && _examResults[examId] == null) {
      BlocProvider.of<ExamBloc>(context).add(
        GetExamResultEvent(userId: userId, examId: examId),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Participated Exams"),
        backgroundColor: Colors.deepPurple,
      ),
      body: BlocListener<ExamBloc, ExamState>(
        listener: (context, state) {
          if (state.examResultModel != null) {
            setState(() {
              _examResults[state.examResultModel!.data!.examId!] =
                  state.examResultModel;
            });
          }
        },
        child: BlocBuilder<ExamBloc, ExamState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state.errorMessage != null) {
              return Center(child: Text('Error: ${state.errorMessage}'));
            }
            if (state.examModel == null) {
              return const Center(child: Text("No exams available"));
            }

            // final exams = state.examModel?.data
            //     ?.where((exam) => exam.isDeleted == false)
            //     .toList();
            // ;
            // if (exams == null || exams.isEmpty) {
            //   return const Center(child: Text("No exams available"));
            // }
            // final exams = state.examResultsModel?.data;

            return ListView.builder(
              itemCount: state.examResultsModel?.data?.length,
              itemBuilder: (context, index) {
                final exam = state.examResultsModel?.data?[index];

                _examResultsVisibility.putIfAbsent(
                    exam?.examId ?? 0, () => false);

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Card(
                      margin: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 16),
                      elevation: 5,
                      child: ListTile(
                        title: Text(exam?.examTitle ?? 'No title'),
                        subtitle: Text(
                            "Date: ${DateFormat('dd MMMM yyyy').format(exam?.createdDate ?? DateTime.now())}"),
                        trailing: IconButton(
                          icon: Icon(
                            _examResultsVisibility[exam?.examId!] ?? false
                                ? Icons.expand_less
                                : Icons.expand_more,
                          ),
                          onPressed: () =>
                              toggleExamResultVisibility(exam?.examId ?? 0),
                        ),
                      ),
                    ),
                    if (_examResultsVisibility[exam?.examId] == true)
                      _buildExamResult(exam?.examId ?? 0),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildExamResult(int examId) {
    final examResult = _examResults[examId];

    if (examResult == null) {
      return const Center(child: CircularProgressIndicator());
    }

    final questions = examResult.data?.questions ?? [];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Score: ${examResult.data?.correctAnswers}/${examResult.data?.totalAnswers}",
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
          const SizedBox(height: 20),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
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
                      Text(
                        "Your Answer: ${question.userAnswerText}",
                        style: TextStyle(
                            color: isCorrect ? Colors.green : Colors.red),
                      ),
                      Text(
                        "Correct Answer: ${question.correctAnswerText}",
                        style: const TextStyle(color: Colors.blue),
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
  }
}
