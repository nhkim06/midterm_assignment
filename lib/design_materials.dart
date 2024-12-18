//상단 바, 하단 바, 챗봇 플로팅 버튼, 음성 인식 디자인
import 'package:flutter/material.dart';
import 'home.dart';  
import 'heart.dart';
import 'user.dart';
import 'search.dart';
import 'cart.dart';
import 'chatbot.dart';

//**********************************************************상단 바 디자인**********************************************************//
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final BuildContext context;
  final bool isHomePage;

  const CustomAppBar({
    Key? key,
    required this.title,
    required this.context,
    this.isHomePage = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colors.white, 
          child: AppBar(
            title: Text(
              title,
              style: TextStyle(
                fontWeight: isHomePage ? FontWeight.bold : FontWeight.normal,
                fontSize: 24,
              ),
            ),
            backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
            elevation: 0, 
            actions: [
              IconButton(
                icon: ColorFiltered(
                  colorFilter: const ColorFilter.mode(Colors.grey, BlendMode.srcIn),
                  child: Image.asset('search.png', width: 20, height: 20),
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
                  colorFilter: const ColorFilter.mode(Colors.grey, BlendMode.srcIn),
                  child: Image.asset('cart.png', width: 20, height: 20),
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
        ),
        Container(
          height: 1,
          color: Colors.grey.withOpacity(0.3),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(57.0);
}


//**********************************************************하단 바 디자인**********************************************************//
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
        backgroundColor: Colors.white, 
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
              'heart.png',
              width: 20,
              height: 20,
              color: currentIndex == 1 ? Colors.black : Colors.grey,
            ),
            label: '좋아요',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'user.png',
              width: 20,
              height: 20,
              color: currentIndex == 2 ? Colors.black : Colors.grey,
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
              page = const HeartPage();
              break;
            case 2:
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


//**********************************************************챗봇 플로팅 버튼**********************************************************//
class ChatFloatingActionButton extends StatelessWidget {
  const ChatFloatingActionButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: 'AI와 대화하여 추천 상품을 확인해보세요.',
      child: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ChatbotPage()),
          );
        },
        backgroundColor: const Color(0xFFD5FDC1), 
        child: Image.asset(
          'assets/chatbot.png',
          color: const Color(0xFF529147),
          height: 24,
          width: 24,    
        ),
      ),
    );
  }
}


//**********************************************************음성 인식**********************************************************//
class VoiceRecordBottomSheet extends StatelessWidget {
  const VoiceRecordBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.vertical(top: Radius.circular(50.0)),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        height: 300,
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch, 
          children: [
            // Close button at the top right
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: const Icon(Icons.close, color: Colors.grey),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            const SizedBox(height: 20.0), 
            // Mic icon in the center
            Center(
              child: GestureDetector(
                onTap: () {
                  // Implement recording functionality
                },
                child: Image.asset(
                  'assets/mic.png', 
                  width: 50, 
                  height: 50, 
                  color: Colors.green, 
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            const LinearProgressIndicator(
              color: Colors.green, 
            ),
            const SizedBox(height: 8.0), 
            const Center(
              child: Text(
                '듣는 중...',
                style: TextStyle(
                  color: Colors.black, 
                  fontSize: 16.0, 
                ),
              ),
            ),
            const Spacer(), 
            Row(
              children: [
                // "다시 말하기" button
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      // Implement re-record functionality
                    },
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.grey), 
                      backgroundColor: Colors.white, 
                      padding: const EdgeInsets.symmetric(vertical: 16.0), 
                    ),
                    child: const Text(
                      '다시 말하기',
                      style: TextStyle(
                        color: Colors.grey, 
                        fontSize: 16.0, 
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8.0), 
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context); 
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey, 
                      padding: const EdgeInsets.symmetric(vertical: 16.0), 
                    ),
                    child: const Text(
                      '완료',
                      style: TextStyle(
                        color: Colors.white, 
                        fontSize: 16.0, 
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
