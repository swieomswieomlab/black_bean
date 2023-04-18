import 'package:flutter/material.dart';
import 'package:black_bean/textstyle.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../model/problem.dart';

class GradingPage extends StatefulWidget {
  const GradingPage({Key? key}) : super(key: key);

  @override
  _GradingPageState createState() => _GradingPageState();
}

class _GradingPageState extends State<GradingPage> {
  //시험 결과 이 변수에 저장 필요
  List<int> Plist = List.generate(20, (index) => 0);

  List<Widget> textWidgets = [];
  bool clicked = false;
  bool isHovered = false;


  @override
  void initState() {
textWidgets = Plist.map<Widget>((int number) {
  bool _isHovered = false;
  return MouseRegion(
    onHover: (event) {
      setState(() {
        _isHovered = true;
      });
    },
    onExit: (event) {
      setState(() {
        _isHovered = false;
      });
    },
    child: InkWell(
      onTap: () {
        // do something when the widget is tapped
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Container(
          width: 70,
          height: 94,
          color: _isHovered ? Colors.red : mainLightBlue,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(number.toString()),
              Text("\u{274c}"),
            ],
          ),
        ),
      ),
    ),
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
  shape: MaterialStateProperty.all(CircleBorder()),
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
      fixedSize: MaterialStateProperty.all(Size(40, 40)),

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
              ),
            ),
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
        actions: [TextButton(onPressed: () {}, child: Text("마이페이지", style: Button_Bt2(20, Colors.black)),)],
      ),
      body: 

           Center(
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
                        width: 1200,
                        height: 178,
                        // margin: EdgeInsets.symmetric(
                        //   horizontal: 156,
                        // ),
                        color: Color(0xffF3F8FC),
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
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Container(
  height: 500,
  child: Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        width: 366,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "문항 별 채점 결과",
              style: Headline_H4(24, Colors.black),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: 366,
              child: GridView(
                physics: NeverScrollableScrollPhysics(),
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
        width: 60,
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
      Expanded(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                "틀린 문제 다시 풀기",
                style: Headline_H4(24, Colors.black),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 580,
                child: Image.network(
                  "https://t1.daumcdn.net/cfile/tistory/2267023D5464408A17",
                  fit: BoxFit.fitWidth,
                ),
              ),
              Spacer(),
              // SizedBox(
              //   height: 80,
              // ),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  alignment: Alignment.center,
                  width: 217,
                  height: 38,
                  color: Color(0xFFFFF5DA),
                  child: Text(
                    "\u{270F} 다시 한번 풀어보세요",
                    style: Headline_H4(18, Colors.black),
                  ),
                ),
              ),
              SizedBox(
                height: 24,
              ),
              Container(
                width: 366,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    number_button('1', 1),
                    number_button('2', 2),
                    number_button('3', 3),
                    number_button('4', 4),
                  ],
                ),
              ),
              SizedBox(
                height: 60,
              ),
            ],
          ),
        ),
      )
    ],
  ),
)

                    ],
                  ),
                ),
              ),
            ),
          )
    );
  }
}
