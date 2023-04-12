import 'package:black_bean/class/grading_arguments.dart';
import 'package:flutter/material.dart';
import 'package:black_bean/textstyle.dart';

import '../model/problem.dart';

class GradingPage extends StatefulWidget {
  final GradingArguments _gradingArguments;

  const GradingPage({Key? key, required GradingArguments gradingArguments})
      : _gradingArguments = gradingArguments,
        super(key: key);

  @override
  State<GradingPage> createState() => _GradingPageState();
}

class _GradingPageState extends State<GradingPage> {
  late List<Widget> textWidgets;
  late List<Problem> problems = widget._gradingArguments.problems;
  late List<int> corrects = widget._gradingArguments.corrects;
  late int _score;
  String imgUrl = "";

  int _selectedNumberAnswer = -1;
  int _selectedNumberProblem = -1;
  bool clicked = false;

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
    textWidgets = textWidgets =
        List.generate(problems.length, (index) => problems[index].number)
            .map<Widget>((int number) {
      return InkWell(
        child: Container(
            color: mainLightBlue,
            child: Column(
              children: [
                Text(number.toString()),
                corrects[number - 1] == 2
                    ? const Text("\u{274c}")
                    : const Text("C"),
              ],
            )),
        onTap: () {
          setState(() {
            _selectedNumberProblem = number;
          });
        },
      );
    }).toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Image.network(
            'https://gradium.co.kr/wp-content/uploads/black-beans-1.jpg'),
        title: Row(
          children: [
            TextButton(
              onPressed: () {},
              child: Text(
                '연습문제',
                style: Headline_H2(20, Colors.black),
              ),
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
        actions: [TextButton(onPressed: () {}, child: Text("마이페이지"))],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: 156),
            color: Colors.amber,
            // Color(0xFFF3F8FC),
            child: Column(children: [
              Text("$_score점"),
              //TODO: change phrase by score
              Text("합격까지 한 문제! 너무 잘 하고 있어요 :)"),
            ]),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 156),
            child: Row(children: [
              Container(
                width: 366,
                child: Column(
                  children: [
                    Text("문항 별 채점 결과", style: Headline_H4(24, Colors.black)),
                    GridView(
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 5,
                        childAspectRatio: 1.0,
                        mainAxisSpacing: 4.0,
                        crossAxisSpacing: 4.0,
                      ),
                      children: textWidgets,
                    )
                  ],
                ),
              ),
              Container(
                alignment: Alignment.topRight,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("틀린 문제 다시 풀기", style: Headline_H4(24, Colors.black)),
                    SizedBox(
                      child: _selectedNumberProblem != -1 && corrects[_selectedNumberProblem-1] == 2
                          ? Image.network(
                              problems[_selectedNumberProblem - 1].problem,
                              fit: BoxFit.contain,
                            )
                          : const Text("수고하셨습니다~"),
                    ),
                    Text("틀렸는지 여부 알려주는 부분",
                        style: Headline_H4(24, Colors.black)),
                    Row(
                      children: [
                        numberButton('1', 1),
                        numberButton('2', 2),
                        numberButton('3', 3),
                        numberButton('4', 4),
                      ],
                    ),
                  ],
                ),
              )
            ]),
          )
        ],
      ),
    );
  }

  OutlinedButton numberButton(String number, int value) {
    int _selectedNumber = -1;
    bool isSelected = _selectedNumber == value;

    return OutlinedButton(
      onPressed: () {
        setState(() {
          _selectedNumber = isSelected ? -1 : value;
        });
      },
      style: ButtonStyle(
        side: MaterialStateProperty.all(BorderSide(color: Colors.black)),
        backgroundColor: MaterialStateProperty.resolveWith<Color?>(
          (states) {
            if (isSelected) {
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
          color: isSelected ? Colors.white : Colors.black,
        ),
      ),
    );
  }
}
