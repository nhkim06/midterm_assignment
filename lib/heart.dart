// 좋아요 페이지 (임시 페이지)

import 'package:flutter/material.dart';
import 'design_materials.dart';

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
