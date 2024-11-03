import 'package:flutter/material.dart';

final Map<String, List<Map<String, String>>> products = {
  '의자': [
    {'name': '의자1', 'manufacturer': '제작사 A', 'image': 'assets/chair1.png', 'price': '₩100,000', 'id': 'ABCDEF', 'description': '세련된 모던 디자인'},
    // ... 다른 의자 항목
  ],
  '책상': [
    {'name': '책상1', 'manufacturer': '제작사 G', 'image': 'assets/desk1.png', 'price': '₩200,000', 'id': 'ABCDEF', 'description': '세련된 모던 디자인'},
    // ... 다른 책상 항목
  ],
  // 다른 카테고리
};

class CartPage extends StatelessWidget {
  final List<Map<String, String>> cartItems;

  const CartPage({Key? key, required this.cartItems}) : super(key: key);

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
            title: const Text('장바구니', style: TextStyle(color: Colors.black)),
            backgroundColor: Colors.white,
            iconTheme: const IconThemeData(color: Colors.black),
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

class ProductPage extends StatefulWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final List<Map<String, String>> _cartItems = [];

  void _addToCart(Map<String, String> product) {
    setState(() {
      _cartItems.add(product);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('상품 목록')),
      body: ListView.builder(
        itemCount: products['의자']!.length,
        itemBuilder: (context, index) {
          final product = products['의자']![index];
          return Card(
            child: ListTile(
              leading: Image.asset(product['image'] ?? ''),
              title: Text(product['name'] ?? ''),
              subtitle: Text('${product['manufacturer']} - ${product['price']}'),
              trailing: IconButton(
                icon: const Icon(Icons.add_shopping_cart),
                onPressed: () => _addToCart(product),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CartPage(cartItems: _cartItems),
            ),
          );
        },
        child: const Icon(Icons.shopping_cart),
      ),
    );
  }
}



