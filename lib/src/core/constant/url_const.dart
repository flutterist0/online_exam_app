abstract class UrlConst {
  //10.0.2.2
  static const String baseUrl = 'https://10.0.2.2:7010/api/';
  static const String login = 'Auth/login/';
  static const String register = 'Auth/register/';
  static const String getAllExams = 'Exam/getAllExams/';
  static const String examDetail = 'Exam/examDetail/{examId}';
  static const String submitExam = 'Exam/submitExam/';
  static const String examResult = 'ExamResult/getExamResults';
  static const String examResults = 'ExamResult/getExamResultsByUserId';
  static const String setPin = 'Auth/set-pin';
  static const String checkPin = 'Auth/login-with-pin';
}
