import 'package:black_bean/textstyle.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  double standardWidth = 1194;
  double standardHeight = 796;
  

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double actualWidth = max(standardWidth, screenWidth);
    double actualHeight = max(standardHeight, screenHeight);

    return Scaffold(
        body: Center(
            child: SingleChildScrollView(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Stack(
          children: [
            Column(children: [
              Container(
                width: actualWidth,
                height: actualHeight,
                color: blue10,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // OutlinedButton(onPressed: (){
                      //   print("width: $screenWidth, height: $screenHeight");
                      // }, child: Text("width: $actualWidth, height: $actualHeight")),
                      Image.asset(
                        "assets/images/landing_title.png",
                        width: actualWidth /(1280/609),
                        fit: BoxFit.fitWidth,
                      ),
                    ]),
              ),
              Container(
                width: actualWidth,
                height: actualHeight,
                color: grey00,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("쉬엄쉬엄 조금씩 공부하다 보면\n어느새 검정고시가 쉬워질 거에요",textAlign: TextAlign.center, style: title4(grey09)),
                      const SizedBox(height: 122),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              Text("한 단원씩 골라 풀고 싶다면", style: title2(blue08)),
                              const SizedBox(height: 20),
                              OutlinedButton(
                                style: ButtonStyle(
                                  fixedSize: MaterialStateProperty.all<Size>(
                                      const Size(250, 72)),
                                  side: MaterialStateProperty.all<BorderSide>(
                                    const BorderSide(
                                      color: blue09,
                                      width: 5,
                                    ),
                                  ),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(40),
                                    ),
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, '/selectUnitExamPage');
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("연습문제", style: title1(grey09)),
                                      const SizedBox(width: 10),
                                      const Icon(
                                        Icons.arrow_outward_outlined,
                                        color: grey09,
                                        size: 34,
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(width: 56),
                          Column(
                            children: [
                              Text("실제 시험처럼 풀고 싶다면", style: title2(blue08)),
                              const SizedBox(height: 20),
                              OutlinedButton(
                                style: ButtonStyle(
                                  fixedSize: MaterialStateProperty.all<Size>(
                                      const Size(250, 72)),
                                  side: MaterialStateProperty.all<BorderSide>(
                                    const BorderSide(
                                      color: blue09,
                                      width: 5,
                                    ),
                                  ),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(40),
                                    ),
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, '/selectFullExamPage');
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("모의고사", style: title1(grey09)),
                                      const SizedBox(width: 10),
                                      const Icon(
                                        Icons.arrow_outward_outlined,
                                        color: grey09,
                                        size: 34,
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      )
                    ]),
              ),
            ]),
            Positioned(
                right: 40,
                top: 100,
                child: Image.asset("assets/images/stairs.png", width: actualWidth / 1200*270, fit: BoxFit.fitWidth,),),
            Positioned(bottom: 0, child: Image.asset("assets/images/flower2.png", width: actualWidth / 1200*307, fit: BoxFit.fitWidth,)),
            Positioned(top: actualHeight * 0.717, child: Image.asset("assets/images/dudu.png", width: actualWidth / 1200*562, fit: BoxFit.fitWidth,)),
            Positioned(
                top: 0, child: Image.asset("assets/images/flower.png", width: actualWidth / 1200*348, fit: BoxFit.fitWidth,)),
          ],
        ),
      ),
    )));
  }
}
