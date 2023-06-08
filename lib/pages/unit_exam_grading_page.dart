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
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: basicAppbar(),
        body: Center(
          child: SingleChildScrollView(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SizedBox(
                width: 1040,
                // height: screenHeight,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: 686,
                      height: 500,
                      color: const Color(0xffF3F8FC),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          //TODO: image here
                          Text(
                            "수고하셨습니다!",
                            style: Headline(mainSkyBlue),
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
                                  fixedSize: MaterialStateProperty.all(
                                      const Size(238, 64)),
                                  side: MaterialStateProperty.all<BorderSide>(
                                    const BorderSide(color: mainSkyBlue),
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                  Navigator.popAndPushNamed(
                                      context, '/selectUnitExamPage');
                                },
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
                                  fixedSize: MaterialStateProperty.all(
                                      const Size(238, 64)),
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                  Navigator.popAndPushNamed(context, '/');
                                },
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
