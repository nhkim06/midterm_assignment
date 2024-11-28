// 홈 페이지 (UI완)

import 'package:flutter/material.dart';
import 'dart:async';
import 'product.dart';
import 'design_materials.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> categories = ['의자', '책상', '소파', '침대', '식탁'];

  final Map<String, List<Map<String, String>>> products = {  //상품 데이터
    '의자': [
      {'name': '의자1', 'manufacturer': '제작사 A', 'image': 'assets/chair1.png', 'price': '₩100,000', 'id' : 'ABCDEF', 'description' : '세련된 모던 디자인으로 어떤 인테리어에도 잘 어울립니다. 다양한 색상 옵션으로 개인의 취향에 맞춰 선택할 수 있습니다.'},
      {'name': '의자2', 'manufacturer': '제작사 B', 'image': 'assets/chair2.png', 'price': '₩120,000', 'id' : 'ABCDEF', 'description' : '세련된 모던 디자인으로 어떤 인테리어에도 잘 어울립니다. 다양한 색상 옵션으로 개인의 취향에 맞춰 선택할 수 있습니다.'},
      {'name': '의자3', 'manufacturer': '제작사 C', 'image': 'assets/chair3.png', 'price': '₩150,000', 'id' : 'ABCDEF', 'description' : '세련된 모던 디자인으로 어떤 인테리어에도 잘 어울립니다. 다양한 색상 옵션으로 개인의 취향에 맞춰 선택할 수 있습니다.'},
      {'name': '의자4', 'manufacturer': '제작사 D', 'image': 'assets/chair4.png', 'price': '₩80,000', 'id' : 'ABCDEF', 'description' : '세련된 모던 디자인으로 어떤 인테리어에도 잘 어울립니다. 다양한 색상 옵션으로 개인의 취향에 맞춰 선택할 수 있습니다.'},
      {'name': '의자5', 'manufacturer': '제작사 E', 'image': 'assets/chair5.png', 'price': '₩110,000', 'id' : 'ABCDEF', 'description' : '세련된 모던 디자인으로 어떤 인테리어에도 잘 어울립니다. 다양한 색상 옵션으로 개인의 취향에 맞춰 선택할 수 있습니다.'},
      {'name': '의자6', 'manufacturer': '제작사 F', 'image': 'assets/chair6.png', 'price': '₩130,000', 'id' : 'ABCDEF', 'description' : '세련된 모던 디자인으로 어떤 인테리어에도 잘 어울립니다. 다양한 색상 옵션으로 개인의 취향에 맞춰 선택할 수 있습니다.'},
    ],
    '책상': [
      {'name': '책상1', 'manufacturer': '제작사 G', 'image': 'assets/desk1.png', 'price': '₩200,000', 'id' : 'ABCDEF', 'description' : '세련된 모던 디자인으로 어떤 인테리어에도 잘 어울립니다. 다양한 색상 옵션으로 개인의 취향에 맞춰 선택할 수 있습니다.'},
      {'name': '책상2', 'manufacturer': '제작사 H', 'image': 'assets/desk2.png', 'price': '₩180,000', 'id' : 'ABCDEF', 'description' : '세련된 모던 디자인으로 어떤 인테리어에도 잘 어울립니다. 다양한 색상 옵션으로 개인의 취향에 맞춰 선택할 수 있습니다.'},
      {'name': '책상3', 'manufacturer': '제작사 I', 'image': 'assets/desk3.png', 'price': '₩250,000', 'id' : 'ABCDEF', 'description' : '세련된 모던 디자인으로 어떤 인테리어에도 잘 어울립니다. 다양한 색상 옵션으로 개인의 취향에 맞춰 선택할 수 있습니다.'},
      {'name': '책상4', 'manufacturer': '제작사 J', 'image': 'assets/desk4.png', 'price': '₩220,000', 'id' : 'ABCDEF', 'description' : '세련된 모던 디자인으로 어떤 인테리어에도 잘 어울립니다. 다양한 색상 옵션으로 개인의 취향에 맞춰 선택할 수 있습니다.'},
    ],
    '소파': [
      {'name': '소파1', 'manufacturer': '제작사 K', 'image': 'assets/sofa1.png', 'price': '₩300,000', 'id' : 'ABCDEF', 'description' : '세련된 모던 디자인으로 어떤 인테리어에도 잘 어울립니다. 다양한 색상 옵션으로 개인의 취향에 맞춰 선택할 수 있습니다.'},
      {'name': '소파2', 'manufacturer': '제작사 L', 'image': 'assets/sofa2.png', 'price': '₩350,000', 'id' : 'ABCDEF', 'description' : '세련된 모던 디자인으로 어떤 인테리어에도 잘 어울립니다. 다양한 색상 옵션으로 개인의 취향에 맞춰 선택할 수 있습니다.'},
      {'name': '소파3', 'manufacturer': '제작사 M', 'image': 'assets/sofa3.png', 'price': '₩400,000', 'id' : 'ABCDEF', 'description' : '세련된 모던 디자인으로 어떤 인테리어에도 잘 어울립니다. 다양한 색상 옵션으로 개인의 취향에 맞춰 선택할 수 있습니다.'},
      {'name': '소파4', 'manufacturer': '제작사 N', 'image': 'assets/sofa4.png', 'price': '₩450,000', 'id' : 'ABCDEF', 'description' : '세련된 모던 디자인으로 어떤 인테리어에도 잘 어울립니다. 다양한 색상 옵션으로 개인의 취향에 맞춰 선택할 수 있습니다.'},
      {'name': '소파5', 'manufacturer': '제작사 O', 'image': 'assets/sofa5.png', 'price': '₩500,000', 'id' : 'ABCDEF', 'description' : '세련된 모던 디자인으로 어떤 인테리어에도 잘 어울립니다. 다양한 색상 옵션으로 개인의 취향에 맞춰 선택할 수 있습니다.'},
      {'name': '소파6', 'manufacturer': '제작사 P', 'image': 'assets/sofa6.png', 'price': '₩550,000', 'id' : 'ABCDEF', 'description' : '세련된 모던 디자인으로 어떤 인테리어에도 잘 어울립니다. 다양한 색상 옵션으로 개인의 취향에 맞춰 선택할 수 있습니다.'},
    ],
    '침대': [
      {'name': '침대1', 'manufacturer': '제작사 Q', 'image': 'assets/bed1.png', 'price': '₩500,000', 'id' : 'ABCDEF', 'description' : '세련된 모던 디자인으로 어떤 인테리어에도 잘 어울립니다. 다양한 색상 옵션으로 개인의 취향에 맞춰 선택할 수 있습니다.'},
      {'name': '침대2', 'manufacturer': '제작사 R', 'image': 'assets/bed2.png', 'price': '₩450,000', 'id' : 'ABCDEF', 'description' : '세련된 모던 디자인으로 어떤 인테리어에도 잘 어울립니다. 다양한 색상 옵션으로 개인의 취향에 맞춰 선택할 수 있습니다.'},
      {'name': '침대3', 'manufacturer': '제작사 S', 'image': 'assets/bed3.png', 'price': '₩600,000', 'id' : 'ABCDEF', 'description' : '세련된 모던 디자인으로 어떤 인테리어에도 잘 어울립니다. 다양한 색상 옵션으로 개인의 취향에 맞춰 선택할 수 있습니다.'},
      {'name': '침대4', 'manufacturer': '제작사 T', 'image': 'assets/bed4.png', 'price': '₩550,000', 'id' : 'ABCDEF', 'description' : '세련된 모던 디자인으로 어떤 인테리어에도 잘 어울립니다. 다양한 색상 옵션으로 개인의 취향에 맞춰 선택할 수 있습니다.'},
    ],
    '식탁': [
      {'name': '식탁1', 'manufacturer': '제작사 U', 'image': 'assets/table1.png', 'price': '₩400,000', 'id' : 'ABCDEF', 'description' : '세련된 모던 디자인으로 어떤 인테리어에도 잘 어울립니다. 다양한 색상 옵션으로 개인의 취향에 맞춰 선택할 수 있습니다.'},
      {'name': '식탁2', 'manufacturer': '제작사 V', 'image': 'assets/table2.png', 'price': '₩420,000', 'id' : 'ABCDEF', 'description' : '세련된 모던 디자인으로 어떤 인테리어에도 잘 어울립니다. 다양한 색상 옵션으로 개인의 취향에 맞춰 선택할 수 있습니다.'},
      {'name': '식탁3', 'manufacturer': '제작사 W', 'image': 'assets/table3.png', 'price': '₩450,000', 'id' : 'ABCDEF', 'description' : '세련된 모던 디자인으로 어떤 인테리어에도 잘 어울립니다. 다양한 색상 옵션으로 개인의 취향에 맞춰 선택할 수 있습니다.'},
      {'name': '식탁4', 'manufacturer': '제작사 X', 'image': 'assets/table4.png', 'price': '₩480,000', 'id' : 'ABCDEF', 'description' : '세련된 모던 디자인으로 어떤 인테리어에도 잘 어울립니다. 다양한 색상 옵션으로 개인의 취향에 맞춰 선택할 수 있습니다.'},
      {'name': '식탁5', 'manufacturer': '제작사 Y', 'image': 'assets/table5.png', 'price': '₩500,000', 'id' : 'ABCDEF', 'description' : '세련된 모던 디자인으로 어떤 인테리어에도 잘 어울립니다. 다양한 색상 옵션으로 개인의 취향에 맞춰 선택할 수 있습니다.'},
      {'name': '식탁6', 'manufacturer': '제작사 Z', 'image': 'assets/table6.png', 'price': '₩530,000', 'id' : 'ABCDEF', 'description' : '세련된 모던 디자인으로 어떤 인테리어에도 잘 어울립니다. 다양한 색상 옵션으로 개인의 취향에 맞춰 선택할 수 있습니다.'},
    ],
  };
