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

// 홈 페이지
class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FamiliRoom'),
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: const Text('홈 페이지 내용'),
      ),
      bottomNavigationBar: const BottomNavigationBarWidget(currentIndex: 0),
    );
  }
}

// 스토어 페이지
class StorePage extends StatelessWidget {
  const StorePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('스토어'),
        backgroundColor: Colors.white,
      ),
      body: Center(child: const Text('스토어 페이지 내용')),
      bottomNavigationBar: const BottomNavigationBarWidget(currentIndex: 1),
    );
  }
}

// 좋아요 페이지
class HeartPage extends StatelessWidget {
  const HeartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('좋아요'),
        backgroundColor: Colors.white,
      ),
      body: Center(child: const Text('하트 페이지 내용')),
      bottomNavigationBar: const BottomNavigationBarWidget(currentIndex: 2),
    );
  }
}

// 유저 페이지
class UserPage extends StatelessWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('마이페이지'),
        backgroundColor: Colors.white,
      ),
      body: Center(child: const Text('사용자 페이지 내용')),
      bottomNavigationBar: const BottomNavigationBarWidget(currentIndex: 3),
    );
  }
}

// 하단바
class BottomNavigationBarWidget extends StatelessWidget {
  final int currentIndex;

  const BottomNavigationBarWidget({Key? key, required this.currentIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: currentIndex,
      items: [
        BottomNavigationBarItem(
          icon: Image.asset(
            'home.png',
            width: 20,
            height: 20,
            color: currentIndex == 0 ? Colors.black : Colors.grey,
          ),
          label: '', // 라벨을 빈 문자열로 설정
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            'store.png',
            width: 20,
            height: 20,
            color: currentIndex == 1 ? Colors.black : Colors.grey,
          ),
          label: '', // 라벨을 빈 문자열로 설정
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            'heart.png',
            width: 20,
            height: 20,
            color: currentIndex == 2 ? Colors.black : Colors.grey,
          ),
          label: '', // 라벨을 빈 문자열로 설정
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            'user.png',
            width: 20,
            height: 20,
            color: currentIndex == 3 ? Colors.black : Colors.grey,
          ),
          label: '', // 라벨을 빈 문자열로 설정
        ),
      ],
      onTap: (index) {
        Widget page;
        switch (index) {
          case 0:
            page = const HomePage();
            break;
          case 1:
            page = const StorePage();
            break;
          case 2:
            page = const HeartPage();
            break;
          case 3:
            page = const UserPage();
            break;
          default:
            return;
        }
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
      },
    );
  }
}
