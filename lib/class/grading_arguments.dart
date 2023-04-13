import '../model/problem.dart';

class GradingArguments {
  final List<int> corrects;
  final List<Problem> problems;

  GradingArguments(this.corrects, this.problems);
}
