import 'package:flutter/material.dart';
import 'textstyle.dart';

AppBar basicAppbar() {
  return AppBar(
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
        const SizedBox(
          width: 80,
        ),
        TextButton(
          onPressed: () {},
          child: Text(
            '연습문제',
            style: Headline_H2(20, Colors.black),
          ),
        ),
        const SizedBox(
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
    actions: [
      TextButton(
        onPressed: () {},
        child: Text("마이페이지", style: Button_Bt2(20, Colors.black)),
      )
    ],
  );
}
