
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../service/firebase_service.dart';

var db = FirebaseFirestore.instance;

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  FirebaseService firebaseService = FirebaseService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox(
            width: 600,
            child: SingleChildScrollView(
                child: Image.network(
                    "https://firebasestorage.googleapis.com/v0/b/black-bean-1f72d.appspot.com/o/images%2F2099-1_1.jpg?alt=media&token=836133bb-2db3-49ab-8795-d7af7b04246f"))));
  }
}
