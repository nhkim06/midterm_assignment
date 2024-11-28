//상단바, 하단바, 챗봇 플로팅 버튼, 음성 인식 디자인
import 'package:flutter/material.dart';
import 'home.dart';  
import 'store.dart';
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
        backgroundColor: Colors.white, // Set background color to white
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


//**********************************************************챗봇 플로팅 버튼**********************************************************//
class ChatFloatingActionButton extends StatelessWidget {
  const ChatFloatingActionButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: 'AI와 대화하여 추천 상품을 확인해보세요.', // Tooltip message
      child: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ChatbotPage()),
          );
        },
        backgroundColor: const Color(0xFFD5FDC1), // Light green
        child: Image.asset(
          'assets/chatbot.png',
          color: const Color(0xFF529147), // Apply green color to the icon
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
      borderRadius: BorderRadius.vertical(top: Radius.circular(50.0)), // Round top corners
      child: Container(
        padding: const EdgeInsets.all(16.0),
        height: 300, // Set the height of the bottom sheet
        color: Colors.white, // Set the background color of the bottom sheet
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch, // Align content to stretch full width
          children: [
            // Close button at the top right
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: const Icon(Icons.close, color: Colors.grey), // Close button icon
                onPressed: () {
                  Navigator.pop(context); // Close the bottom sheet
                },
              ),
            ),
            const SizedBox(height: 20.0), // Spacing between the close button and mic icon
            // Mic icon in the center
            Center(
              child: GestureDetector(
                onTap: () {
                  // Implement recording functionality
                },
                child: Image.asset(
                  'assets/mic.png', // Make sure to place your mic.png in the 'assets' folder
                  width: 50, // Set the width of the mic icon
                  height: 50, // Set the height of the mic icon
                  color: Colors.green, // Set the color of the icon (for grayscale)
                ),
              ),
            ),
            const SizedBox(height: 20.0), // Spacing between the mic icon and progress indicator
            // Linear progress indicator at the bottom
            const LinearProgressIndicator(
              color: Colors.green, // Set the color of the progress indicator to green
            ),
            const SizedBox(height: 8.0), // Spacing between the progress indicator and text
            // Text below the progress indicator
            const Center(
              child: Text(
                '듣는 중...',
                style: TextStyle(
                  color: Colors.black, // Set the text color
                  fontSize: 16.0, // Set the text size
                ),
              ),
            ),
            const Spacer(), // This will push the bottom navigation bar to the bottom
            // Bottom navigation bar with the buttons
            Row(
              children: [
                // "다시 말하기" button
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      // Implement re-record functionality
                    },
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.grey), // Green border
                      backgroundColor: Colors.white, // White background
                      padding: const EdgeInsets.symmetric(vertical: 16.0), // Button padding
                    ),
                    child: const Text(
                      '다시 말하기',
                      style: TextStyle(
                        color: Colors.grey, // Green text color
                        fontSize: 16.0, // Set text size
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8.0), // Spacing between buttons
                // "완료" button
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Implement completion functionality
                      Navigator.pop(context); // Close the bottom sheet
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey, // Set button color
                      padding: const EdgeInsets.symmetric(vertical: 16.0), // Button padding
                    ),
                    child: const Text(
                      '완료',
                      style: TextStyle(
                        color: Colors.white, // Set text color of the button
                        fontSize: 16.0, // Set text size of the button
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
