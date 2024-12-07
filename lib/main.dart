import 'package:flutter/material.dart';

import 'home.dart';  // UI 디자인 완료
import 'store.dart';
import 'heart.dart';
import 'user.dart';

import 'search.dart';  // UI 디자인 완료
import 'cart.dart';

import 'product.dart';  // UI 디자인 완료
import 'product_review.dart';

import 'chatbot.dart';  // UI 디자인 완료

import 'design_materials.dart';  // 자주 사용하는 UI요소들


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FamiliRoom', 
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const HomePage(), 
    );
  }
}

//hello222