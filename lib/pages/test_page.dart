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
      body: ElevatedButton(
        onPressed: (() async {
          List<MajorSectionName> a = await firebaseService
              .loadMajorSectionNameFromDatabase('High', 'Math');
          a.forEach((majorSectionName) {
            print('Section Number: ${majorSectionName.sectionNumber}');
            print('Name: ${majorSectionName.name}');
          });
        }),
        child: const Text("PRINT"),
      ),
    );
  }
}
