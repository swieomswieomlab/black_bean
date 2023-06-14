import '../textstyle.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  double standardWidth = 1194; //responsive를 위한 기준 width
  double standardHeight = 796; //responsive를 위한 기준 height

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width; //화면 창의 width
    double screenHeight = MediaQuery.of(context).size.height; //화면 창의 height
    double actualWidth = max(standardWidth, screenWidth); //실제로 적용되는 width
    double actualHeight = max(standardHeight, screenHeight); //실제로 적용되는 height

    return Scaffold(
        body: Center(
            child: SingleChildScrollView(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Column(
          children: [
            Stack(
              children: [
                Column(children: [
                  Container(
                    width: actualWidth,
                    height: actualHeight,
                    color: blue10,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/images/landing_title.png",
                            width: actualWidth / (1280 / 609),
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
                          Text("쉬엄쉬엄 조금씩 공부하다 보면\n어느새 검정고시가 쉬워질 거에요",
                              textAlign: TextAlign.center,
                              style: title4(grey09)),
                          const SizedBox(height: 122),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                children: [
                                  Text("한 단원씩 골라 풀고 싶다면",
                                      style: title2(blue08)),
                                  const SizedBox(height: 20),
                                  OutlinedButton(
                                    style: ButtonStyle(
                                      fixedSize:
                                          MaterialStateProperty.all<Size>(
                                              const Size(250, 72)),
                                      side:
                                          MaterialStateProperty.all<BorderSide>(
                                        const BorderSide(
                                          color: blue10,
                                          width: 5,
                                        ),
                                      ),
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(40),
                                        ),
                                      ),
                                      backgroundColor: MaterialStateProperty
                                          .resolveWith<Color>(
                                        (Set<MaterialState> states) {
                                          if (states.contains(
                                              MaterialState.pressed)) {
                                            return yellowButton;
                                          } else if (states.contains(
                                              MaterialState.hovered)) {
                                            return blue09;
                                          }
                                          return grey00; // Return null for default background color
                                        },
                                      ),
                                    ),
                                    onPressed: () {
                                      Navigator.pushNamed(
                                          context, '/selectUnitExamPage');
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
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
                                      fixedSize:
                                          MaterialStateProperty.all<Size>(
                                              const Size(250, 72)),
                                      side:
                                          MaterialStateProperty.all<BorderSide>(
                                        const BorderSide(
                                          color: blue10,
                                          width: 5,
                                        ),
                                      ),
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(40),
                                        ),
                                      ),
                                      backgroundColor: MaterialStateProperty
                                          .resolveWith<Color>(
                                        (Set<MaterialState> states) {
                                          if (states.contains(
                                              MaterialState.pressed)) {
                                            return yellowButton;
                                          } else if (states.contains(
                                              MaterialState.hovered)) {
                                            return blue09;
                                          }
                                          return grey00; // Return null for default background color
                                        },
                                      ),
                                    ),
                                    onPressed: () {
                                      Navigator.pushNamed(
                                          context, '/selectFullExamPage');
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
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
                //책으로 만든 계단 이미지
                Positioned(
                  right: 40,
                  top: 100,
                  child: Image.asset(
                    "assets/images/stairs.png",
                    width: actualWidth /
                        1200 *
                        270, //디자이너가 준 기준에 맞추기 위한 수치. Figma에서 확인 가능.
                    fit: BoxFit.fitWidth,
                  ),
                ),
                //하단 꽃 이미지
                Positioned(
                    bottom: 0,
                    child: Image.asset(
                      "assets/images/flower2.png",
                      width: actualWidth / 1200 * 307,
                      fit: BoxFit.fitWidth,
                    )),
                //두두두두 되어있는 터널 이미지
                Positioned(
                    top: actualHeight * 0.717,
                    child: Image.asset(
                      "assets/images/dudu.png",
                      width: actualWidth / 1200 * 562,
                      fit: BoxFit.fitWidth,
                    )),
                //상단 꽃 이미지
                Positioned(
                    top: 0,
                    child: Image.asset(
                      "assets/images/flower.png",
                      width: actualWidth / 1200 * 348,
                      fit: BoxFit.fitWidth,
                    )),
              ],
            ),
            SizedBox(
              height: 240,
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Contact",
                          style: title1(mainBlack),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "swieomswieomlab@gmail.com",
                          style: body3(mainBlack),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          "이 사이트에 등장하는 문제의 저작권은 평가원에 있습니다.",
                          style: body5(mainBlack),
                        ),
                      )
                    ]),
              ),
            ),
          ],
        ),
      ),
    )));
  }
}
