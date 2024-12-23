import 'package:flutter/material.dart';
import 'dart:async';
import 'product.dart';
import 'ProductService.dart';
import 'productData.dart';
import 'design_materials.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> categories = ProductCategories.categories;
  Map<String, Future<List<Products>>> products = ProductCategories.products;

  String selectedCategory = '의자';
  String currentImage = 'assets/adv1.png';
  Timer? _timer;
  final List<String> images = [
    'assets/adv1.png',
    'assets/adv2.png',
    'assets/adv3.png',
  ];
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _startImageRotation();
  }

  void _startImageRotation() {
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      _showNextImage();
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
      currentIndex = (currentIndex + 1) % images.length;
      currentImage = images[currentIndex];
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
      body: CustomScrollView(
        slivers: [
          // 광고 이미지
          SliverToBoxAdapter(
            child: Stack(
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
          ),
          
          // 카테고리
          SliverToBoxAdapter(
            child: Container(
              color: const Color(0xFFF5F5F5),
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
          ),
          
          // 추천 상품
          SliverToBoxAdapter(
            child: Padding(
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
                  FutureBuilder<List<Products>>(
                    future: products[selectedCategory],
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(
                          child: Text(
                            '상품이 없습니다.',
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                        );
                      }

                      final productsList = snapshot.data!;
                      return GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 200,
                          mainAxisSpacing: 8,
                          crossAxisSpacing: 8,
                          childAspectRatio: 3 / 4,
                        ),
                        itemCount: productsList.length,
                        itemBuilder: (context, index) {
                          final product = productsList[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProductDetailPage(product: {
                                    'image': product.image,
                                    'price': product.price.toString(),
                                    'name': product.name,
                                    'manufacturer': product.manufacturer,
                                  }),
                                ),
                              );
                            },
                            child: ProductCard(product: product),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const BottomNavigationBarWidget(currentIndex: 0),
      floatingActionButton: const ChatFloatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}

class ProductCard extends StatelessWidget {
  final Products product;

  const ProductCard({required this.product, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
                  child: Image.network(
                    product.image,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // 상품 내용
              Text(
                '${product.price}원',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                product.name,
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
                    product.manufacturer,
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
    );
  }
}
