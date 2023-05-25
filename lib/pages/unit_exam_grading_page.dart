import 'package:flutter/material.dart';
import 'package:black_bean/textstyle.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../components.dart';

class UnitExamGradingPage extends StatefulWidget {
  const UnitExamGradingPage({Key? key}) : super(key: key);

  @override
  UnitExamGradingPageState createState() => UnitExamGradingPageState();
}

class UnitExamGradingPageState extends State<UnitExamGradingPage> {
  late List<Widget> textWidgets;
  String imgUrl = "";

  bool clicked = false;
  int correctMessageState = -1;
  late List<bool> isCorrectList;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // textWidgets =
    //     List.generate(problems.length, (index) => problems[index].number)
    //         .map<Widget>((int number) {
    //   return InkWell(
    //     child: Container(
    //       color: number == _selectedNumberProblem ? Colors.blue : mainLightBlue,
    //       child: Column(
    //         children: [
    //           Text(number.toString()),
    //           corrects[number - 1] == 2
    //               ? const Text("\u{274c}")
    //               : const Text("\u{2b55}"),
    //         ],
    //       ),
    //     ),
    //     onTap: () {
    //       setState(() {
    //         _selectedNumberProblem = number;
    //         correctMessageState = -1;
    //       });
    //     },
    //   );
    // }).toList();

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
                      color: const Color(0xffF3F8FC),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "수고하셨습니다!",
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
                                      MaterialStateProperty.all(const Size(238, 64)),
                                  side: MaterialStateProperty.all<BorderSide>(
                                    const BorderSide(color: mainSkyBlue),
                                  ),
                                ),
                                onPressed: () {},
                                child: Text(
                                  "다시풀기",
                                  style: button1(mainSkyBlue),
                                ),
                              ),
                              const SizedBox(
                                width: 24,
                              ),
                              ElevatedButton(
                                style: ButtonStyle(
                                  elevation: MaterialStateProperty.all(0),
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          mainSkyBlue),
                                  fixedSize:
                                      MaterialStateProperty.all(const Size(238, 64)),
                                ),
                                onPressed: () {},
                                child: Text(
                                  "완료",
                                  style: button1(grey00),
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
