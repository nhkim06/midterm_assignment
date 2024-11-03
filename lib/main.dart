import 'dart:async';
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
//검색 페이지 (완)
class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  final List<String> _allItems = [
    "소파", "의자", "테이블", "침대", "책장", "캐비닛"
  ];
  List<String> _filteredItems = [];
  List<String> _recentSearches = [
    "소파", "의자", "테이블", "침대", "책장", "캐비닛"
  ];

  final List<Map<String, String>> _recommendedProducts = [
    {
      'image': 'assets/chair1.png',
      'name': '의자1',
      'manufacturer': '제작사 A',
      'price': '₩100,000',
    },
    {
      'image': 'assets/desk3.png',
      'name': '책상3',
      'manufacturer': '제작사 I',
      'price': '₩250,000',
    },
    {
      'image': 'assets/sofa1.png',
      'name': '소파1',
      'manufacturer': '제작사 K',
      'price': '₩300,000',
    },
  ];
  
  final List<String> _searchRanking = ['상품 A', '상품 B', '상품 C']; 


  @override
  void initState() {
    super.initState();
    _filteredItems = _allItems;
  }

  void _filterItems(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredItems = _allItems;
      } else {
        _filteredItems = _allItems
            .where((item) => item.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  void _navigateToSearch(String item) {
    setState(() {
      _searchController.text = item;
      _filterItems(item);
    });
  }

  void _removeChip(String item) {
    setState(() {
      _recentSearches.remove(item);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Colors.grey[300]!, width: 1),
            ),
          ),
          child: AppBar(
            title: const Text('검색', style: TextStyle(color: Colors.black)),
            backgroundColor: Colors.grey[200],
            iconTheme: const IconThemeData(color: Colors.black),
          ),
        ),
      ),
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  // 검색창
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: '검색어를 입력하세요...',
                      contentPadding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide(color: Colors.green, width: 2.0),
                      ),
                      // 마이크 아이콘
                      prefixIcon: Padding(
                        padding: const EdgeInsets.only(left: 16.0, right: 10.0),
                        child: GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context) {
                                return VoiceRecordBottomSheet();
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
                    onChanged: _filterItems,
                  ),
                ),
                // 검색 아이콘
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.search, color: Colors.black, size: 28),
                  onPressed: () {
                    print('Search query: ${_searchController.text}');
                    _filterItems(_searchController.text);
                  },
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Divider(
              color: Colors.grey,
              thickness: 0.2,
              height: 20,
            ),
            const SizedBox(height: 10),

            // 검색 기록
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: _recentSearches.map((item) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Chip(
                      label: Text(item),
                      onDeleted: () => _removeChip(item),
                      deleteIcon: const Icon(Icons.close, size: 18),
                      deleteIconColor: Colors.grey,
                      backgroundColor: Colors.grey[200],
                      shape: const StadiumBorder(
                        side: BorderSide(color: Colors.grey, width: 0.2),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 32),

            // 검색 랭킹
            Container(
              alignment: Alignment.centerLeft, 
              child: const Text(
                '검색 랭킹',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 100,
              child: ListView.builder(
                itemCount: _searchRanking.length, 
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0), 
                    child: Text(
                      '${index + 1}. ${_searchRanking[index]}', 
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black, 
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 32),

            // 추천 상품 
            Container(
              alignment: Alignment.centerLeft,
              child: const Text(
                '추천상품', 
                style: TextStyle(
                  fontSize: 16, 
                  fontWeight: FontWeight.bold,
                  color: Colors.black, 
                ),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 0.75,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                ),
                itemCount: _recommendedProducts.length,
                itemBuilder: (context, index) {
                  final product = _recommendedProducts[index];
                  return Card(
                    color: Colors.white,
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Center(
                              child: Image.asset(
                                product['image']!,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8.0),
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
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: const ChatFloatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}



// 장바구니 페이지
class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> cartItems = [
      {
        'image': 'assets/chair1.png',
        'name': '의자1',
        'manufacturer': '제작사 A',
        'price': '₩100,000',
      },
      {
        'image': 'assets/desk3.png',
        'name': '책상3',
        'manufacturer': '제작사 I',
        'price': '₩250,000',
      },
      {
        'image': 'assets/sofa1.png',
        'name': '소파1',
        'manufacturer': '제작사 K',
        'price': '₩300,000',
      },
    ];

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Colors.grey[300]!, width: 1),
            ),
          ),
          child: AppBar(
            title: const Text('장바구니'),
            backgroundColor: Colors.white,
          ),
        ),
      ),
      body: cartItems.isEmpty
          ? const Center(child: Text('장바구니가 비어 있습니다.'))
          : ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final item = cartItems[index];
                return Card(
                  child: ListTile(
                    leading: Image.asset(item['image'] ?? ''),
                    title: Text(item['name'] ?? ''),
                    subtitle: Text('${item['manufacturer']} - ${item['price']}'),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        // 삭제 기능 추가
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }
}


//**********하단 페이지**********//
// 홈 페이지 (완)
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
    // Decrement the index and wrap around if needed
    currentIndex = (currentIndex - 1 + images.length) % images.length;
    currentImage = images[currentIndex]; // Update the current image
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

// 스토어 페이지
class StorePage extends StatelessWidget {
  const StorePage({Key? key}) : super(key: key);

   @override
  Widget build(BuildContext context) {
    // Sample manufacturers
    final List<String> manufacturers = [
      '제조사 1',
      '제조사 2',
      '제조사 3',
      '제조사 4',
      '제조사 5',
    ];

    return Scaffold(
      appBar: CustomAppBar(title: '스토어', context: context, isHomePage: false),
      body: ListView.builder(
        itemCount: manufacturers.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(manufacturers[index]),
            onTap: () {
              // Handle manufacturer selection
              Navigator.pop(context, manufacturers[index]);
            },
          );
        },
      ),
      bottomNavigationBar: const BottomNavigationBarWidget(currentIndex: 2),
      floatingActionButton: const ChatFloatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}

// 좋아요 페이지
class HeartPage extends StatelessWidget {
  const HeartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Sample list of liked items
    final List<String> likedItems = [
      '아이템 1',
      '아이템 2',
      '아이템 3',
      '아이템 4',
      '아이템 5',
    ];

    return Scaffold(
      appBar: CustomAppBar(title: '좋아요', context: context, isHomePage: false), // 볼드체 아님
      body: likedItems.isEmpty
          ? const Center(child: Text('좋아하는 아이템이 없습니다.')) // No items message
          : ListView.builder(
              itemCount: likedItems.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text(likedItems[index]),
                     trailing: IconButton(
                      icon: ColorFiltered(
                        colorFilter: const ColorFilter.mode(
                          Colors.red, 
                          BlendMode.srcIn, // Use srcIn to apply the color to the image
                        ),
                        child: Image.asset(
                          'assets/heart.png', // Ensure the correct path to your image asset
                          width: 24,
                          height: 24,
                        ),
                      ),
                      onPressed: () {
                        // Handle removal of liked item
                        // You can implement the logic to remove the item from the list here
                      },
                    ),
                  ),
                );
              },
            ),
      bottomNavigationBar: const BottomNavigationBarWidget(currentIndex: 2),
      floatingActionButton: const ChatFloatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}


