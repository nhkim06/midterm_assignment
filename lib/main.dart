import 'package:flutter/material.dart';

import 'home.dart';  // UI 디자인 완료

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FamiliRoom', 
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const HomePage(), 
    );
  }
}

