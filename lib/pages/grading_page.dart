import 'package:black_bean/class/grading_arguments.dart';
import 'package:flutter/material.dart';
import 'package:black_bean/textstyle.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../model/problem.dart';

class GradingPage extends StatefulWidget {
  final GradingArguments _gradingArguments;

  const GradingPage({Key? key, required GradingArguments gradingArguments})
      : _gradingArguments = gradingArguments,
        super(key: key);

  @override
  _GradingPageState createState() => _GradingPageState();
}

class _GradingPageState extends State<GradingPage> {
  late List<Widget> textWidgets;
  late List<Problem> problems = widget._gradingArguments.problems;
  late List<int> corrects = widget._gradingArguments.corrects;
  late int _score;
  String imgUrl = "";

  int _selectedNumberAnswer = -1;
  int _selectedNumberProblem = -1;
  Color _selectedColor = Colors.transparent;
  bool clicked = false;
  int correctMessageState = -1;

  @override
  void initState() {
    // TODO: implement initState
    _score = (corrects.where((number) => number == 1).length) *
        100 ~/
        corrects.length;

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
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: Row(
            children: [
              SizedBox(
                width: 100,
                child: Image.network(
                  'https://gradium.co.kr/wp-content/uploads/black-beans-1.jpg',
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(
                width: 80,
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  '연습문제',
                  style: Headline_H2(20, Colors.black),
                ),
              ),
              SizedBox(
                width: 60,
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  '모의고사',
                  style: Headline_H2(20, Colors.black),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {},
              child: Text("마이페이지", style: Button_Bt2(20, Colors.black)),
            )
          ],
        ),
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
                      width: 1200,
                      height: 178,
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
                          Text(
                            "합격까지 한 문제! 너무 잘 하고 있어요 :)",
                            style: Headline_H4(24, grey07),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Container(
                      height: 500,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 366,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "문항 별 채점 결과",
                                  style: Headline_H4(24, Colors.black),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  width: 366,
                                  child: GridView(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 5,
                                      childAspectRatio: 70 / 94,
                                      mainAxisSpacing: 4.0,
                                      crossAxisSpacing: 4.0,
                                    ),
                                    children: textWidgets,
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 60,
                          ),
                          VerticalDivider(
                            width: 20,
                            thickness: 1,
                            indent: 20,
                            endIndent: 0,
                            color: Colors.grey,
                          ),
                          SizedBox(
                            width: 60,
                          ),
                          Expanded(
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text(
                                    "틀린 문제 다시 풀기",
                                    style: Headline_H4(24, Colors.black),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  SizedBox(
                                    width: 580,
                                    child: _selectedNumberProblem != -1 &&
                                            corrects[_selectedNumberProblem -
                                                    1] ==
                                                2
                                        ? Image.network(
                                            problems[_selectedNumberProblem - 1]
                                                .problem,
                                            fit: BoxFit.contain,
                                          )
                                        : const Text("수고하셨습니다~"),
                                  ),
                                  Spacer(),
                                  // SizedBox(
                                  //   height: 80,
                                  // ),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: 217,
                                      height: 38,
                                      color: Color(0xFFFFF5DA),
                                      child: correctMessageState == -1
                                          ? Text("CMS 0",
                                              style:
                                                  Headline_H4(18, Colors.black))
                                          : correctMessageState == 1
                                              ? Text("CMS 1",
                                                  style: Headline_H4(
                                                      18, Colors.black))
                                              : Text("\u{270F} 다시 한번 풀어보세요",
                                                  style: Headline_H4(
                                                      18, Colors.black)),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 24,
                                  ),
                                  Container(
                                    width: 366,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        numberButton('1', 1),
                                        numberButton('2', 2),
                                        numberButton('3', 3),
                                        numberButton('4', 4),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 60,
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  OutlinedButton numberButton(String number, int value) {
    return OutlinedButton(
      onPressed: () {
        setState(() {
          _selectedNumberAnswer = value;
        });

        // check the selected problem's answer
        bool isCorrect = problems[_selectedNumberProblem - 1].answer ==
            _selectedNumberAnswer;

        // update the text based on the answer
        setState(() {
          if (isCorrect) {
            correctMessageState = 1;
          } else {
            correctMessageState = 2;
          }
        });
      },
      style: ButtonStyle(
        side: MaterialStateProperty.all(BorderSide(color: Colors.black)),
        backgroundColor: MaterialStateProperty.resolveWith<Color?>(
          (states) {
            if (_selectedNumberAnswer == value) {
              return Colors.blue;
            } else {
              return null;
            }
          },
        ),
      ),
      child: Text(
        number,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: _selectedNumberAnswer == value ? Colors.white : Colors.black,
        ),
      ),
    );
  }
}
