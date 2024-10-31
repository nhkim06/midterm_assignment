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


//**********상단**********//
// 검색 페이지
class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Colors.grey[300]!, width: 1), // 연한 회색 보더
            ),
          ),
          child: AppBar(
            title: const Text('검색'),
            backgroundColor: Colors.white,
          ),
        ),
      ),
      body: Center(child: const Text('검색 페이지 내용')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ChatPage()),
          );
        },
        backgroundColor: const Color(0xFFD5FDC1), // 연두색
        child: const Icon(Icons.chat, color: Color(0xFF808080)), // 회색 아이콘
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}

// 장바구니 페이지
class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Colors.grey[300]!, width: 1), // 연한 회색 보더
            ),
          ),
          child: AppBar(
            title: const Text('장바구니'),
            backgroundColor: Colors.white,
          ),
        ),
      ),
      body: Center(child: const Text('장바구니 페이지 내용')),
    );
  }
}


//**********하단**********//
// 홈 페이지
class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'FamiliRoom', context: context, isHomePage: true), // 홈 페이지
      body: Center(
        child: const Text('홈 페이지 내용'),
      ),
      bottomNavigationBar: const BottomNavigationBarWidget(currentIndex: 0),
      floatingActionButton: const ChatFloatingActionButton(), // 추가된 부분
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat, // 위치 설정
    );
  }
}

// 스토어 페이지
class StorePage extends StatelessWidget {
  const StorePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: '스토어', context: context, isHomePage: false), // 볼드체 아님
      body: Center(child: const Text('스토어 페이지 내용')),
      bottomNavigationBar: const BottomNavigationBarWidget(currentIndex: 1),
      floatingActionButton: const ChatFloatingActionButton(), // 추가된 부분
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat, // 위치 설정
    );
  }
}

// 좋아요 페이지
class HeartPage extends StatelessWidget {
  const HeartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: '좋아요', context: context, isHomePage: false), // 볼드체 아님
      body: Center(child: const Text('하트 페이지 내용')),
      bottomNavigationBar: const BottomNavigationBarWidget(currentIndex: 2),
      floatingActionButton: const ChatFloatingActionButton(), // 추가된 부분
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat, // 위치 설정
    );
  }
}

// 유저 페이지
class UserPage extends StatelessWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: '마이페이지', context: context, isHomePage: false), // 볼드체 아님
      body: Center(child: const Text('사용자 페이지 내용')),
      bottomNavigationBar: const BottomNavigationBarWidget(currentIndex: 3),
      floatingActionButton: const ChatFloatingActionButton(), // 추가된 부분
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat, // 위치 설정
    );
  }
}



//**********기타 페이지**********//
// 채팅 페이지
class ChatPage extends StatelessWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('채팅'),
        backgroundColor: Colors.white,
      ),
      body: Center(child: const Text('채팅 페이지 내용')),
    );
  }
}



//**********상단 바 디자인**********//
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final BuildContext context;
  final bool isHomePage; // 추가된 매개변수

  const CustomAppBar({
    Key? key,
    required this.title,
    required this.context,
    this.isHomePage = false, // 기본값은 false로 설정
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(
          title: Text(
            title,
            style: TextStyle(
              fontWeight: isHomePage ? FontWeight.bold : FontWeight.normal, // 조건에 따라 볼드체 설정
              fontSize: 24,
            ),
          ),
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              icon: ColorFiltered(
                colorFilter: const ColorFilter.mode(Colors.grey, BlendMode.srcIn), // 회색으로 필터링
                child: Image.asset('search.png', width: 24, height: 24),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SearchPage()),
                );
              },
            ),
            IconButton(
              icon: ColorFiltered(
                colorFilter: const ColorFilter.mode(Colors.grey, BlendMode.srcIn), // 회색으로 필터링
                child: Image.asset('cart.png', width: 24, height: 24),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CartPage()),
                );
              },
            ),
          ],
        ),
        Container(
          height: 1, // 보더의 두께 설정
          color: Colors.grey.withOpacity(0.3), // 연한 회색 보더 색상
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(57.0); // AppBar의 높이 설정 (보더 포함)
}



//**********하단 바 디자인**********//
class BottomNavigationBarWidget extends StatelessWidget {
  final int currentIndex;
  
  const BottomNavigationBarWidget({Key? key, required this.currentIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Color(0xFFE0E0E0), width: 1),
        ),
      ),
      child: BottomNavigationBar(
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
            label: '홈',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'store.png',
              width: 20,
              height: 20,
              color: currentIndex == 1 ? Colors.black : Colors.grey,
            ),
            label: '스토어',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'heart.png',
              width: 20,
              height: 20,
              color: currentIndex == 2 ? Colors.black : Colors.grey,
            ),
            label: '좋아요',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'user.png',
              width: 20,
              height: 20,
              color: currentIndex == 3 ? Colors.black : Colors.grey,
            ),
            label: '마이페이지',
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
      ),
    );
  }
}


//**********채팅 플로팅 버튼**********//
class ChatFloatingActionButton extends StatelessWidget {
  const ChatFloatingActionButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ChatPage()),
        );
      },
      backgroundColor: const Color(0xFFD5FDC1), // 연두색
      child: const Icon(Icons.chat, color: Color(0xFF529147)), // 회색 아이콘
    );
  }
}
