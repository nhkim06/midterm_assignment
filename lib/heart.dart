import 'package:flutter/material.dart';
import 'design_materials.dart';
import 'ProductService.dart';
import 'productData.dart';


class HeartPage extends StatefulWidget {
  const HeartPage({Key? key}) : super(key: key);

  @override
  _HeartPageState createState() => _HeartPageState();
}

class _HeartPageState extends State<HeartPage> {
  final List<String> categories = ProductCategories.categories;
  Map<String, Future<List<Products>>> products = ProductCategories.products;

  Future<void> _unlikeProduct(Products product) async {
    try {
      final updatedProduct = Products(
        id: product.id,
        name: product.name,
        price: product.price,
        image: product.image,
        likes: product.likes - 1,
        selected: false,
        manufacturer: product.manufacturer,
        description: product.description,
      );
      String productType = '';
      if (product.image.contains('chair')) {
        productType = 'chairs';
      } else if (product.image.contains('sofa')) {
        productType = 'sofas'; 
      } else if (product.image.contains('desk')) {
        productType = 'desks';
      } else if (product.image.contains('bed')) {
        productType = 'beds';
      } else if (product.image.contains('table')) {
        productType = 'tables';
      }
      await ProductService.updateProduct(updatedProduct, productType);
      await ProductService.refreshProducts();
      setState(() {
        products = ProductCategories.products;
      });
    } catch (e) {
      print('Error updating product: $e');
    }
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
      body: FutureBuilder<List<List<Products>>>(
        future: Future.wait([
          products[categories[0]]!, // chairs
          products[categories[1]]!, // sofas  
          products[categories[2]]!, // desks
          products[categories[3]]!, // tables
          products[categories[4]]!, // beds
        ]),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No liked items'));
          }

          final allLikedProducts = snapshot.data!
              .expand((products) => products)
              .where((p) => p.selected)
              .toList();

          if (allLikedProducts.isEmpty) {
            return const Center(child: Text('No liked items'));
          }

          return GridView.builder(
            padding: const EdgeInsets.all(8.0),
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              childAspectRatio: 3 / 4,
            ),
            itemCount: allLikedProducts.length,
            itemBuilder: (context, index) {
              final product = allLikedProducts[index];
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
                              product.image,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        // Product price
                        Text(
                          product.price.toString(),
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 3),
                        // Product name
                        Text(
                          product.name,
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
                              product.manufacturer,
                              style: const TextStyle(fontSize: 12, color: Colors.grey),
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.favorite,
                                color: Colors.red,
                              ),
                              onPressed: () async {
                                await _unlikeProduct(product);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('찜하기가 해제되었습니다'),
                                    duration: Duration(seconds: 1),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: const BottomNavigationBarWidget(currentIndex: 1),
      floatingActionButton: const ChatFloatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
