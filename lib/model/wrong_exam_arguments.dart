import 'package:black_bean/model/problem.dart';

class WrongExamArguments {
  final String degree;
  final String subject;
  final List<Problem> problems;

  WrongExamArguments(this.degree, this.subject, this.problems);
}
