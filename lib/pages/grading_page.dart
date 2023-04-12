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

  int _selectedNumber = -1;
  bool clicked = false;

  @override
  void initState() {
    // TODO: implement initState

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
                corrects[number-1] == 2?
                const Text("\u{274c}"):
                const Text("C")
                ,
              ],
            )),
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
              Text("점수 여기에 표시"),
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
                        child: Image.network(
                      "https://t1.daumcdn.net/cfile/tistory/2267023D5464408A17",
                      fit: BoxFit.contain,
                    )),
                    Text("틀렸는지 여부 알려주는 부분",
                        style: Headline_H4(24, Colors.black)),
                    Row(
                      children: [
                        number_button('1', 1),
                        number_button('2', 2),
                        number_button('3', 3),
                        number_button('4', 4),
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

  OutlinedButton number_button(String number, int value) {
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
