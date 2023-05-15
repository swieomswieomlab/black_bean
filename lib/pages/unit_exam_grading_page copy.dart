import 'package:black_bean/class/grading_arguments.dart';
import 'package:flutter/material.dart';
import 'package:black_bean/textstyle.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../components.dart';
import '../model/problem.dart';

class UnitExamGradingPage extends StatefulWidget {
  final GradingArguments _gradingArguments;

  const UnitExamGradingPage({Key? key, required GradingArguments gradingArguments})
      : _gradingArguments = gradingArguments,
        super(key: key);

  @override
  _UnitExamGradingPageState createState() => _UnitExamGradingPageState();
}

class _UnitExamGradingPageState extends State<UnitExamGradingPage> {
  late List<Widget> textWidgets;
  late List<Problem> problems = widget._gradingArguments.problems;
  late List<int> corrects = widget._gradingArguments.corrects;
  late int _score;
  String imgUrl = "";

  int _selectedNumberAnswer = -1;
  late List<int> _selectedAnswers;
  int _selectedNumberProblem = -1;
  Color _selectedColor = Colors.transparent;
  bool clicked = false;
  int correctMessageState = -1;
  late List<bool> isCorrectList;

  @override
  void initState() {
    _score = (corrects.where((number) => number == 1).length) *
        100 ~/
        corrects.length;

    _selectedAnswers =
        List.generate(widget._gradingArguments.problems.length, (index) => -1);
    isCorrectList = List.generate(problems.length, (index) => false);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    textWidgets =
        List.generate(problems.length, (index) => problems[index].number)
            .map<Widget>((int number) {
      return InkWell(
        child: Container(
          color: number == _selectedNumberProblem ? Colors.blue : mainLightBlue,
          child: Column(
            children: [
              Text(number.toString()),
              corrects[number - 1] == 2
                  ? const Text("\u{274c}")
                  : const Text("\u{2b55}"),
            ],
          ),
        ),
        onTap: () {
          setState(() {
            _selectedNumberProblem = number;
            _selectedColor = Colors.blue;
            _selectedNumberAnswer = -1;
            correctMessageState = -1;
          });
        },
      );
    }).toList();

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: basicAppbar(),
        body: Center(
          child: SingleChildScrollView(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                width: 1200,
                // height: screenHeight,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: 1044,
                      height: 554,
                      // margin: EdgeInsets.symmetric(
                      //   horizontal: 156,
                      // ),
                      color: Color(0xffF3F8FC),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "$_score점",
                            style: Headline_H0(72, mainSkyBlue),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                style: ButtonStyle(
                                  elevation: MaterialStateProperty.all(0),
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          mainLightBlue),
                                  fixedSize:
                                      MaterialStateProperty.all(Size(238, 64)),
                                  side: MaterialStateProperty.all<BorderSide>(
                                    BorderSide(color: mainSkyBlue),
                                  ),
                                ),
                                onPressed: () {},
                                child: Text(
                                  "다시풀기",
                                  style: Button_Bt1(24, mainSkyBlue),
                                ),
                              ),
                              SizedBox(width: 24,),
                              ElevatedButton(
                                style: ButtonStyle(
                                  elevation: MaterialStateProperty.all(0),
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          mainSkyBlue),
                                  fixedSize:
                                      MaterialStateProperty.all(Size(238, 64)),
                                ),
                                onPressed: () {},
                                child: Text(
                                  "완료",
                                  style: Button_Bt1(24, Colors.white),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),

                        
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
