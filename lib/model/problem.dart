import 'package:cloud_firestore/cloud_firestore.dart';

class Problem {
  int answer;
  int iSection;
  int mSection;
  int number;
  String problem;
  int sSection;
  String year;
  
  Problem({
    required this.answer,
    required this.iSection,
    required this.mSection,
    required this.number,
    required this.problem,
    required this.sSection,
    required this.year,
  });

  Map<String, dynamic> toMap() {
    return {
      'answer': answer,
      'iSection': iSection,
      'mSection': mSection,
      'number': number,
      'problem': problem,
      'sSection': sSection,
      'year': year,
    };
  }
}
