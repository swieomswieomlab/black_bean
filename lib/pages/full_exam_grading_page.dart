import 'package:flutter/material.dart';

import '../model/wrong_exam_arguments.dart';
import '../textstyle.dart';
import '../model/full_grading_arguments.dart';
import '../components.dart';
import '../model/problem.dart';

class FullExamGradingPage extends StatefulWidget {
  const FullExamGradingPage({Key? key, required this.arguments})
      : super(key: key);
  final FullGradingArguments arguments;

  @override
  FullExamGradingPageState createState() => FullExamGradingPageState();
}

class FullExamGradingPageState extends State<FullExamGradingPage> {
  late String degree;
  late String subject;
  late List<int> correctNumbers;
  late List<Problem> problems;
  late List<int> wrongNumbers;

  @override
  void initState() {
    super.initState();
    var args = widget.arguments;
    degree = args.degree;
    subject = args.subject;
    problems = args.problems;
    correctNumbers = getCorrectNumber(problems.length, args.corrects);
    wrongNumbers = getWrongNumber(problems.length, correctNumbers);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: grey00,
      appBar: basicAppbar(context),
      body: SingleChildScrollView(
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Container(
                alignment: Alignment.topCenter,
                width: 1040,
                height: 500,
                child: Image.asset(
                  "assets/congraturation.gif",
                  fit: BoxFit.fitHeight,
                )),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              // height: MediaQuery.of(context).size.height,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.center,
                    width: 1040,
                    height: 349,
                    child: Text(
                      "수고하셨습니다 !",
                      style: Headline(grey09),
                    ),
                  ),
                  SizedBox(
                    width: 1040,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        problemBoxes(
                            " 맞춘 문제", correctNumbers, grey00, maingreyblue),
                        problemBoxes(" 틀린 문제", wrongNumbers, mainLightBlue,
                            maingreyblue),
                        const SizedBox(
                          width: 50,
                        ),
                        tipBox()
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget problemBoxes(String headlineText, List<int> tileNumbers,
      Color backgroundColor, Color borderColor) {
    const columnCount = 5;
    final rowCount = (tileNumbers.length / columnCount).ceil();
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 16, 32, 16),
      width: 290,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            headlineText,
            style: title2(mainBlack),
          ),
          const SizedBox(
            height: 22,
          ),
          for (int rowIndex = 0; rowIndex < rowCount; rowIndex++)
            Row(
              children: [
                for (int columnIndex = 0;
                    columnIndex < columnCount;
                    columnIndex++)
                  if (rowIndex * columnCount + columnIndex < tileNumbers.length)
                    Container(
                      margin: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: backgroundColor,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: borderColor,
                          width: 1,
                        ),
                      ),
                      child: SizedBox(
                        width: 44,
                        height: 44,
                        child: Center(
                          child: Text(
                            tileNumbers[rowIndex * columnCount + columnIndex]
                                .toString(),
                            textAlign: TextAlign.center,
                            style: body2(mainBlack),
                          ),
                        ),
                      ),
                    ),
                if (rowIndex == rowCount - 1) ...[
                  for (int i = 0;
                      i < columnCount - tileNumbers.length % columnCount;
                      i++)
                    Container(
                      margin: const EdgeInsets.all(2),
                    ),
                ],
              ],
            ),
        ],
      ),
    );
  }

  Widget tipBox() {
    return Container(
      margin: const EdgeInsets.fromLTRB(10, 14, 10, 10),
      width: 212,
      height: 254,
      decoration: BoxDecoration(
          color: yellow03,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: yellow05)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(22, 26, 16, 26),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            "TIP",
            style: body1(yellow05),
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            "틀린 문제를 다시 풀면\n훨씬 기억에 잘 남아요!",
            style: body4(mainBlack),
          ),
          const SizedBox(
            height: 60,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const SizedBox(
                width: 40,
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  "틀린 문제 \n다시 풀기 ",
                  style: body3(yellow05),
                ),
              ),
              ElevatedButton(
                onPressed: routeToWrongExamPage,
                style: ElevatedButton.styleFrom(
                    side: const BorderSide(color: yellow05),
                    backgroundColor: const Color(0xffE7FFF2),
                    fixedSize: const Size(52, 52),
                    shape: const CircleBorder(),
                    shadowColor: Colors.transparent),
                child: const Icon(
                  Icons.arrow_forward,
                  color: pointGreen,
                  size: 26,
                ),
              )
            ],
          )
        ]),
      ),
    );
  }

  // Function that return numbers that not in correctNumbers
  List<int> getWrongNumber(int length, List<int> correctNumbers) {
    List<int> wrongNumbers = [];
    for (int number = 1; number <= length; number++) {
      if (!correctNumbers.contains(number)) {
        wrongNumbers.add(number);
      }
    }
    return wrongNumbers;
  }

  List<int> getCorrectNumber(int length, List<int> corrects) {
    List<int> correctNumbers = [];
    for (int index = 0; index < length; index++) {
      if (corrects[index] == 1) {
        correctNumbers.add(index + 1);
      }
    }
    return correctNumbers;
  }

  List<Problem> getWrongProblems(List<int> wrongs, List<Problem> problems) {
    List<Problem> wrongProblems = [];
    for (var problem in problems) {
      if (wrongs.contains(problem.number)) {
        wrongProblems.add(problem);
      }
    }
    return wrongProblems;
  }

  void routeToWrongExamPage() {
    Navigator.pushNamed(context, '/wrongExam',
        arguments: WrongExamArguments(
            degree, subject, getWrongProblems(wrongNumbers, problems)));
  }
}
