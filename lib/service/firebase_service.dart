import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../model/problem.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  //web 아닐 때 파이어스토어에 업로드하는 함수, 테스트 필요
  Future<void> _uploadImage(XFile pickedImage, imageName) async {
    // Initialize Firebase if it hasn't been initialized yet
    // final imageName = DateTime.now().millisecondsSinceEpoch.toString();
    final ref = FirebaseStorage.instance.ref().child('images/$imageName');
    UploadTask uploadTask = ref.putFile(File(pickedImage.path));
    final snapshot = await uploadTask.whenComplete(() => null);
    final urlImageUser = await snapshot.ref.getDownloadURL();

    print('firebase_service_dart line 26: Image URL: $urlImageUser');
  }

  //웹에서 파이어스토어에 이미지 업로드 할 때 사용하는 함수
  Future<void> uploadImage_web(XFile pickedFile, imageName) async {
    if (pickedFile != null) {
      final snapshot = await _storage
          .ref()
          .child('images/$imageName')
          .putData(await pickedFile.readAsBytes());
      var imgUrl = await snapshot.ref.getDownloadURL();
      print('firebase_service_dart line 37: Upload complete!  $imgUrl');
    } else {
      print('firebase_service_dart line 38: No image selected.');
    }
  }

  Future<String> uploadToStorage(XFile pickedFile, imageName) async {
    Uint8List bytes = await pickedFile.readAsBytes();

    Reference ref = FirebaseStorage.instance.ref().child('images/$imageName');
    UploadTask uploadTask =
        ref.putData(bytes, SettableMetadata(contentType: 'image/png'));
    TaskSnapshot taskSnapshot = await uploadTask
        .whenComplete(() => print('done'))
        .catchError((error) => print('something went wrong'));
    String url = await taskSnapshot.ref.getDownloadURL();
    return url;
  }

  //문제 선택하고 firestore에 올리는 함수
  Future<void> addProblemToDatabase(
    String degree,
    String subject,
    Problem problem,
  ) async {
    try {
      await _firestore
          .collection('degree')
          .doc(degree)
          .collection('subject')
          .doc(subject)
          .collection('problems')
          .doc() // this will create a new document with an automatically generated ID
          .set(problem.toMap());
    } catch (e) {
      print(e);
    }
  }

  //문제 하나 불러오는 함수
  Future<Problem> loadProblemFromDatabase(
      String degree, String subject, String year, int number) async {
    DocumentSnapshot documentSnapshot = await _firestore
        .collection('degree')
        .doc(degree)
        .collection('subject')
        .doc(subject)
        .collection('problems')
        .where('year', isEqualTo: year)
        .where('number', isEqualTo: number)
        .get()
        .then((value) => value.docs.single);

    Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;

    var answer = data['answer'];
    var iSection = data['iSection'];
    var mSection = data['mSection'];
    var numberdata = data['number'];
    var problemurl = data['problem'];
    var sSection = data['sSection'];
    var yeardata = data['year'];

    Problem problem = Problem(
        answer: answer,
        iSection: iSection,
        mSection: mSection,
        number: numberdata,
        problem: problemurl,
        sSection: sSection,
        year: yeardata);

    // print(problem.toMap());

    return problem;
  }

  //함수에서 문제 리스트 불러오기
  Future<List<Problem>> loadProblemYearFromDatabase(
      String degree, String subject, String year) async {
    QuerySnapshot querySnapshot = await _firestore
        .collection('degree')
        .doc(degree)
        .collection('subject')
        .doc(subject)
        .collection('problems')
        .where('year', isEqualTo: year)
        .get();

    List<Problem> problems = [];

    querySnapshot.docs.forEach((documentSnapshot) {
      Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;

      var answer = data['answer'];
      var iSection = data['iSection'];
      var mSection = data['mSection'];
      var numberdata = data['number'];
      var problemurl = data['problem'];
      var sSection = data['sSection'];
      var yeardata = data['year'];

      Problem problem = Problem(
          answer: answer,
          iSection: iSection,
          mSection: mSection,
          number: numberdata,
          problem: problemurl,
          sSection: sSection,
          year: yeardata);

      // print(problem.toMap());

      problems.add(problem);
    });

    return problems;
  }

  //함수에서 문제 리스트 불러오기
  Future<List<Problem>> loadProblemWeaknessFromDatabase(
      String degree, String subject, List<int> mSections) async {
    QuerySnapshot querySnapshot = await _firestore
        .collection('degree')
        .doc(degree)
        .collection('subject')
        .doc(subject)
        .collection('problems')
        .where('mSection', whereIn: mSections)
        .get();

    List<Problem> problems = [];

    querySnapshot.docs.forEach((documentSnapshot) {
      Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;

      var answer = data['answer'];
      var iSection = data['iSection'];
      var mSection = data['mSection'];
      var numberdata = data['number'];
      var problemurl = data['problem'];
      var sSection = data['sSection'];
      var yeardata = data['year'];

      Problem problem = Problem(
          answer: answer,
          iSection: iSection,
          mSection: mSection,
          number: numberdata,
          problem: problemurl,
          sSection: sSection,
          year: yeardata);

      // print(problem.toMap());

      problems.add(problem);
    });

    return problems;
  }


  
}
