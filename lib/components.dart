import 'package:flutter/material.dart';
import 'textstyle.dart';

AppBar basicAppbar(BuildContext context) {
  return AppBar(
    leading: IconButton(
      icon: const Icon(Icons.arrow_back, color: Colors.black),
      onPressed: () => Navigator.of(context).pop(),
    ),
    backgroundColor: Colors.white,
    elevation: 0,
    bottom: PreferredSize(
      preferredSize: const Size.fromHeight(4.0),
      child: Container(
        color: grey05,
        height: 1.0,
      ),
    ),
    title: Row(
      children: [
        const SizedBox(
          width: 80,
        ),
        IconButton(
          onPressed: () {
            Navigator.popUntil(context, ModalRoute.withName('/'));
          },
          icon: Image.asset(
            "assets/images/logo.png",
            fit: BoxFit.contain,
          ),
        ),
        const SizedBox(
          width: 80,
        ),
        TextButton(
          onPressed: () {
            Navigator.popAndPushNamed(context, '/selectUnitExamPage');
            // Navigator.pushNamed(context, '/selectUnitExamPage');
          },
          child: Text(
            '연습문제',
            style: button2(grey09),
          ),
        ),
        const SizedBox(
          width: 60,
        ),
        TextButton(
          onPressed: () {
            Navigator.popAndPushNamed(context, '/selectFullExamPage');
          },
          child: Text(
            '모의고사',
            style: button2(grey09),
          ),
        ),
      ],
    ),
  );
}
