import 'problem.dart';

class FullGradingArguments {
  final String degree;
  final String subject;
  final List<int> corrects;
  final List<Problem> problems;

  FullGradingArguments(this.degree, this.subject, this.corrects, this.problems);
}