// 마이 페이지
class UserPage extends StatelessWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: '마이페이지', context: context, isHomePage: false),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '사용자 정보',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            // User Profile Picture
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage('https://example.com/user_profile.jpg'), // Replace with your user image URL
              ),
            ),
            const SizedBox(height: 16),
            // User Details
            const Text('이름: 홍길동', style: TextStyle(fontSize: 18)),
            const Text('이메일: hong@example.com', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 20),
            // Action Buttons
            ElevatedButton(
              onPressed: () {
                // Implement edit profile functionality
              },
              child: const Text('프로필 수정'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Implement logout functionality
              },
              child: const Text('로그아웃'),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavigationBarWidget(currentIndex: 3),
      floatingActionButton: const ChatFloatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}


//**********기타 페이지**********//
// 상품 페이지 (완)
class ProductDetailPage extends StatefulWidget {
  final Map<String, String> product;

  const ProductDetailPage({Key? key, required this.product}) : super(key: key);

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  bool isLiked = false;
  int likeCount = 41;
  bool showAllReviews = false;

  // Sample reviews
  final List<Map<String, dynamic>> reviews = [
    {
      "user": "사용자1",
      "content": "훌륭한 제품입니다! 품질과 디자인이 정말 마음에 들어요.",
      "rating": 4
    },
    {
      "user": "사용자2",
      "content": "가격 대비 좋은 가치입니다. 다른 사람에게 추천할 것입니다!",
      "rating": 5
    },
    {
      "user": "사용자3",
      "content": "괜찮은 품질이지만 색상이 사진과 약간 다릅니다.",
      "rating": 3
    },
    {
      "user": "사용자4",
      "content": "배송이 빠르고 서비스가 좋았습니다. 매우 만족합니다!",
      "rating": 5
    }
]
;

