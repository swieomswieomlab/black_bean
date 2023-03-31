import 'dart:js_util';

import 'package:flutter/material.dart';

class FullExamPage extends StatefulWidget {
  FullExamPage({Key? key}) : super(key: key);

  @override
  State<FullExamPage> createState() => _FullExamPageState();
}

class _FullExamPageState extends State<FullExamPage> {

  double space_between_numbers_and_submit = 180;
  double space_between_numbers = 20;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Exam index here | Subject here"),
      ),
      body: Center(
        child: Column(
          children: [
            //exam image
            Container(
              child: Text('exam image here 근데 이거 웹이라 지금 좀 문제 있음'),
              // child: Image.network(
              //   'https://www.google.com/url?sa=i&url=https%3A%2F%2Fmathbang.net%2F646&psig=AOvVaw1yzaEf4yQjnpUa-8_bq15O&ust=1680347942195000&source=images&cd=vfe&ved=0CBAQjRxqFwoTCLDfroOGhv4CFQAAAAAdAAAAABAF'
              // ),
            ),
            Expanded(child: Container()),
            Divider(),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(

                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(width: space_between_numbers_and_submit + 80),
                        number_button('1'),
                        SizedBox(width: space_between_numbers),
                        number_button('2'),
                        SizedBox(width: space_between_numbers),
                        number_button('3'),
                        SizedBox(width: space_between_numbers),
                        number_button('4'),
                        SizedBox(width: space_between_numbers_and_submit),
                    submit_button(),
                      ],
                    ),
                    SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ],
        ),
      )
    );
  }

  ElevatedButton submit_button() => ElevatedButton(
    style: ButtonStyle(
      fixedSize: MaterialStateProperty.all(Size(80, 30)),
    ),
    onPressed: (){}, child: Text('저장'));

  OutlinedButton number_button(String number) {
    return OutlinedButton(
                    onPressed: () {},
                    child: Text(number),
                  );
  }
}