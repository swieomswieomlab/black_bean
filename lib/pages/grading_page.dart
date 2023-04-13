import 'package:flutter/material.dart';
import 'package:black_bean/textstyle.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../model/problem.dart';

class GradingPage extends StatefulWidget {
  const GradingPage({super.key});

  @override
  State<GradingPage> createState() => _GradingPageState();
}

class _GradingPageState extends State<GradingPage> {
//시험 결과 이 변수에 저장 필요
  List<int> Plist = List.generate(20, (index) => 0);

  List<Widget> textWidgets = [];
  bool clicked = false;

  @override
  void initState() {
    //시험 결과 내용을 Plist에서 받아와서 textWidgets에 저장
    textWidgets = Plist.map<Widget>((int number) {
      return InkWell(
        child: Container(
            width: 70,
            height: 94,
            color: mainLightBlue,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(number.toString()),
                Text("\u{274c}"),
              ],
            )),
      );
    }).toList();
    super.initState();
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

  @override
  Widget build(BuildContext context) {
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
                )),
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
        actions: [TextButton(onPressed: () {}, child: Text("마이페이지"))],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: double.infinity,
              height: 178,
              margin: EdgeInsets.symmetric(horizontal: 156.w),
              color: Color(0xffF3F8FC),
              // Color(0xFFF3F8FC),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "65점",
                      style: Headline_H0(72, mainSkyBlue),
                    ),
                    Text(
                      "합격까지 한 문제! 너무 잘 하고 있어요 :)",
                      style: Headline_H4(24, grey07),
                    ),
                  ]),
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              height: 500,
              margin: EdgeInsets.symmetric(horizontal: 156),
              child: Row(children: [
                Container(
                  width: 366,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("문항 별 채점 결과", style: Headline_H4(24, Colors.black)),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: 366,
                        height: 388,
                        child: GridView(
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
                  width: 60.w,
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
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text("틀린 문제 다시 풀기",
                          style: Headline_H4(24, Colors.black)),
                      SizedBox(height: 15,),
                      SizedBox(
                          child: Image.network(
                        "https://t1.daumcdn.net/cfile/tistory/2267023D5464408A17",
                        fit: BoxFit.contain,
                      )),
                      SizedBox(height: 130,),
                      Container(

                        child: Text("\u{270F}다시한번 풀어보세요",
                            style: Headline_H4(24, Colors.black)),
                      ),
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
      ),
    );
  }
}
