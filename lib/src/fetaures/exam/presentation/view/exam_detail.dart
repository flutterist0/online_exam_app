import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ExamDetailView extends StatefulWidget {
  const ExamDetailView({super.key});

  @override
  State<ExamDetailView> createState() => _ExamDetailViewState();
}

class _ExamDetailViewState extends State<ExamDetailView> {
  final Map<String, dynamic> examData = {
    "title": "First Exam",
    "description": "Good Luck!",
    "questions": [
      {
        "questionId": 2,
        "text": "Question2",
        "answers": [
          {"answerId": 1, "text": "A"},
          {"answerId": 2, "text": "B"},
          {"answerId": 3, "text": "C"},
          {"answerId": 4, "text": "D"}
        ]
      },
      {
        "questionId": 3,
        "text": "Sual1",
        "answers": [
          {"answerId": 5, "text": "A"},
          {"answerId": 6, "text": "B"},
          {"answerId": 7, "text": "C"}
        ]
      }
    ]
  };

  Map<int, int?> selectedAnswers = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(examData["title"]),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              examData["description"],
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: examData["questions"].length,
                itemBuilder: (context, index) {
                  var question = examData["questions"][index];
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
                            "${index + 1}. ${question["text"]}",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 10),
                          ...List.generate(question["answers"].length, (i) {
                            var answer = question["answers"][i];
                            return RadioListTile<int>(
                              title: Text(answer["text"]),
                              value: answer["answerId"],
                              groupValue:
                                  selectedAnswers[question["questionId"]],
                              onChanged: (value) {
                                setState(() {
                                  selectedAnswers[question["questionId"]] =
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
            ElevatedButton(
              onPressed: () {
                print(selectedAnswers);
              },
              child: Text("Submit"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                padding: EdgeInsets.symmetric(vertical: 12),
                textStyle: TextStyle(fontSize: 18),
              ),
            )
          ],
        ),
      ),
    );
  }
}
