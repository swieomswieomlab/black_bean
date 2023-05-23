
// import 'package:black_bean/textstyle.dart';
// import 'package:flutter/material.dart';
// import 'package:transparent_image/transparent_image.dart';

// import '../class/grading_arguments.dart';
// import '../model/problem.dart';

// import '../service/firebase_service.dart';

// class WeaknessExamPage extends StatefulWidget {
//   const WeaknessExamPage({Key? key}) : super(key: key);

//   @override
//   State<WeaknessExamPage> createState() => _WeaknessExamPageState();
// }

// class _WeaknessExamPageState extends State<WeaknessExamPage> {
//   final FirebaseService _firebaseService = FirebaseService();
//   double spaceBetweenNumbers = 48;
//   //0 for init, 1 for correct, 2 for wrong
//   late List<int> corrects;

//   late Future<List<Problem>> _loadProblemsFuture;
//   late List<Problem> _problems;
//   int _selectedNumber = -1;
//   int _numberState = 0;
//   int finalNumber = 99;

//   @override
//   void initState() {
//     super.initState();
//     _loadProblemsFuture = _firebaseService.loadProblemMajorSectionsFromDatabase(
//         'High', 'Math', [1]).then((loadedProblems) {
//       loadedProblems.sort((a, b) => a.number.compareTo(b.number));
//       finalNumber = loadedProblems.length;
//       corrects = List.generate(finalNumber, (index) => 0);
//       // print("Number of problems: " + finalNumber.toString());
//       return loadedProblems;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         centerTitle: true,
//         title: Text(
//           "Exam index here | Subject here",
//           style: Headline_H4(26, mainBlack),
//         ),
//       ),
//       backgroundColor: Colors.white,
//       body: Center(
//         child: Column(
//           children: [
//             const SizedBox(height: 36),
//             //exam image
//             FutureBuilder<List<Problem>>(
//               future: _loadProblemsFuture,
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return const CircularProgressIndicator(); // show progress indicator while loading
//                 } else if (snapshot.hasError) {
//                   return Text('Error: ${snapshot.error}');
//                 } else {
//                   _problems = snapshot.data!;
//                   return SizedBox(
//                     width: 820,
//                     child: Column(
//                       children: [
//                         Container(
//                           alignment: Alignment.centerLeft,
//                           child: Text(
//                             "${_problems[_numberState].mSection}단원|단원명",
//                             style: Tiny_T1(16, mainSkyBlue),
//                           ),
//                         ),
//                         FadeInImage.memoryNetwork(
//                           placeholder: kTransparentImage,
//                           image: _problems[_numberState].problem,
//                         ),
//                       ],
//                     ),
//                   );
//                 }
//               },
//             ),
//             Expanded(child: Container()),
//             const Divider(),
//             Container(
//               padding: const EdgeInsets.only(bottom: 51, top: 25),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   const SizedBox(width: 140),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Column(children: [
//                         IconButton(
//                             onPressed: () {}, icon: const Icon(Icons.arrow_back_ios)),
//                         const Text("이전"),
//                       ]),
//                       SizedBox(width: spaceBetweenNumbers),
//                       number_button('1', 1),
//                       SizedBox(width: spaceBetweenNumbers),
//                       number_button('2', 2),
//                       SizedBox(width: spaceBetweenNumbers),
//                       number_button('3', 3),
//                       SizedBox(width: spaceBetweenNumbers),
//                       number_button('4', 4),
//                       SizedBox(width: spaceBetweenNumbers),
//                       Column(children: [
//                         IconButton(
//                             onPressed: () {},
//                             icon: const Icon(Icons.arrow_forward_ios)),
//                         const Text("다음"),
//                       ]),
//                     ],
//                   ),
//                   submit_button(),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   ElevatedButton submit_button() => ElevatedButton(
//         style: ButtonStyle(
//           fixedSize: MaterialStateProperty.all(const Size(140, 48)),
//           shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//             RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(8.0),
//             ),
//           ),
//         ),
//         onPressed: () {
//           // number selected, check if it's correct
//           setState(() {
//             int answer = _problems[_numberState].answer;
//             if (answer == _selectedNumber) {
//               corrects[_numberState] = 1; // correct
//             } else {
//               corrects[_numberState] = 2; // wrong
//             }
//             //print if problem is correct
//             if (corrects[_numberState] == 1) {
//               print("Correct!");
//             } else {
//               print("Wrong!");
//             }
//             //if final number, route to grading page
//             if (_numberState == finalNumber - 1) {
//               showDialog<String>(
//                 context: context,
//                 builder: (BuildContext context) => AlertDialog(
//                   title: const Text('AlertDialog Title'),
//                   content: const Text('AlertDialog description'),
//                   actions: <Widget>[
//                     TextButton(
//                       onPressed: () {
//                         Navigator.pop(context, 'Cancel');
//                       },
//                       child: const Text('Cancel'),
//                     ),
//                     TextButton(
//                       onPressed: () {
//                         Navigator.pop(context, 'OK');
//                         Navigator.pushNamed(context, '/gradingPage',
//                             arguments: GradingArguments(corrects, _problems));
//                         _numberState = 0;
//                       },
//                       child: const Text('OK'),
//                     ),
//                   ],
//                 ),
//               );
//             }
//             if (_numberState < finalNumber - 1) {
//               _numberState += 1;
//             }
//             _selectedNumber = -1;
//           });

//           // when problems are finishied, route to grading page
//           // print("_numberState: "+_numberState.toString()+" finalNumber: "+finalNumber.toString());
//         },
//         child: _numberState == finalNumber - 1
//             ? const Text('채점')
//             : const Text('다음'),
//       );

//   OutlinedButton number_button(String number, int value) {
//     bool isSelected = _selectedNumber == value;

//     return OutlinedButton(
//       onPressed: () {
//         setState(() {
//           _selectedNumber = isSelected ? -1 : value;
//         });
//       },
//       style: ButtonStyle(
//         side: MaterialStateProperty.all(const BorderSide(color: Colors.black)),
//         backgroundColor: MaterialStateProperty.resolveWith<Color?>(
//           (states) {
//             if (isSelected) {
//               return Colors.blue;
//             } else {
//               return null;
//             }
//           },
//         ),
//         fixedSize: MaterialStateProperty.all(const Size(44, 44)),
//         shape: MaterialStateProperty.all(const CircleBorder()),
//       ),
//       child: Text(
//         number,
//         style: TextStyle(
//           fontWeight: FontWeight.bold,
//           color: isSelected ? Colors.white : Colors.black,
//         ),
//       ),
//     );
//   }
// }
