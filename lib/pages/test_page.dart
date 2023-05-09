import 'dart:html';

import 'package:black_bean/model/major_section_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../service/firebase_service.dart';

var db = FirebaseFirestore.instance;

class TestPage extends StatefulWidget {
  TestPage({super.key});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  FirebaseService firebaseService = FirebaseService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ElevatedButton(
            onPressed: (() async {
              firebaseService
                  .loadProblemMajorSectionFromDatabase('High', 'Math', 1)
                  .then((value) {
                value.forEach((element) {
                  print(element.toMap());
                });
              });
            }),
            child: const Text("loadProblemMajorSectionFromDatabase"),
          ),
          ElevatedButton(
              onPressed: ((() async {
                firebaseService
                    .loadProblemSmallSectionFromDatabase('High', 'Math', 1, 1)
                    .then((value) {
                  value.forEach((element) {
                    print(element.toMap());
                  });
                });
              })),
              child: const Text("loadProblemSmallSectionFromDatabase"))
        ],
      ),
    );
  }
}