  double get averageRating {
    if (reviews.isEmpty) return 0.0; // Handle case with no reviews
    double totalRating = reviews.fold(0.0, (sum, review) => sum + review['rating']);
    return totalRating / reviews.length;
  }

  bool showDescription = true;
  bool showReviews = false;
  bool showInquiries = false;

  String selectedInquiryType = '배송'; 
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.product['name']!,
          style: const TextStyle(fontSize: 18),
        ),
        backgroundColor: Colors.white,
        titleTextStyle: const TextStyle(color: Colors.black),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 상품 이미지
              Center(
                child: Image.asset(
                  widget.product['image']!,
                  width: 250,
                  height: 250,
                ),
              ),
              const SizedBox(height: 20),
              // 화살표 아이콘
              Center(
                child: ColorFiltered(
                  colorFilter: const ColorFilter.mode(
                    Colors.grey,
                    BlendMode.srcIn,
                  ),
                  child: Image.asset(
                    'assets/turn.png',
                    width: 50,
                    height: 50,
                  ),
                ),
              ),
              
              const SizedBox(height: 20),
              const Divider(thickness: 0.5, color: Colors.grey),
              const SizedBox(height: 20),
              // 상품 기본 정보
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // 가격 표시
                  Text(
                    widget.product['price']!,
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  // 좋아요
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        if (isLiked) {
                          likeCount--;
                        } else {
                          likeCount++;
                        }
                        isLiked = !isLiked;

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(isLiked ? '좋아요 추가됨' : '좋아요 취소됨'),
                            behavior: SnackBarBehavior.floating,
                            duration: const Duration(seconds: 1),
                          ),
                        );
                      });
                    },
                    child: Row(
                      children: [
                        ColorFiltered(
                          colorFilter: ColorFilter.mode(
                            isLiked ? Colors.red : Colors.grey.withOpacity(0.5),
                            BlendMode.srcIn,
                          ),
                          child: Image.asset(
                            'assets/heart.png',
                            width: 24,
                            height: 24,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text('$likeCount'),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              // 상품 이름과 제조사
              Text(
                widget.product['name']!,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(
                widget.product['manufacturer']!,
                style: const TextStyle(fontSize: 18, color: Colors.grey),
              ),
              const SizedBox(height: 30),

              // 색깔
              const Text(
                '색깔',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  _buildColorCircle(Colors.black),
                  const SizedBox(width: 16),
                  _buildColorCircle(Colors.white),
                  const SizedBox(width: 16),
                  _buildColorCircle(Colors.green),
                  const SizedBox(width: 16),
                  _buildColorCircle(Colors.blue),
                ],
              ),
              const SizedBox(height: 30),

              // 카테고리
              Container(
                color: const Color(0xFFF5F5F5),
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildCategoryButton('상품 정보', () {
                      setState(() {
                        showDescription = true;
                        showReviews = false;
                        showInquiries = false;
                      });
                    }, showDescription),
                    _buildCategoryButton('리뷰', () {
                      setState(() {
                        showReviews = true;
                        showDescription = false;
                        showInquiries = false;
                      });
                    }, showReviews),
                    _buildCategoryButton('문의', () {
                      setState(() {
                        showInquiries = true;
                        showDescription = false;
                        showReviews = false;
                      });
                    }, showInquiries),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // 상품 정보
              if (showDescription) ...[
                const SizedBox(height: 10),
                const Text('상품 정보', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Text('상품 번호: ${widget.product['id']}', style: const TextStyle(fontSize: 16, color: Colors.grey)),
                const SizedBox(height: 10),
                Text('상품 설명: ${widget.product['description']}', style: const TextStyle(fontSize: 16, color: Colors.grey)),
                const SizedBox(height: 40),
                Image.asset('assets/adv_other.png'),
              ],

              // 문의 유형
              if (showInquiries) ...[
                const SizedBox(height: 10),
                const Text('문의', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 30),

                // 문의 유형 선택
                const Text(
                  '문의 유형 (필수)',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                DropdownButton<String>(
                  value: selectedInquiryType,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedInquiryType = newValue!;
                    });
                  },
                  items: <String>['배송', '재입고', '상품상세문의', '기타']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 20),

                // 제목 입력
                const Text(
                  '제목 (필수)',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                TextField(
                  controller: titleController,
                  maxLines: 1,
                  decoration: InputDecoration(
                    labelText: '30자 내로 입력해주세요.',
                    labelStyle: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // 내용 입력
                const Text(
                  '내용 (필수)',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                TextField(
                  controller: contentController,
                  maxLines: 4,
                  decoration: InputDecoration(
                    labelText: '문의할 내용을 입력해주세요.',
                    labelStyle: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // 사진 추가
                const Text(
                  '사진 추가',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                Image.asset(
                  'assets/add_img.png', 
                  width: 70,
                  height: 70,
                  color: Colors.grey,
                ),
                const SizedBox(height: 30),

                // 등록 버튼
                ElevatedButton(
                  onPressed: () {
                    String title = titleController.text.trim();
                    String content = contentController.text.trim();

                    // 오류 메시지 변수
                    String? errorMessage;

                    // 제목과 내용 검증
                    if (title.isEmpty) {
                      errorMessage = '제목을 입력해주세요.';
                    } else if (title.length > 30) {
                      errorMessage = '제목은 30자 이내로 입력해주세요.';
                    } else if (content.isEmpty) {
                      errorMessage = '내용을 입력해주세요.';
                    }

                    // SnackBar 표시
                    if (errorMessage != null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(errorMessage)),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('문의가 접수되었습니다. ')),
                      );
                    }
                  },
                  // 버튼
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey, 
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10), 
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20), 
                  ),
                  child: const Text(
                    '등록',
                    style: TextStyle(
                      color: Colors.white, 
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],


              // 리뷰
              if (showReviews) ...[
                const SizedBox(height: 10),
                const Text('리뷰', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
              // 평균
              Row(
              children: [
                ...List.generate(5, (index) {
                  return Icon(
                    Icons.star,
                    color: index < averageRating ? Colors.amber : Colors.grey,
                    size: 25,
                  );
                }),
                const SizedBox(width: 8), 
                Text(
                  '${averageRating.toStringAsFixed(1)}',
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Divider(
              color: Color(0xFFE0E0E0),  
              thickness: 1.2,        
              indent: 0.0,           
              endIndent: 0.0,        
            ),
            const SizedBox(height: 20),
            // 리뷰 내용
                Column(
                  children: List.generate(
                    showAllReviews ? reviews.length : 2,
                    (index) => Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset(
                                'assets/user.png',
                                width: 24,
                                height: 24,
                                color: Colors.grey,
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      reviews[index]['user']!,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    const SizedBox(height: 3),
                                    Row(
                                      children: List.generate(5, (starIndex) {
                                        return Icon(
                                          Icons.star,
                                          color: starIndex < reviews[index]['rating'] ? Colors.amber : Colors.grey,
                                          size: 16,
                                        );
                                      }),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      reviews[index]['content']!,
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        const SizedBox(height: 20),
                        const Divider(
                          color: Color(0xFFE0E0E0),
                          thickness: 0.5,         
                          indent: 16.0,           
                          endIndent: 16.0,         
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // 리뷰 더보기
              if (reviews.length > 2)
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ReviewPage(reviews: reviews),
                      ),
                    );
                  },
                  child: const Text(
                    '리뷰 더보기',
                    style: TextStyle(
                      color: Colors.green, 
                    ),
                  ),
                ),
              const SizedBox(height: 20),
            ],
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }


  Widget _buildCategoryButton(String title, VoidCallback onTap, bool isSelected) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 16,
            color: isSelected ? Colors.green : Colors.black,
          ),
        ),
      ),
    );
  }

  Widget _buildColorCircle(Color color) {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.grey, width: 1),
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(
            color: Colors.grey.withOpacity(0.3),
            width: 1,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: ElevatedButton(
                onPressed: () {
                  // Cart action
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  side: const BorderSide(color: Colors.green, width: 2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 20),
                ),
                child: const Text(
                  '장바구니',
                  style: TextStyle(color: Colors.green, fontSize: 18),
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: ElevatedButton(
                onPressed: () {
                  // Buy action
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 20),
                ),
                child: const Text(
                  '구매하기',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


// 챗봇 페이지 (완)
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


//리뷰 페이지
class ReviewPage extends StatelessWidget {
  final List<Map<String, dynamic>> reviews;

  const ReviewPage({Key? key, required this.reviews}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('리뷰'),
        backgroundColor: Colors.white,
        titleTextStyle: const TextStyle(color: Colors.black),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Container(
        color: Colors.white, // Set the body background color to white
        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: reviews.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        'assets/user.png',
                        width: 24,
                        height: 24,
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              reviews[index]['user']!,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 3),
                            Row(
                              children: List.generate(5, (starIndex) {
                                return Icon(
                                  Icons.star,
                                  color: starIndex < reviews[index]['rating'] ? Colors.amber : Colors.grey,
                                  size: 16,
                                );
                              }),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              reviews[index]['content']!,
                              style: const TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Divider(
                    color: Color(0xFFE0E0E0), // Line color
                    thickness: 0.5,          // Line thickness
                    indent: 16.0,            // Left margin
                    endIndent: 16.0,         // Right margin
                  ),
                ],
              ),
            );
          },
        ),
      ),
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


//**********채팅**********//
//유저 채팅
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
            color: Colors.green.shade100, // Background color for user message
            borderRadius: BorderRadius.circular(20), // Rounded corners
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8), // Padding inside the container
          child: Text(
            message,
            style: const TextStyle(
              fontSize: 16, // Font size for the text
              color: Colors.black, // Text color
            ),
          ),
        ),
        const SizedBox(width: 8), // Spacing between message and avatar
      ],
    );
  }
}

//챗봇 채팅
class ChatbotChat extends StatelessWidget {
  final String message;

  const ChatbotChat({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 24, // Set the radius of the circle
          backgroundColor: const Color(0xFFD5FDC1), // Set background color of the avatar
          child: Image.asset(
            'assets/chatbot.png',
            color: const Color(0xFF529147), // Apply light green color to the icon
            height: 24,
            width: 24,
          ),
        ),
        const SizedBox(width: 8), // Spacing between avatar and text
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8), // Padding inside the container
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20), // Rounded corners
            border: Border.all(color: Colors.grey), // Optional border
          ),
          child: Text(
            message,
            style: const TextStyle(
              fontSize: 16, // Font size for the text
              color: Colors.black, // Text color
            ),
          ),
        ),
      ],
    );
  }
}

//챗봇 가구 추천
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
            const SizedBox(width: 58), // Increase spacing between images
            _buildImageContainer('assets/desk2.png'),
            const SizedBox(width: 8), // Increase spacing between images
            _buildImageContainer('assets/sofa3.png'),
            const SizedBox(width: 8), // Increase spacing between images
            _buildImageContainer('assets/table2.png'),
          ],
        ),
      ],
    );
  }

  Widget _buildImageContainer(String imagePath) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey), // Border color
        borderRadius: BorderRadius.circular(8), // Rounded corners for the border
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8), // Ensure image corners are rounded
        child: Image.asset(
          imagePath,
          width: 60,
          height: 60,
          fit: BoxFit.cover, // Ensures the image covers the container
        ),
      ),
    );
  }
}


//**********음성 인식**********//
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
