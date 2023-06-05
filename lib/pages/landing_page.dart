import 'package:black_bean/textstyle.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: SingleChildScrollView(
      child: Column(children: [
        Container(
          width: max(1300, MediaQuery.of(context).size.width),
          height: max(650, MediaQuery.of(context).size.height),
          color: blue09,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text("검정고시 시험이 쉬워지는 공부 습관", style: title1(yellow04)),
            const SizedBox(height: 20),
            Image.asset("assets/images/shiumshium.png"),
          ]),
        ),
        Container(
          width: max(1300, MediaQuery.of(context).size.width),
          height: max(650, MediaQuery.of(context).size.height),
          color: grey00,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text("쉬엄쉬엄 조금씩 공부하다 보면", style: title1(grey09)),
            const SizedBox(height: 34),
            Text("어느새 검정고시가 쉬워질 거에요", style: title1(grey09)),
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
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40),
                          ),
                        ),
                      ),
                      onPressed: () {},
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
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40),
                          ),
                        ),
                      ),
                      onPressed: () {},
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
    )));
  }
}
