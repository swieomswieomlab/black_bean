import 'dart:math';

import 'package:black_bean/textstyle.dart';
import 'package:flutter/material.dart';

import '../components.dart';

class FullExamGradingPage extends StatefulWidget {
  const FullExamGradingPage({Key? key}) : super(key: key);

  @override
  State<FullExamGradingPage> createState() => _FullExamGradingPageState();
}

class _FullExamGradingPageState extends State<FullExamGradingPage> {
  List<int> correctNumbers = List.generate(13, (index) => index + 1);
  List<int> wrongNumbers = List.generate(7, (index) => index + 2);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: basicAppbar(),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 800,
              height: 200,
              color: Colors.red,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width / 10,
                ),
                problemBoxes("맞춘 문제", correctNumbers, grey00, maingreyblue),
                problemBoxes("틀린 문제", wrongNumbers, mainLightBlue, maingreyblue),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget problemBoxes(String headlineText, List<int> tileNumbers, Color backgroundColor, Color borderColor) {
    const columnCount = 5;
    final rowCount = (tileNumbers.length / columnCount).ceil();
    return Container(
      margin: EdgeInsets.all(16),
      width: 290,
      child: Column(
        children: [
          Text(headlineText),
          for (int rowIndex = 0; rowIndex < rowCount; rowIndex++)
            Row(
              children: [
                for (int columnIndex = 0;
                    columnIndex < columnCount;
                    columnIndex++)
                  if (rowIndex * columnCount + columnIndex < tileNumbers.length)
                    Container(
                      margin: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: backgroundColor,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: borderColor,
                          width: 1,
                        ),
                      ),
                      child: SizedBox(
                        width: 48,
                        height: 48,
                        child: Center(
                          child: Text(
                            tileNumbers[rowIndex * columnCount + columnIndex]
                                .toString(),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                if (rowIndex == rowCount - 1) ...[
                  for (int i = 0;
                      i < columnCount - tileNumbers.length % columnCount;
                      i++)
                    Container(
                      margin: const EdgeInsets.all(8),
                    ),
                ],
              ],
            ),
        ],
      ),
    );
  }
}
