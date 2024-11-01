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


//**********상단 페이지**********//
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
      floatingActionButton: const ChatFloatingActionButton(), // Use custom button here
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


//**********하단 페이지**********//
// 홈 페이지
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> categories = ['의자', '책상', '소파', '침대', '식탁'];

  final Map<String, List<Map<String, String>>> products = {
    '의자': [
      {'name': '의자1', 'manufacturer': '제작사 A', 'image': 'assets/chair1.png', 'price': '₩100,000'},
      {'name': '의자2', 'manufacturer': '제작사 B', 'image': 'assets/chair2.png', 'price': '₩120,000'},
      {'name': '의자3', 'manufacturer': '제작사 C', 'image': 'assets/chair3.png', 'price': '₩150,000'},
      {'name': '의자4', 'manufacturer': '제작사 D', 'image': 'assets/chair4.png', 'price': '₩80,000'},
      {'name': '의자5', 'manufacturer': '제작사 E', 'image': 'assets/chair5.png', 'price': '₩110,000'},
      {'name': '의자6', 'manufacturer': '제작사 F', 'image': 'assets/chair6.png', 'price': '₩130,000'},
    ],
    '책상': [
      {'name': '책상1', 'manufacturer': '제작사 G', 'image': 'assets/desk1.png', 'price': '₩200,000'},
      {'name': '책상2', 'manufacturer': '제작사 H', 'image': 'assets/desk2.png', 'price': '₩180,000'},
      {'name': '책상3', 'manufacturer': '제작사 I', 'image': 'assets/desk3.png', 'price': '₩250,000'},
      {'name': '책상4', 'manufacturer': '제작사 J', 'image': 'assets/desk4.png', 'price': '₩220,000'},
    ],
    '소파': [
      {'name': '소파1', 'manufacturer': '제작사 K', 'image': 'assets/sofa1.png', 'price': '₩300,000'},
      {'name': '소파2', 'manufacturer': '제작사 L', 'image': 'assets/sofa2.png', 'price': '₩350,000'},
      {'name': '소파3', 'manufacturer': '제작사 M', 'image': 'assets/sofa3.png', 'price': '₩400,000'},
      {'name': '소파4', 'manufacturer': '제작사 N', 'image': 'assets/sofa4.png', 'price': '₩450,000'},
      {'name': '소파5', 'manufacturer': '제작사 O', 'image': 'assets/sofa5.png', 'price': '₩500,000'},
      {'name': '소파6', 'manufacturer': '제작사 P', 'image': 'assets/sofa6.png', 'price': '₩550,000'},
    ],
    '침대': [
      {'name': '침대1', 'manufacturer': '제작사 Q', 'image': 'assets/bed1.png', 'price': '₩500,000'},
      {'name': '침대2', 'manufacturer': '제작사 R', 'image': 'assets/bed2.png', 'price': '₩450,000'},
      {'name': '침대3', 'manufacturer': '제작사 S', 'image': 'assets/bed3.png', 'price': '₩600,000'},
      {'name': '침대4', 'manufacturer': '제작사 T', 'image': 'assets/bed4.png', 'price': '₩550,000'},
    ],
    '식탁': [
      {'name': '식탁1', 'manufacturer': '제작사 U', 'image': 'assets/table1.png', 'price': '₩400,000'},
      {'name': '식탁2', 'manufacturer': '제작사 V', 'image': 'assets/table2.png', 'price': '₩420,000'},
      {'name': '식탁3', 'manufacturer': '제작사 W', 'image': 'assets/table3.png', 'price': '₩450,000'},
      {'name': '식탁4', 'manufacturer': '제작사 X', 'image': 'assets/table4.png', 'price': '₩480,000'},
      {'name': '식탁5', 'manufacturer': '제작사 Y', 'image': 'assets/table5.png', 'price': '₩500,000'},
      {'name': '식탁6', 'manufacturer': '제작사 Z', 'image': 'assets/table6.png', 'price': '₩530,000'},
    ],
  };
  
  String selectedCategory = '의자';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'FamiliRoom', context: context, isHomePage: true),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              'assets/adv.png',
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: categories.map((category) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedCategory = category;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      child: Text(
                        category,
                        style: TextStyle(
                          fontSize: 16,
                          color: selectedCategory == category ? Colors.green : Colors.black,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  childAspectRatio: 2 / 3,
                ),
                itemCount: products[selectedCategory]!.length,
                
                itemBuilder: (context, index) {
  final product = products[selectedCategory]![index];
  return Container(
    decoration: BoxDecoration(
      color: Colors.grey[200],
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.end, // Align text to the bottom
      children: [
        Container(
          width: 80, // 가로 크기 80
          height: 60, // 세로 크기를 줄입니다 (예: 60으로 설정)
          child: Image.asset(
            product['image']!,
            fit: BoxFit.contain, // 이미지 비율 유지
          ),
        ),
        const SizedBox(height: 4),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                product['price']!, // 가격을 위로 이동
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: 10), // 패딩 10 추가
              Text(
                product['name']!, // 가구 이름
                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey), // 가구 이름을 볼드로 설정
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: 2), // 제작사와의 간격
              Text(
                product['manufacturer']!, // 제작사
                style: const TextStyle(fontSize: 12, color: Colors.grey),
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: 10), // 제작사 아래에 패딩 10 추가
            ],
          ),
        ),
      ],
    ),
  );
},


              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavigationBarWidget(currentIndex: 0),
      floatingActionButton: const ChatFloatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
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
          color: Colors.white, // 전체 배경 흰색으로 설정
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
            elevation: 0, // 그림자 제거
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
      child: Image.asset(
        'assets/chatbot.png',
        color: const Color(0xFF529147), // Apply green color to the icon
        height: 24,
        width: 24,    
      ),
    );
  }
}