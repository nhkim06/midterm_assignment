//검색 페이지 (UI완)

import 'package:flutter/material.dart';
import 'design_materials.dart';


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

