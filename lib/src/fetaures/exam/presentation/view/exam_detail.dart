import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_exam_app/src/core/storage/secure_storage.dart';
import 'package:online_exam_app/src/fetaures/auth/presentation/bloc/auth_bloc.dart';
import 'package:online_exam_app/src/fetaures/auth/presentation/bloc/auth_state.dart';
import 'package:online_exam_app/src/fetaures/exam/model/submit_exam_request_model.dart';
import 'package:online_exam_app/src/fetaures/exam/presentation/bloc/exam_bloc.dart';
import 'package:online_exam_app/src/fetaures/exam/presentation/bloc/exam_event.dart';
import 'package:online_exam_app/src/fetaures/exam/presentation/bloc/exam_state.dart';
import 'package:online_exam_app/src/fetaures/exam/presentation/view/exam_result_view.dart';

class ExamDetailView extends StatefulWidget {
  const ExamDetailView({
    super.key,
    this.examId,
  });
  final int? examId;
  @override
  State<ExamDetailView> createState() => _ExamDetailViewState();
}

class _ExamDetailViewState extends State<ExamDetailView> {
  Map<int, int?> selectedAnswers = {};

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<ExamBloc>(context)
        .add(GetExamDetail(examId: widget.examId));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ExamBloc, ExamState>(
      listener: (context, state) {
        if (state.isSubmitSuccess) {
          _showSuccessDialog(context);
          _showSuccessDialog(context);
          BlocProvider.of<ExamBloc>(context).add(ResetSubmitSuccessEvent());
        }
      },
      child: BlocBuilder<ExamBloc, ExamState>(builder: (context, state) {
        if (state.isLoading) {
          return Center(child: const CircularProgressIndicator());
        } else if (state.examDetailModel != null) {
          final exams = state.examDetailModel!.data;
          if (exams == null) {
            return const Center(child: Text('No exams available'));
          }
          return Scaffold(
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () async {
                  if (selectedAnswers.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Please answer all questions")),
                    );
                    return;
                  }

                  final answersList = selectedAnswers.entries
                      .map((entry) => SubmitExamRequestModelAnswers(
                            questionId: entry.key,
                            answerId: entry.value,
                          ))
                      .toList();
                  print('${answersList.length}');
                  int? userId = await SecureStorage.readUserId();
                  final submitRequest = SubmitExamRequestModel(
                    userId: userId,
                    examId: widget.examId,
                    answers: answersList,
                  );
                  print('${submitRequest.toJson()}');

                  BlocProvider.of<ExamBloc>(context).add(
                      SubmitExamEvent(submitExamRequestModel: submitRequest));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  padding: EdgeInsets.symmetric(vertical: 12),
                  textStyle: TextStyle(fontSize: 18),
                ),
                child: const Text(
                  "Submit",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            appBar: AppBar(
              title: Text('${exams.title}'),
              backgroundColor: Colors.deepPurple,
              actions: [
                IconButton(
                  onPressed: () async {
                    int? userId = await SecureStorage.readUserId();
                    BlocProvider.of<ExamBloc>(context).add(GetExamResultEvent(
                        userId: userId, examId: widget.examId));
                  },
                  icon: Icon(Icons.add),
                )
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${exams.description}',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                  ),
                  SizedBox(height: 20),
                  Expanded(
                    child: ListView.builder(
                      itemCount: exams.questions?.length,
                      itemBuilder: (context, index) {
                        var question = exams.questions?[index];
                        return Card(
                          margin: EdgeInsets.only(bottom: 15),
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${index + 1}. ${question?.text}",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 10),
                                ...List.generate(question!.answers!.length,
                                    (i) {
                                  var answer = question.answers?[i];
                                  return RadioListTile<int>(
                                    title: Text('${answer?.text}'),
                                    value: answer!.answerId!,
                                    groupValue:
                                        selectedAnswers[question.questionId],
                                    onChanged: (value) {
                                      setState(() {
                                        selectedAnswers[question.questionId!] =
                                            value;
                                      });
                                    },
                                    activeColor: Colors.deepPurple,
                                  );
                                })
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
          );
        } else if (state.errorMessage != null) {
          return Center(
            child: Text('Error: ${state.errorMessage}'),
          );
        }
        return const Center(
          child: Text('No data available'),
        );
      }),
    );
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Success"),
          content: const Text("Exam submitted successfully!"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              child: const Text("OK"),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ExamResultView(
                              examId: widget.examId,
                            )));
              },
              child: const Text("Go to result"),
            ),
          ],
        );
      },
    );
  }
}
