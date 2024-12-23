import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'design_materials.dart';

//**********************************************************챗봇 페이지 코드**********************************************************/
class ChatbotPage extends StatefulWidget {
  const ChatbotPage({Key? key}) : super(key: key);

  @override
  State<ChatbotPage> createState() => _ChatbotPageState();
}

class _ChatbotPageState extends State<ChatbotPage> {
  final TextEditingController messageController = TextEditingController();
  late stt.SpeechToText _speech;
  bool _isListening = false;

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
  }

  void _startListening() async {
    bool available = await _speech.initialize(
      onStatus: (status) => print('Speech Status: $status'),
      onError: (error) => print('Speech Error: $error'),
    );
    if (available) {
      setState(() => _isListening = true);
      _speech.listen(onResult: (result) {
        setState(() {
          messageController.text = result.recognizedWords;
        });
      });
    } else {
      print('The user has denied the use of speech recognition.');
    }
  }

  void _stopListening() {
    setState(() => _isListening = false);
    _speech.stop();
  }

  @override
  Widget build(BuildContext context) {
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
                                  return VoiceRecordBottomSheet(
                                    startListening: _startListening,
                                    stopListening: _stopListening,
                                    isListening: _isListening,
                                  );
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

// Add this class after UserChat class
class ChatbotRecommendChat extends StatelessWidget {
  const ChatbotRecommendChat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChatbotChat(
      message: '심플하면서도 화려한 가구를 추천해드리겠습니다. 다음과 같은 제품들은 어떠신가요?',
    );
  }
}
