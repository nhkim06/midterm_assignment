// 장바구니 페이지 (임시 페이지)

import 'package:flutter/material.dart';

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
