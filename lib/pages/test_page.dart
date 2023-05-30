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

  bool selected = true;
  @override
  void initState() {
    delay();
    super.initState();
  }

  void delay() async {
    Future.delayed(Duration(seconds: 0)).then((value) {
      setState(() {
        selected = false;
      });
    }).then((value) {
      Future.delayed(Duration(seconds: 2)).then((value) {
      setState(() {
        selected = true;
      });
    });
    });
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Positioned(
          bottom: 0,
          left: 0,
          child: AnimatedOpacity(
            duration: const Duration(seconds: 1),
            opacity: selected ? 0 : 1,
            child: const FlutterLogo(size: 75),
          ),
        ),
        Center(child: Text("Flutter App")),
      ],
    ));
  }
}
