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
        backgroundColor: grey00,
        appBar: basicAppbar(context),
        body: Center(
          child: SingleChildScrollView(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Container(
                      alignment: Alignment.topCenter,
                      width: 1040,
                      height: 600,
                      child: Image.asset(
                        "assets/congraturation.gif",
                        fit: BoxFit.fitHeight,
                      )),
                  SizedBox(
                    width: 1040,
                    // height: screenHeight,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const SizedBox(
                          height: 150,
                        ),
                        SizedBox(
                          width: 686,
                          height: 500,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "수고하셨습니다!",
                                style: Headline(grey09),
                              ),
                              const SizedBox(
                                height: 100,
                              ),
                              OutlinedButton(
                                style: ButtonStyle(
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(40),
                                      ),
                                    ),
                                    elevation: MaterialStateProperty.all(0),
                                    fixedSize: MaterialStateProperty.all(
                                        const Size(238, 72)),
                                    side: MaterialStateProperty.all(
                                      const BorderSide(width: 4, color: blue10),
                                    )),
                                onPressed: () {
                                  Navigator.pop(context);
                                  Navigator.popAndPushNamed(context, '/');
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "HOME",
                                      style: title1(grey09),
                                    ),
                                    const SizedBox(width: 10),
                                    const Icon(
                                      Icons.arrow_outward_outlined,
                                      color: grey09,
                                      size: 34,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