String selectedCategory = '의자';
String currentImage = 'assets/adv1.png';
Timer? _timer;

// List of advertisement images
final List<String> images = [
  'assets/adv1.png',
  'assets/adv2.png',
  'assets/adv3.png',
  // 광고 이미지 추가
];

// Current index of the image being displayed
int currentIndex = 0;

@override
void initState() {
  super.initState();
  _startImageRotation();
}

void _startImageRotation() {
  _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
    _showNextImage(); // Show the next image every 5 seconds
  });
}

void _showPrevImage() {
  setState(() {
    currentIndex = (currentIndex - 1 + images.length) % images.length;
    currentImage = images[currentIndex]; 
  });
}

void _showNextImage() {
  setState(() {
    // Increment the index and wrap around if needed
    currentIndex = (currentIndex + 1) % images.length;
    currentImage = images[currentIndex]; // Update the current image
  });
}

@override
void dispose() {
  _timer?.cancel();
  super.dispose();
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'FamiliRoom', context: context, isHomePage: true),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 광고 이미지
            Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  currentImage,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  left: 16, 
                  child: Opacity(
                    opacity: 0.5,
                    child: GestureDetector(
                      onTap: _showPrevImage,
                      child: Image.asset(
                        'assets/prev.png', 
                        width: 35,
                        height: 35,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: 16, 
                  child: Opacity(
                    opacity: 0.5, 
                    child: GestureDetector(
                      onTap: _showNextImage, 
                      child: Image.asset(
                        'assets/next.png',
                        width: 35,
                        height: 35, 
                      ),
                    ),
                  ),
                ),
              ],
            ),
            // 카테고리
            Container(
              color: Color(0xFFF5F5F5),
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
            // 추천 상품 텍스트 
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '추천상품',
                    style: TextStyle(
                      fontSize: 16, 
                      fontWeight: FontWeight.bold, 
                      color: Colors.black, 
                    ),
                  ),
                  const SizedBox(height: 16),
                  // 상품
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200, 
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                      childAspectRatio: 3 / 4,
                    ),
                    itemCount: products[selectedCategory]!.length,
                    itemBuilder: (context, index) {
                      final product = products[selectedCategory]![index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductDetailPage(product: product),
                            ),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFFF5F5F5),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          // 카드
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 18.0), 
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // 상품 이미지
                                  Center(
                                    child: Container(
                                      width: 80,
                                      height: 60,
                                      child: Image.asset(
                                        product['image']!,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 20), 

                                  // 상품 내용
                                  Text(
                                    product['price']!,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  const SizedBox(height: 3),
                                  Text(
                                    product['name']!,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  const SizedBox(height: 3), 
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        product['manufacturer']!,
                                        style: const TextStyle(fontSize: 12, color: Colors.grey),
                                      ),
                                      Image.asset(
                                        'assets/heart.png',
                                        width: 16,
                                        height: 16,
                                        color: Colors.grey,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
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
