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

// year 문자열을 Front Style로 바꿔주는 함수
// "2022-1" => "2022년 1차"
String yearToKorean(String year) {
  return '${year.substring(0, 4)}년 ${year.substring(5)}차';
}

// Subject 문자열을 한글로 바꿔주는 함수
// 추후 다른 과목도 업데이트 필요
String subjectToKorean(String subject) {
  if (subject == 'Math') {
    return '수학';
  } else if (subject == 'Korean') {
    return '국어';
  } else {
    return '과목';
  }
}
