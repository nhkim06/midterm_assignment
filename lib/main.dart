import 'package:flutter/material.dart';

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

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('홈')),
      body: Center(
        child: ElevatedButton(
          child: const Text('입력 폼으로'),
          
          onPressed: () {
            // MaterialPageRoute를 사용하여 새 페이지로 이동
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
            );
          },
        ),
      ),
      bottomNavigationBar: const BottomNavigationBarWidget(),
    );
  }
}

class BottomNavigationBarWidget extends StatelessWidget {
  const BottomNavigationBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HomePage()),
              );
            },
            child: Image.asset('home.png', width: 25, height: 25),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HeartPage()),
              );
            },
            child: Image.asset('heart.png', width: 25, height: 25),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CartPage()),
              );
            },
            child: Image.asset('cart.png', width: 25, height: 25),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const UserPage()),
              );
            },
            child: Image.asset('user.png', width: 25, height: 25),
          ),
        ],
      ),
    );
  }
}

// 각 페이지의 스켈레톤 코드
class HeartPage extends StatelessWidget {
  const HeartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('하트 페이지')),
      body: Center(child: const Text('하트 페이지 내용')),
      bottomNavigationBar: const BottomNavigationBarWidget(), // 하단바 재사용
    );
  }
}

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('장바구니 페이지')),
      body: Center(child: const Text('장바구니 페이지 내용')),
      bottomNavigationBar: const BottomNavigationBarWidget(), // 하단바 재사용
    );
  }
}

class UserPage extends StatelessWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('사용자 페이지')),
      body: Center(child: const Text('사용자 페이지 내용')),
      bottomNavigationBar: const BottomNavigationBarWidget(), // 하단바 재사용
    );
  }
}
