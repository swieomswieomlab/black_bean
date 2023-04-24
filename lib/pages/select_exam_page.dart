import 'package:black_bean/components.dart';
import 'package:black_bean/textstyle.dart';
import 'package:flutter/material.dart';

class SelectExamPage extends StatefulWidget {
  const SelectExamPage({super.key});

  @override
  State<SelectExamPage> createState() => _SelectExamPageState();
}

class _SelectExamPageState extends State<SelectExamPage> {
  //과목 명 목록 영어, 이미지 이름 찾을 때 씀
  List<String> subject = [
    "korean",
    "math",
    "english",
    "society",
    "science",
    "history"
  ];
  //과목 목록 한국어
  List<String> subject_kor = [
    "국어",
    "수학",
    "영어",
    "사회",
    "과학",
    "한국사"
  ];
  //구현된 과목 번호
  List<int> contained_num = [1];
  bool selected = false;
  int selected_num = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: basicAppbar(),
      body: Center(
        child: SingleChildScrollView(
            child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 40),
            width: 1200,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("연습문제", style: Headline_H1(84, Colors.black)),
                SizedBox(
                  height: 62,
                ),
                //TODO: 연습문제 설명 글 추후에 수정 필요
                Text("연습문제에 대한 설명 글입니다.", style: Body_Bd1(26, Colors.black)),
                Text("연습문제에 대한 설명 글입니다.", style: Body_Bd1(26, Colors.black)),
                SizedBox(
                  height: 62,
                ),
                Container(
                  height: 130,
                  width: 600,
                  child: Wrap(
                    spacing: 28,
                    runSpacing: 32,
                    children: List.generate(
                        6,
                        (index) => GestureDetector(
                              onTap: () {
                                print(index);
                                setState(() {
                                  selected = true;
                                  selected_num = index;
                                });
                              },
                              child: Stack(
                                children: [
                                  Container(
                                    width: 150,
                                    height: 70,
                                    child: contained_num.contains(index)
                                        ? selected_num == index
                                            ? Image.asset(
                                                "assets/subject_buttons/button_subject_pressed_${subject[index]}.png",
                                                alignment:
                                                    Alignment.bottomCenter,
                                                fit: BoxFit.contain,
                                              )
                                            : Image.asset(
                                                "assets/subject_buttons/button_subject_default_${subject[index]}.png",
                                                alignment:
                                                    Alignment.bottomCenter,
                                                fit: BoxFit.contain)
                                        : Image.asset(
                                            "assets/subject_buttons/button_subject_disabled.png",
                                            alignment: Alignment.bottomCenter,
                                            fit: BoxFit.contain),
                                  ),
                                  Positioned.fill(
                                    child: Container(
                                      padding: EdgeInsets.only(bottom: selected_num==index ? contained_num.contains(index) ? 0 : 15 : 15),
                                      alignment: Alignment.center,
                                      child: Text(
                                        subject_kor[index],
                                          textAlign: TextAlign.center,
                                          style: Body_Bd1(20, Colors.white)
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Row(
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: mainLightBlue,
                      ),
                      child: Text(
                        "\u{23F3}다른 과목들도 준비중이에요! 조금만 기다려주세요 :)",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    Spacer(),
                    OutlinedButton(
                      onPressed: () {},
                      child: Icon(
                        Icons.arrow_forward,
                        size: 44,
                      ),
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all<OutlinedBorder>(
                          CircleBorder(),
                        ),
                        minimumSize: MaterialStateProperty.all<Size>(
                          Size(96, 96),
                        ),
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.grey),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        )),
      ),
    );
  }
}
