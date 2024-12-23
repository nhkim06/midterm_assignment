import 'package:flutter/material.dart';
import 'design_materials.dart';


class HeartPage extends StatefulWidget {
  const HeartPage({Key? key}) : super(key: key);

  @override
  _HeartPageState createState() => _HeartPageState();
}

class _HeartPageState extends State<HeartPage> {
  // Sample product data
  final List<Map<String, String>> products = [
    {'name': 'Product 1', 'price': '\$10', 'image': 'assets/bed10.png', 'manufacturer': 'Brand A'},
    {'name': 'Product 2', 'price': '\$15', 'image': 'assets/desk2.png', 'manufacturer': 'Brand B'},
    {'name': 'Product 3', 'price': '\$20', 'image': 'assets/sofa6.png', 'manufacturer': 'Brand C'},
  ];

  // Track the liked status of each product
  List<bool> likedItems = [false, false, false];

  void toggleLike(int index) {
    setState(() {
      likedItems[index] = !likedItems[index]; // Toggle the like status
      if (likedItems[index]) {
        // When liked, keep the product in the list
      } else {
        // Remove the product if unliked
        products.removeAt(index);
        likedItems.removeAt(index);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '찜한 상품',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0.5,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: Colors.grey[300],
            height: 1.0,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: GridView.builder(
        padding: const EdgeInsets.all(8.0),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          childAspectRatio: 3 / 4,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return GestureDetector(
            onTap: () {
            },
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFFF5F5F5),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Product image
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
                    // Product price
                    Text(
                      product['price']!,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 3),
                    // Product name
                    Text(
                      product['name']!,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 3),
                    // Product manufacturer
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          product['manufacturer']!,
                          style: const TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                        IconButton(
                          icon: Icon(
                            likedItems[index] ? Icons.favorite : Icons.favorite_border,
                            color: likedItems[index] ? Colors.red : Colors.grey,
                          ),
                          onPressed: () => toggleLike(index),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: const BottomNavigationBarWidget(currentIndex: 1),
      floatingActionButton: const ChatFloatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
