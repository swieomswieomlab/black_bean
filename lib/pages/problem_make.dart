import 'package:flutter/material.dart';

class ProblemMake extends StatefulWidget {
  const ProblemMake({Key? key});

  @override
  State<ProblemMake> createState() => _ProblemMakeState();
}

class _ProblemMakeState extends State<ProblemMake> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        ElevatedButton(
            onPressed: (() {
              //
            }),
            child: const Text("Upload")),
        DropdownButtonsFormClass(),
      ],
    ));
  }
}

class DropdownButtonsFormClass extends StatefulWidget {
  const DropdownButtonsFormClass({Key? key});

  @override
  State<DropdownButtonsFormClass> createState() =>
      _DropdownButtonsFormClassState();
}

List<String> degree = ['High', 'Middle'];
List<String> subject = ['Math', 'Korean'];
List<String> year = ['2022-1', '2022-2', '2023-1'];
List<String> number = List.generate(20, (i) => (i + 1).toString());
List<String> majorSection = List.generate(4, (i) => (i + 1).toString());
List<String> interSection = List.generate(5, (i) => (i + 1).toString());
List<String> subSection = List.generate(6, (i) => (i + 1).toString());
List<String> answer = List.generate(4, (i) => (i + 1).toString());

class _DropdownButtonsFormClassState extends State<DropdownButtonsFormClass> {
  String? degreeDropdownValue = degree.first;
  String? subjectDropdownValue = subject.first;
  String? yearDropdownValue = year.first;
  String? numberDropdownValue = number.first;
  String? majorSectionDropdownValue = majorSection.first;
  String? interSectionDropdownValue = interSection.first;
  String? subSectionDropdownValue = subSection.first;
  String? answerDropdownValue = answer.first;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            customDropdownButton(degree, "구분", degreeDropdownValue,
                (value) => degreeDropdownValue = value),
            customDropdownButton(subject, "과목", subjectDropdownValue,
                (value) => subjectDropdownValue = value),
            customDropdownButton(year, "년도", yearDropdownValue,
                (value) => yearDropdownValue = value),
            customDropdownButton(number, "번호", numberDropdownValue,
                (value) => numberDropdownValue = value),
            customDropdownButton(majorSection, "대단원", majorSectionDropdownValue,
                (value) => majorSectionDropdownValue = value),
            customDropdownButton(interSection, "중단원", interSectionDropdownValue,
                (value) => interSectionDropdownValue = value),
            customDropdownButton(subSection, "소단원", subSectionDropdownValue,
                (value) => subSectionDropdownValue = value),
            customDropdownButton(answer, "정답", answerDropdownValue,
                (value) => answerDropdownValue = value),
          ],
        ),
        ElevatedButton(onPressed: () {}, child: const Text("Submit"))
      ],
    );
  }

  Widget customDropdownButton(List<dynamic> items, String des, String? value,
      Function(String?) onChanged) {
    return SizedBox(
      width: 100,
      height: 100,
      child: Column(
        children: [
          Text(des),
          DropdownButton(
              value: value,
              items: items.map<DropdownMenuItem<String>>((dynamic value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  onChanged(newValue);
                });
              }),
        ],
      ),
    );
  }
}
