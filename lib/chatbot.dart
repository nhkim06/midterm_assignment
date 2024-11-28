// 챗봇 페이지 (UI완)
// + 챗봇, 챗봇 가구 추천, 유저 말풍선 디자인

import 'package:flutter/material.dart';
import 'design_materials.dart';

//**********************************************************챗봇 페이지 코드**********************************************************/
class ChatbotPage extends StatelessWidget {
  const ChatbotPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController messageController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '챗봇',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            // 대화 내역
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16.0),
                children: [
                  const ChatbotChat(message: '어떤 상품을 찾으세요?'), 
                  const SizedBox(height: 8), 
                  const UserChat(message: '심플하면서 화려한 가구 추천해줘'),
                  const SizedBox(height: 8),
                  const ChatbotRecommendChat(),
                  const SizedBox(height: 8), 
                  ],
              ),
            ),

            Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: Color(0xFFE0E0E0), width: 1.0),
                ),
              ),
            ),
            // 입력 칸 
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: messageController,
                      decoration: InputDecoration(
                        hintText: '메시지를 입력하세요...',
                        contentPadding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: BorderSide(color: Colors.green, width: 2.0),
                        ),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.only(left: 16.0, right: 10.0),
                          child: GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                backgroundColor: Colors.white,
                                builder: (BuildContext context) {
                                  return const VoiceRecordBottomSheet();
                                },
                              );
                            },
                            child: Image.asset(
                              'assets/mic.png',
                              width: 20,
                              height: 20,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: const Icon(Icons.send, color: Colors.green),
                    onPressed: () {
                      print('Sent message: ${messageController.text}');
                      messageController.clear();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}



//**********************************************************챗봇 말풍선 디자인**********************************************************/

class ChatbotChat extends StatelessWidget {
  final String message;

  const ChatbotChat({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 24, 
          backgroundColor: const Color(0xFFD5FDC1), 
          child: Image.asset(
            'assets/chatbot.png',
            color: const Color(0xFF529147),
            height: 24,
            width: 24,
          ),
        ),
        const SizedBox(width: 8), 
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8), 
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.grey), 
          ),
          child: Text(
            message,
            style: const TextStyle(
              fontSize: 16, 
              color: Colors.black, 
            ),
          ),
        ),
      ],
    );
  }
}

//**********************************************************챗봇 가구 추천 말풍선 디자인**********************************************************/
class ChatbotRecommendChat extends StatelessWidget {
  const ChatbotRecommendChat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 24,
              backgroundColor: const Color(0xFFD5FDC1),
              child: Image.asset(
                'assets/chatbot.png',
                color: const Color(0xFF529147),
                height: 24,
                width: 24,
              ),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.grey),
              ),
              child: const Text(
                '말씀하신 내용의 상품 추천드립니다.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Display product images with border
            const SizedBox(width: 58), 
            _buildImageContainer('assets/desk2.png'),
            const SizedBox(width: 8),
            _buildImageContainer('assets/sofa3.png'),
            const SizedBox(width: 8), 
            _buildImageContainer('assets/table2.png'),
          ],
        ),
      ],
    );
  }

  Widget _buildImageContainer(String imagePath) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey), 
        borderRadius: BorderRadius.circular(8), 
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8), 
        child: Image.asset(
          imagePath,
          width: 60,
          height: 60,
          fit: BoxFit.cover,  
        ),
      ),
    );
  }
}


//**********************************************************유저 말풍선 디자인**********************************************************/
class UserChat extends StatelessWidget {
  final String message;

  const UserChat({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.green.shade100,
            borderRadius: BorderRadius.circular(20), 
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8), 
          child: Text(
            message,
            style: const TextStyle(
              fontSize: 16, 
              color: Colors.black, 
            ),
          ),
        ),
        const SizedBox(width: 8), 
      ],
    );
  }
}

